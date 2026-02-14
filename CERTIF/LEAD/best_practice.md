# Bonnes pratiques pour les lead architectes (IA/Data)

*Documentation vivante* : Mise à jour trimestrielle pour intégrer les retours terrain et les évolutions technologiques. (**Office Viewer**)

> Note : Il ne s’agit pas d’un guide à appliquer à la lettre mais d’une base méthodologique. Tout dépend fortement du contexte.

---

## Introduction

Le rôle de **lead architecte IA/Data** est central pour transformer les enjeux métiers en solutions techniques robustes, évolutives et alignées sur la valeur business. Ce guide synthétise les bonnes pratiques, outils et astuces pour chaque phase du projet, de la compréhension du besoin à la livraison et l’amélioration continue.

**Transverse au Software Engineering :** Principes SOLID; Design Pattern (MVC, etc.); Regles de programmation (CRUD, snake_case, etc.)

---

## Rôle et responsabilités

### Alignement stratégique

- Traduire les objectifs business en choix techniques (ex : batch vs streaming, monolithique vs microservices).
- **Exemple** : Pour un besoin de réactivité, privilégier une architecture event-driven (Kafka, Pulsar).

### Gouvernance

- Définir des standards (nomenclature, qualité de code, sécurité, RGPD).
- **Astuce** : Créer un *Tech Radar* interne pour guider les choix technologiques et éviter les solutions "hype" non matures.

### Risques à éviter

- Sous-estimer la dette technique ou les coûts de maintenance.
- Adopter une technologie sans évaluer son TRL (Technology Readiness Level) ou son adéquation au besoin.
- **Astuce management** : Avoir un objectif long terme, mais décomposer les sous-taches (SMART) pour J+1 sur un agenda (max)

---

## Méthodologie détaillée

**Préambule :** La méthodo est dépendante du [Cycle de développement](https://fr.wikipedia.org/wiki/Cycle_de_d%C3%A9veloppement_(logiciel)). Pour simplifier, lorsqu'on est dans le domaine du **Hardware**, on retrouve du **Cycle en V**, lorsqu'on est dans le **Sofware**, on est plus souvent confronté à des méthodes agiles **Scrum/Lean**, voire de l'extreme programming.

### 1. Comprendre le besoin

**Objectif** : Clarifier le contexte, les attentes et les contraintes pour éviter les malentendus et les dérives.

#### Outils et méthodes

- **Bête à cornes**

  - **Pourquoi** : 80% des échecs de projets viennent d’un besoin mal compris.
  - **Comment** :
    1. **À quoi ça sert ?** → "Réduire les fraudes de 30%."
    2. **Pour qui ?** → "Équipe risque et clients finaux."
    3. **Quelles contraintes ?** → "RGPD (chiffrage et anonymisation), latence < 1s, budget < 50k€."
  - **Astuce** : Organiser un atelier de 1h avec les métiers pour valider le besoin.
  - **Implicite** : Permet d'initier la comprehension de la problématique et des attentes du clients pour la mission (profils, durée, coût, livrable).
- **Diagramme de contexte**

  - **Exemple** :
    ```plaintext
    [Client] --> (API Front) --> [Modèle IA] --> (Base de données)
                  ^               |              ^
                  |              v              |
    [CRM] -----------------------[Logging]-------
    ```
  - **Astuce** : Utiliser le *C4 Model* pour les architectures complexes.
- **Objectifs SMART**

  - **Exemple** : "Détecter 95% des fraudes en <500ms d’ici Q1 2026."
  - **À éviter** : Des objectifs flous comme "améliorer l’expérience client."
- **Astuces** :

  - Faire une lexique des acronymes et termes techniques avec leurs définitions pour éviter les confusions. Ex : CRM = "Customer relationship management" en gestion, mais aussi CRM = "coefficient de réduction-majoration" dans les assurances.

  Lexique du consultant : 
  - AT : Assistance Technique
  - Catalogue : 
  - CdC : Cahier des Charges
  - UO : Unité d'oeuvre
  - EDM : Engagement delivery management
  - PTF ou propole : Proposition technique et financiere
  - MCT : Mémo coordination technique 
  - Framing
  - Scoping

---

### 2. État de l’art et analyse

**Objectif** : Évaluer les solutions existantes et leur adéquation au besoin. (Mais aussi ce qu'y est déjà fait chez le client / en internes)

- **Benchmark technologique**

Benchmark technologique

| Outil      | Avantages           | Inconvénients          |
| ---------- | ------------------- | ----------------------- |
| TensorFlow | Écosystème mature | Courbe d’apprentissage |
| PyTorch    | Flexibilité        | Moins industrialisé    |

- **TRL (Technology Readiness Level)
  *Necessaire pour identifier la maturité !***

  - **Astuce** :
    - PoC : TRL 3-4.
    - MVP : TRL 6-7.
    - Production : TRL 7+.
  - **Exemple** : Un modèle de NLP custom a un TRL 4 (validé en labo).
- **QCDP (Qualité, Coût, Délai, Performance)**

QCDP / Matrice de décision

| Critère | Exigence                 | Priorité (1-5) |
| -------- | ------------------------ | --------------- |
| Qualité | Précision modèle > 90% | 5               |
| Coût    | Budget < 50k€           | 4À             |

- **Analyse VRIO**

  - **Question clé** : "Cette solution nous donne-t-elle un avantage concurrentiel durable ?"
  - **Exemple** : Un algorithme propriétaire de scoring = avantage (VRIO positif).
- **ROI et KPI**

  - **Formule** : ROI = (Gains - Coûts) / Coûts.
  - **Astuce** : Inclure les coûts cachés (formation, maintenance, cloud).
- **Remarques** : Ces outils peuvent également etre utilisé en cas de construction du *Business Model* (voir Business Model Canvas pour plus de détails).

---

### 3. Conception de la solution

**Objectif** : Définir une architecture fonctionnelle et technique alignée sur les besoins. (uniquement Macro)

- **BPMN (Business Process Model and Notation)**

  - **Exemple** : Processus de validation de prêt :
    ```plaintext
    [Client] --> [Soumettre demande] --> [Vérification IA] --> [Décision]
    ```
  - **Astuce** : Utiliser `bpmn.io` pour des modèles collaboratifs.
- **SADT (Structured Analysis and Design Technique)**

  - **Niveaux** :
    - A-0 : Vue globale (ex : "Système de recommandation").
    - A0 : Sous-systèmes (ex : "Moteur de règles", "Modèle ML").
  - **À éviter** : Des diagrammes trop détaillés trop tôt.
- **Modèle Kano**

Modèle Kano

| Fonctionnalité         | Type        | Priorité |
| ----------------------- | ----------- | --------- |
| Prédiction temps réel | Performante | Haute     |

- **Roadmap technique**

Roadmap technique

| Livrable       | Durée | Risques      | Atténuation             |
| -------------- | ------ | ------------ | ------------------------ |
| API de scoring | 3 sem  | Latence > 1s | Tests de charge précoce |

Permet d'estimer le chiffrage (durée / JH / TJM)

- **RACI**

Modèle RACI : Définition des rôles et responsabilités (matrice workpackage/role)


- **Exigence** :

Definir fonction principale et contrainte. Must / Have rules. MoSCoW

---

### 4. Développement

**Objectif** : Implémenter les fonctionnalités (lien avec les exigences) et traçabilité.

- **Example Mapping**

  - **Exemple** :
    - **Règle métier** : "Un client gold a un plafond de crédit de 10k€."
    - **Scénario** :
      ```gherkin
      Given un client gold
      When il demande un crédit de 8k€
      Then le système approuve
      ```
- **DDD (Domain-Driven Design)**

  - **Bonnes pratiques** :
    - Séparer les *bounded contexts* (ex : "Facturation" vs "Recommandation").
    - **Astuce** : Utiliser des `value objects` pour les règles métiers (ex : `Money`, `Percentage`).
- **Tests**

  - **Stratégie** :
    - Tests unitaires : 80% de couverture sur le code critique.
    - Tests d’intégration : Valider les interactions entre services.
  - **Exemple (Python)** :
    ```python
    def test_score_fraude():
        assert calculer_score(client_gold) == "FAIBLE"
    ```
- **Matrice de traçabilité**

Matrice de traçabilité

| Exigence        | Test associé      | Statut  |
| --------------- | ------------------ | ------- |
| Latence < 500ms | test_performance() | ✅ Pass |

---

### 5. Livraison et amélioration continue

**Objectif** : Livrer une solution fiable et planifier les itérations.

- **AMDEC (Analyse des Modes de Défaillance)**

AMDEC

| Risque               | Cause           | Effet      | Action préventive      |
| -------------------- | --------------- | ---------- | ----------------------- |
| Défaillance API CRM | Timeout réseau | Erreur 500 | Retry + circuit breaker |

- **Tests E2E**

  - **Outils** : Selenium (UI), Postman (API), Locust (charge).
  - **Astuce** : Automatiser les tests de non-régression dans le pipeline CI/CD.
- **PDCA (Plan-Do-Check-Act)**

  - **Exemple** :
    - **Plan** : Réduire la latence de 20%.
    - **Do** : Optimiser les requêtes SQL et le caching.
    - **Check** : Mesurer avec Prometheus/Grafana.
    - **Act** : Déployer en canary release.

---

## Spécialisation DATA/IA

### Exploration des données

- **Astuces** :
  - Utiliser `Great Expectations` pour valider la qualité des données.
  - **Exemple** :
    ```python
    from great_expectations.dataset import PandasDataset
    df = PandasDataset(read_csv("data.csv"))
    results = df.expect_column_values_to_not_be_null("client_id")
    ```

### Bases de données

- **Choix technologiques** :

  - **Data Warehouse** : Snowflake (SQL), Databricks (Spark).
  - **Data Lake** : Delta Lake (versioning), Iceberg (open format).
  - **Temps réel** : Kafka + Flink pour le streaming. Lambda également.
- **ACID et ArangoDB**

  - **Cas d’usage** : ArangoDB pour les graphes (ex : réseau social).
  - **À éviter** : MongoDB pour des transactions financières (manque de garanties ACID).



### Focus : Métiers et Outils de l'Analyse (Complément)

| Catégories | Compétences | Analyst | Scientist | Engineer | ML Engineer |
| --- | --- | --- | --- | --- | --- |
| **Axes Principaux** | **Data Visualization** | **5** | 3 | 2 | 2 |
|  | **Storytelling / Business** | **5** | 3 | 1 | 2 |
|  | **Statistics** | 3 | **5** | 2 | 3 |
|  | **Machine Learning** | 2 | **5** | 1 | 4 |
|  | **Software Engineering** | 2 | 3 | 4 | **5** |
|  | **MLOps / Deployment** | 1 | 2 | 3 | **5** |
|  | **Data Pipelines (ETL)** | 2 | 2 | **5** | 4 |
|  | **Database Management** | 3 | 2 | **5** | 3 |
| **Intermédiaires** | **Reporting** (Analyst/Engineer) | **4** | 2 | **4** | 2 |
|  | **Experimentation** (Scientist/Analyst) | **4** | **4** | 1 | 2 |
|  | **Optimization** (Scientist/ML Eng) | 1 | **4** | 2 | **4** |
|  | **System Design** (Engineer/ML Eng) | 1 | 1 | **4** | **4** |


* **Matrice des profils** : Distinguer l'**Analyst** (Insights), le **Scientist** (Modèles), l'**Engineer** (Pipelines) et le **ML Engineer** (Prod) via leurs radars de compétences.
* **Piliers Analyst** : Structurer autour de la **Data Viz** (clarté), le **Reporting** (KPIs), l'**Insight** (opportunités) et le **Storytelling** (décision).
* **Stack BI Open Source** : Privilégier **Metabase** (simplicité), **Apache Superset** (puissance) ou **Looker Studio** (gratuit/cloud) pour limiter les coûts. Airbyte (synchronisation des flux/interopérabilité)
* **Approche Low-Code** : Utiliser **KNIME** pour des flux de préparation de données visuels, facilitant la passation entre profils métiers et techniques. Utiliser DBeaver pour l'exploration et le contrôle qualité.
* **Data-as-Code** : Adopter des outils comme **Evidence.dev** pour générer des rapports en Markdown, liant directement SQL et narration technique. Intégrer dbt (data build tool) pour transformer les données en SQL tout en générant automatiquement le lignage (lineage) et la documentation technique.

Modern Data Stack (MDS). L'idée clé est la modularité : on sépare l'extraction (Airbyte), la transformation (dbt) et l'exposition (Superset/Evidence).

---

## Modélisation IA

- **Biais/Variance**

  - **Diagnostic** :
    - **High bias** : Erreur d’entraînement et de test élevées → Modèle trop simple.
    - **High variance** : Erreur de test >> entraînement → Overfitting.
  - **Astuce** : Utiliser `sklearn.model_selection.LearningCurve`.
- **Pipeline ML**

  - **Exemple avec MLflow** :
    ```python
    with mlflow.start_run():
        mlflow.log_param("n_estimators", 100)
        mlflow.sklearn.log_model(model, "model")
    ```

---

## Infrastructure et DevOps

- **Git**

  - **Branching** : GitFlow pour les releases, Trunk-Based Development pour l’agilité.
- **Terraform** : Infrastructure as Code

  - **Astuce** : Modulariser les configurations (ex : `modules/kafka`, `modules/postgres`).
- **Docker** : Gestion des service via Docker-compose ou Kubernetes

  - **Bonnes pratiques** :
    - Multi-stage builds pour réduire la taille des images.
    - **Exemple** :
      ```dockerfile
      FROM python:3.9-slim as builder
      COPY . .
      RUN pip install -r requirements.txt
      FROM python:3.9-slim
      COPY --from=builder /app /app
      ```

---

## Management d’équipe

- **Leadership situationnel**

Leadership situationnel

| Compétence \ Motivation | Faible  | Moyenne  | Élevée   |
| ------------------------ | ------- | -------- | ---------- |
| Faible                   | Diriger | Encadrer | Déléguer |

- **Astuce** : Pour un junior motivé, donner des tâches challengeantes avec mentorat.
- **Comité de pilotage**

  - **Template de reporting** :
    - Avancement : Burndown chart.
    - Risques : Top 3 avec plans d’action.

---

## Annexes

- **Template ADR (Architecture Decision Record)**

  ```markdown
  # Titre de la décision
  **Statut** : Proposé / Accepté / Obsolète
  **Contexte** : Pourquoi cette décision ?
  **Options** : Solutions envisagées.
  **Décision** : Solution retenue et justification.
  **Conséquences** : Impact à court/long terme.
  ```
- **Checklist pré-livraison**

  - [ ] Tests unitaires/integration passés.
  - [ ] Documentation mise à jour (README, Swagger, schémas).
  - [ ] Backup des données critiques.
  - [ ] Plan de rollback testé.

---

## Conclusion

Ce guide est un **cadre évolutif** pour les lead architectes IA/Data.
**Astuce finale** :

- Documenter chaque compromis (ex : "On sacrifie 5% de précision pour diviser par 2 la latence").
- Utiliser des *ADR* pour justifier les choix techniques et faciliter la maintenance.
