# wave_autogluon_prod.py
"""
Pipeline de maintenance prédictive industriel.
Régulation SOLID, AutoML (AutoGluon), Tracking (MLflow) et Explicabilité.
"""

import logging
import mlflow
import numpy as np
import pandas as pd
import pywt
from autogluon.tabular import TabularPredictor
from sklearn.model_selection import train_test_split

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


# =====================================================================
# 1. PRÉPARATION & FEATURE ENGINEERING (SOLID : Single Responsibility)
# =====================================================================
class MaintenanceDataProcessor:
    """Génère les signaux vibratoires et extrait les features par ondelettes."""

    def __init__(self, wavelet: str = "db4", window_size: int = 10):
        self.wavelet = wavelet
        self.window_size = window_size

    def generate_synthetic_data(self, n_points: int = 1000) -> pd.DataFrame:
        np.random.seed(42)
        time = np.linspace(0, 100, n_points)
        signal = np.sin(time) + np.random.normal(0, 0.2, n_points)

        target = np.zeros(n_points)
        fault_indices = np.random.choice(range(n_points), size=50, replace=False)
        for idx in fault_indices:
            signal[idx : idx + 5] += np.random.normal(2, 0.5)
            target[idx : idx + 5] = 1

        return pd.DataFrame(
            {"timestamp": time, "vibration": signal, "failure": target}
        )

    def _get_wavelet_energy(self, window: np.ndarray) -> float:
        """Calcule l'énergie des coefficients de détail (haute fréquence)."""
        _, c_detail = pywt.dwt(window, self.wavelet)
        return float(np.sum(np.square(c_detail)))

    def transform(self, df: pd.DataFrame, col: str = "vibration") -> pd.DataFrame:
        """Applique la transformation par fenêtre glissante."""
        df_out = df.copy()
        df_out["wavelet_energy"] = (
            df_out[col]
            .rolling(window=self.window_size)
            .apply(self._get_wavelet_energy)
        )
        return df_out.dropna().drop(columns=["timestamp"])


# =====================================================================
# 2. ENTRAÎNEMENT AUTOML & TRACKING (Liaison AutoGluon / MLflow)
# =====================================================================
class AutoMLProductionTrainer:
    """Gère l'entraînement AutoGluon et le versioning des artefacts."""

    def __init__(self, label: str = "failure", time_limit: int = 300):
        self.label = label
        self.time_limit = time_limit
        self.predictor = None

    def train(self, train_data: pd.DataFrame) -> TabularPredictor:
        logger.info("Démarrage de l'AutoML (AutoGluon)...")

        # Configuration orientée Production (Ensembles de modèles robustes)
        self.predictor = TabularPredictor(
            label=self.label,
            eval_metric="recall",  # Votre priorité business
            path="autogluon_models/",
        ).fit(
            train_data=train_data,
            time_limit=self.time_limit,
            presets="best_quality",  # Active le Stacking/Bagging automatique
            auto_stack=True,
        )
        return self.predictor

    def log_to_mlflow(self, test_data: pd.DataFrame):
        """Log les performances de l'AutoML et l'artefact final."""
        if not self.predictor:
            raise ValueError("Le modèle doit être entraîné d'abord.")

        # Évaluation sur le Jail/Test set
        performance = self.predictor.evaluate(test_data)
        leaderboard = self.predictor.leaderboard(test_data, silent=True)

        # Log MLflow
        mlflow.log_metrics(
            {
                "test_recall": performance.get("recall", 0.0),
                "test_f1": performance.get("f1", 0.0),
                "test_accuracy": performance.get("accuracy", 0.0),
            }
        )
        # Sauvegarde du leaderboard en CSV comme artefact de run
        leaderboard.to_csv("leaderboard.csv", index=False)
        mlflow.log_artifact("leaderboard.csv")
        logger.info("Métriques et leaderboard enregistrés dans MLflow.")


# =====================================================================
# 3. EXPLICABILITÉ (Intégration SHAP avec AutoGluon)
# =====================================================================
class AutoMLExplainer:
    """Gère l'explicabilité de la boîte noire générée par l'AutoML."""

    @issue_warning_if_slow  # Wrapper fictif ou log si SHAP prend du temps sur l'ensemble
    def analyze(self, predictor: TabularPredictor, test_data: pd.DataFrame):
        logger.info("Calcul des valeurs SHAP pour le wrapper AutoGluon...")
        # Fonction wrapper pour rendre AutoGluon compatible avec SHAP
        def model_predict(data_frame):
            return predictor.predict_proba(data_frame)[1].values

        # On isole les features
        x_test = test_data.drop(columns=[predictor.label])
        
        # Utilisation de KernelExplainer (car AutoGluon est un ensemble multi-framework)
        import shap
        # Échantillonnage pour accélérer le calcul en prod/CI
        background = x_test.sample(n=min(50, len(x_test)), random_state=42)
        explainer = shap.KernelExplainer(model_predict, background)
        shap_values = explainer.shap_values(x_test.head(20))
        
        logger.info("Analyse SHAP terminée avec succès.")
        # Ici vous pouvez générer vos plots comme dans votre code initial


# =====================================================================
# ORCHESTRATION PIPELINE
# =====================================================================
if __name__ == "__main__":
    mlflow.set_experiment("Prod_Maintenance_AutoGluon")

    with mlflow.start_run():
        # 1. Data Pipeline
        processor = MaintenanceDataProcessor()
        raw = processor.generate_synthetic_data()
        dataset = processor.transform(raw)

        train, test = train_test_split(
            dataset, test_size=0.2, stratify=dataset["failure"], random_state=42
        )

        # 2. AutoML Engine
        trainer = AutoMLProductionTrainer(time_limit=120)
        predictor_blackbox = trainer.train(train)

        # 3. Matures features (Tracking & Interp)
        trainer.log_to_mlflow(test)
        
        explainer = AutoMLExplainer()
        explainer.analyze(predictor_blackbox, test)