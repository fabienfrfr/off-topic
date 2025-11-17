"""
Demo multi-tâches illustrant le paradoxe de Simpson avec classification et régression,
Code demonstratif pour générer un test techniques datascience (à completer et assisté par IA).

Adapter par problématique, par exemple :
- **Industrie** : Analyse de la qualité de production entre deux usines, où chaque ligne de production locale a une tendance inverse à la tendance globale.
- **Finance** : Analyse des performances de portefeuilles d’investissement ; la rentabilité globale masque des comportements opposés selon la classe d’actifs ou la région.
- **Santé** : Étude des taux de guérison d’un traitement sur plusieurs hôpitaux avec efficacité globale mais inefficacité dans certains groupes d’âge ou sévérité.
- **Marketing** : Analyse des taux de conversion par canal de distribution avec une inversion entre les performances globales et celles segmentées par région ou profil client.
- **Ressources humaines** : Étude des salaires moyens au sein d’une entreprise où la moyenne globale masque des différences inverses entre cadres et ouvriers selon les départements.
- **Éducation** : Comparaison des résultats scolaires selon différentes filières ou niveaux d’enseignement, avec inversion des tendances entre groupes et global.
- **Écologie** : Croissance des plantes selon type de sol et climat, avec des effets inverses entre sous-groupes qui contrastent avec la moyenne globale.
- **Transport** : Analyse des temps de trajet selon modes de transport (train, voiture) et zones géographiques montrant des tendances locales inverses à la tendance globale.
- **Sport** : Performances d’athlètes selon type d’entraînement avec inversion des effets selon les groupes d’âge (jeunes vs seniors).
- **Assurance** : Sinistralité globale d’un portefeuille clients où les sous-groupes d’assurés (selon âge ou type de contrat) montrent des tendances contraires à la moyenne.
- **Télécommunications** : Analyse de la satisfaction client selon type de service (mobile, internet) et région, avec des tendances inverses entre segments et global.
- **Agriculture** : Rendement des cultures selon techniques agricoles et conditions climatiques, avec des effets inverses entre sous-groupes.
- **Tourisme** : Analyse des préférences de voyage selon type de destination et saison, avec inversion des tendances entre groupes et global.
- **Immobilier** : Étude des prix de l’immobilier selon quartiers et types de biens, avec des tendances locales inverses à la tendance globale.
- **Alimentation** : Préférences alimentaires selon catégories de consommateurs (végétariens, omnivores) et régions, avec des effets inverses entre sous-groupes.
- **Énergie** : Consommation énergétique selon types de bâtiments (résidentiel, commercial) et zones climatiques, avec des tendances inverses entre segments et global.
- **Logistique** : Analyse des délais de livraison selon modes de transport et régions, avec inversion des effets selon les sous-groupes.

Garder le principe de programmation SOLID !
"""

import numpy as np
import pandas as pd
from sklearn.datasets import make_classification
from sklearn.model_selection import (
    train_test_split,
    learning_curve,
    StratifiedKFold,
    cross_val_score,
)
from sklearn.ensemble import RandomForestClassifier, RandomForestRegressor
from sklearn.metrics import (
    classification_report,
    mean_squared_error,
    precision_recall_curve,
    auc,
)
from sklearn.calibration import CalibrationDisplay
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from sklearn.inspection import PartialDependenceDisplay
from mapie.classification import MapieClassifier
import shap
import mlflow
import mlflow.sklearn
import matplotlib.pyplot as plt
import seaborn as sns
from scipy import stats
from imblearn.over_sampling import SMOTE
import statsmodels.api as sm


# =============================================
# 1. Génération des données
# =============================================
class DataGenerator:
    """Génère un dataset synthétique avec paradoxe de Simpson."""

    def __init__(self, random_state=42):
        self.random_state = random_state
        self.data = None

    def generate(self):
        """Génère les données avec paradoxe de Simpson."""
        X, y_class = make_classification(
            n_samples=1000,
            n_features=10,
            n_informative=6,
            n_classes=2,
            weights=[0.7, 0.3],
            flip_y=0.05,
            class_sep=1.2,
            random_state=self.random_state,
        )
        self.data = pd.DataFrame(X, columns=[f"feat_{i}" for i in range(10)])
        self.data["target_class"] = y_class
        rng = np.random.default_rng(self.random_state)
        self.data["subgroup"] = rng.choice([0, 1], size=len(self.data), p=[0.7, 0.3])
        mask0 = self.data["subgroup"] == 0
        mask1 = self.data["subgroup"] == 1
        self.data.loc[mask0, "feat_1"] = self.data.loc[mask0, "feat_0"] + rng.normal(
            0, 0.5, mask0.sum()
        )
        self.data.loc[mask1, "feat_1"] = -self.data.loc[mask1, "feat_0"] + rng.normal(
            0, 0.5, mask1.sum()
        )
        noise = rng.normal(0, 1, len(self.data))
        self.data["target_reg"] = (
            3 * self.data["feat_0"]
            - 2 * self.data["feat_1"]
            + 5 * self.data["target_class"]
            + noise
        )
        return self.data


# =============================================
# 2. Séparation des données
# =============================================
class DataSplitter:
    """Sépare les données en train/test."""

    def __init__(self, random_state=42):
        self.random_state = random_state

    def split(self, data):
        """Sépare les données en train/test."""
        features = [f"feat_{i}" for i in range(10)]
        X = data[features]
        y_class = data["target_class"]
        y_reg = data["target_reg"]
        return train_test_split(
            X,
            y_class,
            y_reg,
            stratify=y_class,
            test_size=0.25,
            random_state=self.random_state,
        )


# =============================================
# 3. Entraînement des modèles
# =============================================
class ModelTrainer:
    """Entraîne les modèles de classification et régression."""

    def __init__(self, random_state=42):
        self.random_state = random_state
        self.clf = None
        self.reg = None

    def train(self, X_train, y_train_class, y_train_reg):
        """Entraîne les modèles avec gestion du déséquilibre (SMOTE)."""
        smote = SMOTE(random_state=self.random_state)
        X_res, y_res = smote.fit_resample(X_train, y_train_class)
        self.clf = RandomForestClassifier(
            n_estimators=100, random_state=self.random_state, class_weight="balanced"
        )
        self.clf.fit(X_res, y_res)
        self.reg = RandomForestRegressor(
            n_estimators=100, random_state=self.random_state
        )
        self.reg.fit(X_train, y_train_reg)
        return self.clf, self.reg


# =============================================
# 4. Évaluation des modèles
# =============================================
class ModelEvaluator:
    """Évalue les modèles avec métriques, cross-validation et calibration."""

    def evaluate(self, clf, reg, X_test, y_test_class, y_test_reg):
        """Évalue les modèles et log les métriques dans MLflow."""
        # Cross-validation
        cv = StratifiedKFold(n_splits=5)
        cv_scores = cross_val_score(
            clf, X_test, y_test_class, cv=cv, scoring="accuracy"
        )
        print(
            f"Cross-validation accuracy: {np.mean(cv_scores):.3f} (±{np.std(cv_scores):.3f})"
        )

        # Métriques de classification
        y_pred_class = clf.predict(X_test)
        class_report = classification_report(
            y_test_class, y_pred_class, output_dict=True
        )
        print("Classification report (test):")
        print(classification_report(y_test_class, y_pred_class))

        # AUC-PR
        precision, recall, _ = precision_recall_curve(
            y_test_class, clf.predict_proba(X_test)[:, 1]
        )
        auprc = auc(recall, precision)
        print(f"AUC-PR: {auprc:.3f}")

        # Métriques de régression
        y_pred_reg = reg.predict(X_test)
        rmse = mean_squared_error(y_test_reg, y_pred_reg, squared=False)
        print(f"Regression RMSE (test): {rmse:.3f}")

        # Calibration
        CalibrationDisplay.from_estimator(clf, X_test, y_test_class)
        plt.title("Calibration plot")
        plt.show()

        # Logging MLflow
        mlflow.log_metric("classification_accuracy", class_report["accuracy"])
        mlflow.log_metric(
            "classification_f1_macro", class_report["macro avg"]["f1-score"]
        )
        mlflow.log_metric("classification_AUPRC", auprc)
        mlflow.log_metric("regression_rmse", rmse)

        return class_report, rmse, auprc


# =============================================
# 5. Analyse Bias-Variance
# =============================================
class BiasVarianceAnalyzer:
    """Analyse le biais/variance via des courbes d'apprentissage."""

    def analyze(self, clf, X_train, y_train_class):
        """Génère et affiche la courbe d'apprentissage."""
        train_sizes, train_scores, test_scores = learning_curve(
            clf,
            X_train,
            y_train_class,
            cv=5,
            scoring="accuracy",
            train_sizes=np.linspace(0.1, 1.0, 10),
        )
        plt.figure()
        plt.plot(train_sizes, np.mean(train_scores, axis=1), label="Training score")
        plt.plot(
            train_sizes, np.mean(test_scores, axis=1), label="Cross-validation score"
        )
        plt.title("Courbe d'apprentissage (Bias-Variance)")
        plt.xlabel("Training examples")
        plt.ylabel("Score")
        plt.legend()
        plt.show()


# =============================================
# 6. Analyse PCA
# =============================================
class PCAAnalyzer:
    """Réduit la dimensionnalité et visualise les sous-groupes."""

    def analyze(self, X_train, data):
        """Applique PCA et visualise les sous-groupes."""
        scaler = StandardScaler()
        X_scaled = scaler.fit_transform(X_train)
        pca = PCA(n_components=2)
        X_pca = pca.fit_transform(X_scaled)
        plt.scatter(
            X_pca[:, 0],
            X_pca[:, 1],
            c=data.loc[X_train.index, "subgroup"],
            alpha=0.6,
        )
        plt.title("PCA : Visualisation des sous-groupes")
        plt.xlabel("Composante 1")
        plt.ylabel("Composante 2")
        plt.show()


# =============================================
# 7. Visualisation du paradoxe de Simpson
# =============================================
class SimpsonParadoxVisualizer:
    """Visualise et teste statistiquement le paradoxe de Simpson."""

    def visualize(self, data):
        """Visualise le paradoxe de Simpson et teste l'interaction."""
        sns.lmplot(
            data=data,
            x="feat_0",
            y="feat_1",
            hue="subgroup",
            lowess=True,
            height=5,
            aspect=1.2,
        )
        plt.title("Paradoxe de Simpson : corrélation inversée par sous-groupe")
        plt.show()

        # Test d'interaction avec statsmodels
        X_sm = sm.add_constant(data[["feat_0", "feat_1", "subgroup"]])
        X_sm["feat_0_subgroup"] = X_sm["feat_0"] * X_sm["subgroup"]
        model = sm.OLS(data["target_reg"], X_sm).fit()
        print(model.summary())


# =============================================
# 8. Test statistique
# =============================================
class StatisticalTester:
    """Effectue des tests statistiques sur les erreurs de régression."""

    def test(self, reg, X_test, y_test_reg, data):
        """Test t de Student sur les erreurs entre sous-groupes."""
        errors_group0 = (
            reg.predict(X_test[data.loc[X_test.index, "subgroup"] == 0])
            - y_test_reg[data.loc[X_test.index, "subgroup"] == 0]
        )
        errors_group1 = (
            reg.predict(X_test[data.loc[X_test.index, "subgroup"] == 1])
            - y_test_reg[data.loc[X_test.index, "subgroup"] == 1]
        )
        t_stat, p_value = stats.ttest_ind(errors_group0, errors_group1)
        print(
            f"Test t de Student sur les erreurs de régression : p-value = {p_value:.4f}"
        )


# =============================================
# 9. Analyse SHAP
# =============================================
class SHAPAnalyzer:
    """Génère les explications SHAP pour les modèles."""

    def analyze(self, clf, reg, X_test):
        """Génère les summary plots et dépendance plots SHAP."""
        # Classification
        shap_clf_exp = shap.TreeExplainer(clf)
        shap_vals_clf = shap_clf_exp.shap_values(X_test)
        print("SHAP summary (Classification)")
        shap.summary_plot(shap_vals_clf[1], X_test, plot_type="bar")

        # Régression
        shap_reg_exp = shap.TreeExplainer(reg)
        shap_vals_reg = shap_reg_exp.shap_values(X_test)
        print("SHAP summary (Regression)")
        shap.summary_plot(shap_vals_reg, X_test, plot_type="bar")

        # Dépendance plot
        shap.dependence_plot(
            "feat_0",
            shap_vals_reg,
            X_test,
            interaction_index="feat_1",
            color=X_test["feat_1"],
        )


# =============================================
# 10. MAPIE pour intervalles de confiance
# =============================================
class MAPIEAnalyzer:
    """Calcule les intervalles de confiance avec MAPIE."""

    def analyze(self, clf, X_train, y_train_class, X_test):
        """Calcule et affiche les intervalles de confiance."""
        mapie = MapieClassifier(clf, method="score", random_state=42)
        mapie.fit(X_train, y_train_class)
        preds, preds_pis = mapie.predict(X_test, alpha=0.1)
        print(f"MAPIE classification 90% CI of first test example: {preds_pis[0]}")
        return mapie


# =============================================
# 11. Logging MLflow
# =============================================
class MLflowLogger:
    """Logge les modèles, paramètres et artefacts dans MLflow."""

    def log(self, clf, reg, params):
        """Logge les modèles et artefacts."""
        mlflow.log_params(params)
        mlflow.sklearn.log_model(clf, "random_forest_classifier")
        mlflow.sklearn.log_model(reg, "random_forest_regressor")
        plt.savefig("learning_curve.png")
        mlflow.log_artifact("learning_curve.png")


# =============================================
# 12. Classe principale pour orchestrer le tout
# =============================================
class SimpsonParadoxDemo:
    """Classe principale pour orchestrer l'ensemble du pipeline."""

    def __init__(self, random_state=42):
        self.random_state = random_state
        self.data_generator = DataGenerator(random_state)
        self.data_splitter = DataSplitter(random_state)
        self.model_trainer = ModelTrainer(random_state)
        self.model_evaluator = ModelEvaluator()
        self.bias_variance_analyzer = BiasVarianceAnalyzer()
        self.pca_analyzer = PCAAnalyzer()
        self.simpson_visualizer = SimpsonParadoxVisualizer()
        self.statistical_tester = StatisticalTester()
        self.shap_analyzer = SHAPAnalyzer()
        self.mapie_analyzer = MAPIEAnalyzer()
        self.mlflow_logger = MLflowLogger()

    def run(self):
        """Exécute l'ensemble du pipeline."""
        mlflow.set_experiment("MultiTask_SimpsonParadox")
        with mlflow.start_run():
            # 1. Génération des données
            print("Generating synthetic data with Simpson's paradox...")
            data = self.data_generator.generate()

            # 2. Séparation des données
            print("Splitting data...")
            X_train, X_test, y_train_class, y_test_class, y_train_reg, y_test_reg = (
                self.data_splitter.split(data)
            )

            # 3. Entraînement des modèles
            print("Training models...")
            clf, reg = self.model_trainer.train(X_train, y_train_class, y_train_reg)

            # 4. Évaluation des modèles
            print("Evaluating models and logging metrics...")
            class_report, rmse, auprc = self.model_evaluator.evaluate(
                clf, reg, X_test, y_test_class, y_test_reg
            )

            # 5. Analyse Bias-Variance
            print("Bias-Variance analysis...")
            self.bias_variance_analyzer.analyze(clf, X_train, y_train_class)

            # 6. Analyse PCA
            print("PCA analysis...")
            self.pca_analyzer.analyze(X_train, data)

            # 7. Visualisation du paradoxe de Simpson
            print("Visualizing Simpson's paradox...")
            self.simpson_visualizer.visualize(data)

            # 8. Test statistique
            print("Running statistical tests...")
            self.statistical_tester.test(reg, X_test, y_test_reg, data)

            # 9. Analyse SHAP
            print("Running SHAP interpretability analysis...")
            self.shap_analyzer.analyze(clf, reg, X_test)

            # 10. MAPIE
            print("Computing MAPIE confidence intervals...")
            mapie = self.mapie_analyzer.analyze(clf, X_train, y_train_class, X_test)

            # 11. Logging MLflow
            print("Logging models to MLflow...")
            self.mlflow_logger.log(
                clf,
                reg,
                {
                    "n_estimators": 100,
                    "class_weight": "balanced",
                    "random_state": self.random_state,
                },
            )
            print("Run complete.")


# =============================================
# Exécution
# =============================================
if __name__ == "__main__":
    demo = SimpsonParadoxDemo()
    demo.run()
