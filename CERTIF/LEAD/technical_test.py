"""
Demo multi-tâches illustrant le paradoxe de Simpson avec classification et régression,
incluant l'utilisation de MAPIE pour les intervalles de confiance et SHAP pour l'interprétabilité.
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
"""

import numpy as np
import pandas as pd
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier, RandomForestRegressor
from sklearn.metrics import classification_report, mean_squared_error
from mapie.classification import MapieClassifier
import shap
import mlflow
import mlflow.sklearn
import matplotlib.pyplot as plt


class MultiTaskDemoWithMLflow:
    """
    Exemple pédagogique d'apprentissage multitâche mixte (classification + régression)
    illustrant le paradoxe de Simpson et intégrant logging MLflow.

    Fonctionnalités principales :
    - Génération de données synthétiques avec paradoxe de Simpson.
    - Entraînement séparé d'un modèle de classification et d'un modèle de régression.
    - Évaluation standard et intervalle de confiance MAPIE pour la classification.
    - Explication globale des modèles avec SHAP values.
    - Tracking avancé avec MLflow : logging des paramètres, métriques, modèles et artefacts.
    """

    def __init__(self, random_state=42):
        self.random_state = random_state
        self.data = None
        self.X_train = None
        self.X_test = None
        self.y_train_class = None
        self.y_test_class = None
        self.y_train_reg = None
        self.y_test_reg = None
        self.clf = None
        self.reg = None
        self.mapie = None
        self.shap_clf_exp = None
        self.shap_reg_exp = None

    def generate_data(self):
        """
        Génère un dataset synthétique avec :
        - Deux classes déséquilibrées.
        - Paradoxe de Simpson entre feat_0 et feat_1 via un sous-groupe inversé.
        - Cible classification binaire.
        - Cible régression continue dépendante des features et de la classe.

        Le paradoxe illustre la nécessité d'analyser par segments (sous-groupes).
        """
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

        # Corrélation positive dans chaque sous-groupe entre feat_0 et feat_1
        self.data.loc[mask0, "feat_1"] = self.data.loc[mask0, "feat_0"] + rng.normal(
            0, 0.5, mask0.sum()
        )
        # Dans le sous-groupe minoritaire, on inverse feat_0 pour inverser cette corrélation globale
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

    def split_data(self):
        features = [f"feat_{i}" for i in range(10)]
        X = self.data[features]
        y_class = self.data["target_class"]
        y_reg = self.data["target_reg"]
        (
            self.X_train,
            self.X_test,
            self.y_train_class,
            self.y_test_class,
            self.y_train_reg,
            self.y_test_reg,
        ) = train_test_split(
            X,
            y_class,
            y_reg,
            stratify=y_class,
            test_size=0.25,
            random_state=self.random_state,
        )

    def train_models(self):
        self.clf = RandomForestClassifier(
            n_estimators=100, random_state=self.random_state
        )
        self.clf.fit(self.X_train, self.y_train_class)

        self.reg = RandomForestRegressor(
            n_estimators=100, random_state=self.random_state
        )
        self.reg.fit(self.X_train, self.y_train_reg)

    def evaluate_models(self):
        y_pred_class = self.clf.predict(self.X_test)
        class_report = classification_report(
            self.y_test_class, y_pred_class, output_dict=True
        )
        print("Classification report (test) :")
        print(classification_report(self.y_test_class, y_pred_class))

        y_pred_reg = self.reg.predict(self.X_test)
        rmse = mean_squared_error(self.y_test_reg, y_pred_reg, squared=False)
        print(f"Regression RMSE (test) : {rmse:.3f}")

        # Logging métriques dans MLflow
        mlflow.log_metric("classification_accuracy", class_report["accuracy"])
        mlflow.log_metric(
            "classification_f1_macro", class_report["macro avg"]["f1-score"]
        )
        mlflow.log_metric("regression_rmse", rmse)

    def mapie_classification(self):
        self.mapie = MapieClassifier(
            self.clf, method="score", random_state=self.random_state
        )
        self.mapie.fit(self.X_train, self.y_train_class)
        preds, preds_pis = self.mapie.predict(self.X_test, alpha=0.1)
        print(f"MAPIE classification 90% CI of first test example: {preds_pis[0]}")

    def shap_analysis(self):
        self.shap_clf_exp = shap.TreeExplainer(self.clf)
        shap_vals_clf = self.shap_clf_exp.shap_values(self.X_test)
        print("SHAP summary (Classification)")
        shap.summary_plot(shap_vals_clf[1], self.X_test, plot_type="bar")

        self.shap_reg_exp = shap.TreeExplainer(self.reg)
        shap_vals_reg = self.shap_reg_exp.shap_values(self.X_test)
        print("SHAP summary (Regression)")
        shap.summary_plot(shap_vals_reg, self.X_test, plot_type="bar")

    def log_models(self):
        # Log des modèles dans MLflow (artefacts)
        mlflow.sklearn.log_model(self.clf, "random_forest_classifier")
        mlflow.sklearn.log_model(self.reg, "random_forest_regressor")

    def run_all(self):
        mlflow.set_experiment("MultiTask_SimpsonParadox")
        with mlflow.start_run():
            print("Generating synthetic data with Simpson's paradox...")
            self.generate_data()

            print("Splitting data...")
            self.split_data()

            print("Training models...")
            self.train_models()

            print("Evaluating models and logging metrics...")
            self.evaluate_models()

            print("Computing MAPIE confidence intervals...")
            self.mapie_classification()

            print("Running SHAP interpretability analysis...")
            self.shap_analysis()

            print("Logging models to MLflow...")
            self.log_models()

            print("Run complete.")


if __name__ == "__main__":
    demo = MultiTaskDemoWithMLflow()
    demo.run_all()
