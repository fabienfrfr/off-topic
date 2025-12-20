# 📌 GUIDE — Réussir sa présentation

(À adapter selon le contexte : entretien, réseau, LinkedIn, client, etc.)

> Note : Exemple personnel à adapter à chaque profil et contexte. Il ne s’agit pas d’un texte à recopier à la lettre mais d’une base méthodologique.

---

## Présentation (Pitch 30s–2min) — Méthode STAR

*(Situation, Tâche, Action, Résultat)*

Je suis **Lead Data & AI Engineer**, spécialisé à l’interface entre **recherche appliquée, industrialisation des solutions IA** et **compréhension des besoins métiers**.

Docteur en physique avec une spécialisation en **computer vision/statistiques**, j’ai débuté en **recherche appliquée** (algorithmes d’optimisation à l’INSEP/CNAM), puis évolué vers l’industrie (opportunité plusieurs domaines et techno) :

- **Coordination R&D** chez Capgemini (10 docteurs, energie et automobile). Mes rôles :
  - Participation au cadrage technique avec les architectes, analyse des cahiers des charges pour identifier les profils nécessaires et développer des assets internes afin de faire monter l’équipe en compétence
  - Anticipation de la demande : lors de l’émergence des LLM, développement d’un outil de diagnostic assisté
- **Senior Data Scientist** chez Thales sur la maintenance prédictive et la logistique radar (Salon du Bourget)
  - Cadrage, création de valeur, architecture, développement agile (Compétence software)
- Actuellement : **Expert IA et avant-vente** (Airbus, Liebherr, Safran)
  - Analyse de faisabilité (graphes de connaissance, nez électronique…)
  - Pilotage d’un projet de recalage 2D–3D en contexte de production

**Mon approche :** Toujours partir du problème métier avant la solution technique. Actuellement, je recherche des rôles de Lead Data Scientist avec des perspectives vers l’architecture de solutions.

*Phrase de conclusion suggérée (qualités en filigrane, pas de justification directe) : Adaptabilité et rigueur — savoir changer de focale entre recherche, produit et client.*

**Bonus** : Activité de recherche comme TPTT.

---

## Questions classiques

### Entretien non technique : commercial, RH, manager

| **Question**            | **Réponse type**                                                                                                                                                                                                                  |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Qu’est-ce qui vous motive ? | Résoudre des problèmes**concrets** avec l’IA. Comprendre les besoins du client. Apprendre de nouvelles technos. *(ex :)* …                                                                                                  |
| Vos points forts ?           | 1)**Analyser des problèmes complexes** (ex : cadrage chez Airbus) ; 2) **Proposer des solutions réalistes** (ex : MVP avant automatisation totale) ; 3) **Fédérer des équipes** autour d’un objectif commun. |
| Un échec ?                  | Un projet où j’ai sous-estimé la qualité des données (2 semaines de retard). Depuis, je commence systématiquement par un**audit data** — même si cela ralentit le début, ça évite les mauvaises surprises.              |

### Entretien technique

| **Question**                                   | **Réponse (30–60 s)**                                                                                                                                                                                                                                                                                                  |
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Comment évalues-tu la qualité des données ?      | Je vérifie : complétude (valeurs manquantes <5%), cohérence (plages réalistes), représentativité (collent-elles à la réalité terrain ?), stabilité (pas de variations brutales dans le temps). Exemple : projet de maintenance, exclusion de 3% de données de température aberrantes après validation métier. |
| Quels outils pour détecter la qualité ?           | Pandas (stats descriptives), Great Expectations (règles métiers), visualisation (boxplots), tests statistiques (KS test). Exemple : test de chi2 sur données catégorielles.                                                                                                                                               |
| Gérer les données manquantes ?                    | Selon le contexte : suppression (<5% et aléatoires), imputation (médiane, mode), modèles avancés (KNNImputer). Exemple : scoring client, imputation médiane par tranche d’âge.                                                                                                                                        |
| Démarrer un projet data-mining/ML ?                | 1) Comprendre le besoin métier, 2) Explorer les données, 3) Prétraiter, 4) Modéliser (simpler > complex), 5) Valider (métriques techniques & métiers). Exemple : clustering K-means → clustering hiérarchique.                                                                                                        |
| Expliquer un modèle à un non-technicien ?         | J’utilise des analogies : Arbre de décision = “jeu de questions/réponses”, Régression linéaire = “règle cause/effet”, Réseau de neurones = “bureau de poste” (chaque employé traite une partie de l’information). Exemple : scoring de transactions pour la fraude.                                           |
| Outils pour rendre un modèle interprétable ?      | SHAP/LIME (explications individuelles), Feature Importance, Partial Dependence Plots. Exemple : SHAP → l’âge contribue à 40% du score crédit, ce qui a amené à corriger le modèle pour éviter les biais.                                                                                                             |
| Évaluer l’interprétabilité d’un modèle ?      | 1) Compréhensibilité (un non-tech comprend-il la logique ?), 2) Actionnabilité, 3) Fidélité (le modèle se comporte-t-il comme en prod ?). Exemple : arbre décision préférée à un réseau de neurones pour raison d’explicabilité opérateur.                                                                   |
| Indicateurs pour un modèle de classification ?     | Précision, Recall, F1-score, AUC-ROC, Matrice de confusion (choix adapté à l’objectif métier). Exemple : recall 99% privilégié dans un projet médical.                                                                                                                                                                |
| Mesures de performance pour la régression ?        | R², RMSE, MAE, MAPIE (intervalles de confiance). Exemple : prédiction de ventes, MAPIE utilisé pour fournir des fourchettes aux commerciaux.                                                                                                                                                                               |
| Précision vs interprétabilité ?                  | On choisit selon l’usage. Interprétabilité (diagnostic médical → arbre), Précision (détection fraude), Ex : Random Forest préféré à un réseau de neurones vu le besoin d’explications.                                                                                                                           |
| Monitoring modèle en production ?                  | 1) Monitoring performance, 2) Data drift, 3) Concept drift, 4) Feedback utilisateur. Exemple : alertes en cas de drift ou chute de précision sous un seuil.                                                                                                                                                                  |
| Gérer un désaccord technique (client/collègue) ? | 1) Écoute, 2) Options/arguments, 3) Tester par les faits (PoC/A-B test). Exemple : comparaison de deux approches sur un échantillon pour trancher rapidement.                                                                                                                                                               |
| Prioriser dans un projet data/ia ?                  | Impact métier ; dépendances ; risques. Ex : nettoyer avant modélisation, MVP rapide avant itérations. Heuristique avant une modélisation complète (OR-Tools)                                                                                                                                                          |
| Expliquer un concept technique à un non-tech ?     | Analogies du quotidien. Ex: Data Drift = “une recette qui ne marche plus car la farine a changé”, Overfitting = “apprendre par cœur un exam mais échouer en pratique”…                                                                                                                                                 |
| Questions à poser sur un nouveau projet ?          | 1) Objectif métier, 2) Données dispo et qualité, 3) KPIs de succès, 4) Contraintes techniques, 5) Utilisateurs finaux. Exemple : projet maintenance — l’interprétabilité était prioritaire.                                                                                                                          |

**Notes comparaison Humain/ML :**

| Méthode           | Taux de détection (approx.) | Remarque                                                                                                                             |
| ------------------ | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| Technicien humain  | 50–80 %                    | Dépend de la formation, de l’expérience, du temps dispo, des outils et de la nature des anomalies (visuelles, bruit, vibration…) |
| Modèle IA avancé | 90–95 %                    | Données temporelles, capteurs, apprentissage supervisé ou non                                                                      |

**Difficulté :** Bonne qualité des donnée, et données annotés, verifié par des experts métiers.

**Astuce** :

- N’hésite pas à reformuler les questions et demander des précision/clarification.
- Prendre du temps pour répondre, l'important c'est l'expression de la logique et le raisonnement.
- Proposer des exemples simples et avoir les bases mathématiques (loi statistique, biais/variance, cross-validation).
- Etre honnete sur l'usage de LLM pour aider à coder/datascience. D'ailleurs en GenAI, on ne fait presque pas d'entrainement, c'est plus des compétences de software qui sont necessaires.


### Entretiens Executive (CTO/CEO) -- BONUS

Dans le pitch, transmettre l'idée : "Mon rôle est de sécuriser vos engagements en garantissant la faisabilité technique des projets et la montée en compétence des équipes, pour transformer l'innovation en valeur métier."

Question Orientation Business :

| Question | Enjeu réel | Réponse factuelle |
| :--- | :--- | :--- |
| **"Comment éviter l'effet POC ?"** | Rentabilité & Industrialisation. | "Anticiper les contraintes de production (MLOps, sécurité) dès le cadrage pour aligner le TRL sur les besoins du client." |
| **"Si un client veut une techno inadaptée ?"** | Conseil & Courage technique. | "Expliquer les risques de maintenance et de dérive, puis proposer une alternative plus robuste qui sécurise le ROI." |
| **"Comment piloter une équipe sur un gros budget ?"** | Scalabilité & Qualité. | "Standardiser les pratiques (SOLID, ADR) pour garantir que l'excellence opérationnelle soit constante, peu importe la taille de l'équipe." |
| **"Quelle est la principale menace pour l'IA ?"** | Lucidité métier. | "La perte de vue du KPI business. L'IA doit répondre à un gain opérationnel concret, pas seulement à une performance statistique." |

Questions Stratégiques à poser (partenariat) :

| Thématique | Question à poser | Objectif |
| :--- | :--- | :--- |
| **Stratégie Offre** | "Quelle est la priorité actuelle de votre portefeuille : l'innovation de rupture ou l'optimisation des coûts ?" | Comprendre les enjeux financiers. |
| **Gouvernance** | "Comment arbitrez-vous entre l'usage d'assets internes et les solutions Cloud natives pour vos clients ?" | Montrer un intérêt pour l'efficacité. |
| **Succès** | "Quelles sont vos attentes prioritaires pour un Lead Tech sur les 12 premiers mois ?" | S'aligner sur vos futurs KPIs. |
| **Équipe** | "Quelle est votre vision sur l'évolution de la filière IA face à l'accélération des LLM ?" | Démontrer une vision long terme. |


---

## Questions à poser (5 max par contexte)

Exprimer d’abord ce que tu as compris des enjeux (“Vous avez surtout des missions d’assistance technique, mais...”) puis formuler la question.

### Entretien client / projet

- **Quels sont les principaux défis auxquels un data scientist senior est confronté chez vous aujourd’hui ?***(Repérer : niveau de maturité IA, problématiques techniques ou organisationnelles majeures)*
- **Quels sont les projets IA les plus structurants actuellement dans l’entreprise ?***(Identifier : axes stratégiques, visibilité, mission à fort impact, ROI attendu)*
- **Comment s’organise la co-construction entre vos équipes métiers et les intervenants externes ?***(Répartition du travail, circuit de validation, opportunités pour innover, intégration/formation interne)*
- **Comment mesurez-vous le succès d’un projet IA, au-delà des KPI techniques ?***(Objectifs métier : ROI, adoption, niveau d’industrialisation, satisfaction des utilisateurs finaux)*
- **Quelles perspectives ou ambitions avez-vous pour vos solutions IA à 3-5 ans ?**
  *(Projection : feuille de route innovation, technologies en veille/priorité, montée en charge des équipes)*
- Comment est organiser les differentes equipes ? Est ce qu'il y a des equipes specialisé avant-vente, des équipes spécialisé developpement ? ou des equipes transverse ?

### Entretien RH / culture d’équipe

- **Quelles sont vos attentes prioritaires en termes de soft skills pour ce poste ?***(Adaptabilité, communication, esprit d’équipe, autonomie, potentiel d’évolution)*
- **Comment accompagnez-vous l’évolution de carrière ou la montée en compétences des data scientists ?***(Formations, mentoring, mobilité interne, retours d’expérience, parcours de développement personnel)*
- **Quelles valeurs comptez-vous défendre au sein de vos équipes ?***(Climat de collaboration, confiance, ouverture, partage, diversité)*
- **Comment s’organise la collaboration entre consultants et équipes internes ?***(Répartition du travail, intégration au quotidien, accès aux outils/ressources, opportunités de formation ou d’évolution)*
- **Comment évaluez-vous la réussite d'une prise de poste sur les 6 premiers mois ?**
  *(Indicateurs concrèts de réussite, attentes clés, intégration, dispositifs de feedback)*

---

## Conseils d’utilisation

1. **Entretien client** :

   - Commencer par la **version courte** du pitch, puis embrayer avec 1–2 blocs thématiques selon les questions ou attentes.
   - Exemple : Si interrogé sur la gestion de projet, illustrer avec un exemple concret (Capgemini, Thales).
2. **À l’oral** :

   - Parler lentement, utiliser des pauses pour inviter l’interlocuteur à réagir et instaurer la confiance.
   - Valoriser les exemples concrets (“Chez Thales, j’ai fait X”) plutôt qu’une simple déclaration de compétence (“Je suis expert en Y”).

---

**Astuce** : N’hésite pas à reformuler/moduler ces exemples selon ton vécu et le contexte.
