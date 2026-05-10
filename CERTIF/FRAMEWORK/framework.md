# Framework V-Agile

L'objectif de ce framework est de briser le paradigme des projets industriels qui échouent en oscillant entre un **Agile déguisé** (manque de vision) et un **Cycle en V déguisé** (manque de réactivité). L'idée est d'imposer une **rigueur "as-code"** où la documentation et la structure deviennent des composants actifs du cycle de vie de développement.

L'absence de solution universelle exige un arbitrage strict. Par exemple, en gestion de données, la prolifération des technologies est souvent un piège d'ingénierie ; le choix entre Data Warehouse et Data Lake doit se fonder sur le besoin réel plutôt que sur la tendance.

* **Référence** : *An Overview of Data Warehouse and Data Lake in Modern Enterprise Data Management*.
* **DOI** : [10.54045/ijim.v6i2.298](https://doi.org/10.54045/ijim.v6i2.298).

Sur le plan du pilotage, l'évolution historique du leadership démontre qu'aucune "recette miracle" n'existe. Cependant, le gain de temps réside dans la capacité à définir et simuler des scénarios critiques (**Risk-Based Thinking**) pour ne plus subir l'imprévu.

* **Référence** : *Leadership: Past, Present, and Future: An Evolution of an Idea*.
* **DOI** : [10.1177/2158244015571637](https://doi.org/10.1177/2158244015571637).

Ce travail est un guide pour les projets mêlant **logiciel** (itération rapide, BMAD) et **hardware** (certification contraignante, impossibilité d'itérer). Il est le fruit d'une expérience concrète dans ces deux environnements.

**Conseil :** Pour naviguer entre les dogmes logiciels, adoptez une **posture bayesienne** — capable de mobiliser des connaissances multidisciplinaires pour gérer l'incertitude — plutôt qu'une **posture axiomatique**, prisonnier d'une seule idée fixe. Cette approche s'appuie sur une intuition inductivo-deductive qui consiste à trouver l'équilibre entre la précision théorique et la robustesse pragmatique. Pour convaincre et stabiliser les parties prenantes, il est necessaire d'afficher une **posture de confiance** lors de vos interventions, car l'assurance projette la compétence nécessaire pour convaincre. Cependant, cette confiance doit rester un outil de communication masquant un **doute méthodique interne** : face aux affirmations péremptoires des défenseurs de standards, exigez systématiquement des clarifications ou des preuves factuelles, car l'évolution du management prouve qu'aucune méthode n'est une recette miracle. En combinant cette assurance de façade avec une analyse rigoureuse des risques, vous transformez l'incertitude en un levier de décision industriel. Source : Expert Political Judgment: How Good Is It? How Can We Know? ; Taleb, The Black Swan; The Confidence Heuristic, Price & Stone (2004). DOI : 10.1037/0022-3514.87.1.58.

## Principe (Le Human BMAD-vcycle)

S'inspirer de la méthodes de redaction d'article **IMRAD** pour mettre en place la documentation. Chaque affirmation doit etre sourcé, tout comme pour toute proposition technologique.

"Un bon croquis vaut mieux qu'un long discours, néanmoins, mais un test c'est mieux!"

### L'aspect méthodologique

```text
Vision (EcoPol 5-10 ans) Interviews & Stratégie (ROI & TOGAF/IAF/SAFe/Arcadia, R&O ISO9001)
   |
   v
[Analyse Besoin] ----> SMART, Exigence (MosCoW), Lexique, Bête à corne
   |
   |-- [Identifier Valeur] ----> VRIO / TRL -> EDA, ROM, KPI, QCDP et SLA (MTTR)
   |
   |-- [Concevoir Solution] ---> BPMN / IDE0F / UML-C4 / Gherkin (Le contrat DoD)
   |
   v
[Développement / Ops] ----> TDD / ADR / OBS <--> Pilotage Risque (PERT - IPR - Monte-Carlo)
   |
   +--> Code [Doc + Test + Code] -> Update Velocité (Complexité Sprint) -> DeepEval (similarity "Golden Dataset")
   +--> Déploiement & Maintenance [CI/CD & Observabilité] -> Couverture, Tracking (Phoenix) et Gateway (LiteLLM)
   +--> Validation & Qualité (Lint, Type & Flux & SHAP) -> Impact temps & coût
```

| Indicateur                                | Formule / Modèle Mathématique                                            | Objectif de Pilotage                                                                                                      |
| :---------------------------------------- | :------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------ |
| **PERT** (Durée attendue)          | $t_e = \frac{a + 4m + b}{6}$                                             | Déterminer le chemin critique en pondérant les scénarios optimistes ($a$), probables ($m$) et pessimistes ($b$). |
| **Vélocité**                      | $\sum \text{Complexité points} / \text{Sprint}$                         | Mesurer la capacité réelle de livraison de l'équipe pour ajuster la planification en continu.                          |
| **MTTR** (Mean Time To Repair)      | $\frac{\sum \text{Temps de maintenance}}{\text{Nombre de réparations}}$ | Mesurer la réactivité opérationnelle et le respect des engagements de service (SLA).                                   |
| **ROI** (Retour sur Investissement) | $\frac{\text{Gains} - \text{Coûts}}{\text{Coûts}}$                     | Valider la rentabilité stratégique (moyenne de 3,5\$ de gain pour 1 \$ investi en IA).                                 |
| **IPR**                             | $IPR = G . O. D$                                                         | Gravité, Occurence, Détection : AMDEC.                                                                                  |
| **Monte-Carlo**                     | $\text{Simulation stochastique } P(X \leq t)$                            | Calculer la probabilité de succès d'une deadline pour corriger le biais d'optimisme.                                    |

*Attention :* 
- Lorsqu'une metrique devient un objectif, celle-ci devient une mauvaise metrique (Loi de Godhart).
- Ne jamais définir l'opérationnel avant le fonctionnel. On ne s'engage pas tant qu'on a pas compris le besoin !
- Meme s'il y a des standards de roadmap (audit spec -> poc e2e -> mvp bdd -> indus cyber), ne pas s'avancer. Surtout quand on ne sait pas fonctionneemnt du client (data-centric, infra-centric, value-centric, etc.)

### L'Aspect Humain : Leadership et Équilibre

Le leadership dans un environnement hybride logicielle/industriel ne peut pas être monolithique.

**Matrice du Leadership Situationnel (Hersey-Blanchard) adaptée**
| Maturité de l'Équipe | Style de Leadership | Application (exemple) |
| :--- | :--- | :--- |
| **M1 (Faible)** | **Directif** | Phase de certification / Respect des normes ISO. |
| **M2 (Moyenne)** | **Persuasif** | Alignement des parties prenantes sur la vision économique et politique. |
| **M3 (Élevée)** | **Participatif** | Conception de solution (BPMN, UML) en groupe. |
| **M4 (Expert)** | **Délégatif** | Développement TDD et itérations BMAD autonomes. |

**L'Empathie et l'Écoute (Le "Feedback Loop" Humain)**
*   **Posture de confiance vs Doute interne :** C'est l'application de l'*Heuristique de Confiance*. Projeter l'assurance stabilise l'équipe, tandis que le doute interne (votre "méthode bayésienne") garantit la robustesse technique et l'humilité.
*   **Écoute active :** Essentielle lors des interviews de stratégie pour capturer les besoins non-dits (le "Shadow Business").

*Methode Delphi* est une approche pour optimiser la durée et la qualité des débats pour définir une solution collective.

**Limites du JIT (Just-In-Time) et Stress**
Le Lean management (JIT) réduit les gaspillages mais supprime les "buffers". 

*   **Risque :** Stress accru et fragilité face aux imprévus. Une équipe stressée par le JIT produit de la dette technique et des bugs et réduit la créativité. Réintroduire des marges de manœuvre réalistes (buffers de temps) basées sur la probabilité plutôt que sur l'intuition. 

## Experience personnelle

- Docteur en Physique (2019) = Datascience --> recherche vers industrie (2022)
- Responsable de projets Automobile :
  * **Enjeu :** Orchestrer la transformation des architectures de gestion énergétique.
  * **Contraintes :** Standards ISO, synchronisation avec le *Time-to-Market*.
  * **Stratégie :** Cadres (**TOGAF, IAF**) ; priorisation par analyse de valeur (**VRIO, TRL**) pour optimiser le ROI R&D.
  * **Exécution :** Pilotage équipe transverse (R&D, IA), industrialisation des processus.
  * **Impact :** Sécurisation de la roadmap propulsion et amélioration de 12% du cycle de développement.
- Lead Tech IA THALES:
  * **Enjeu :** Optimiser l'efficacité logistique en environnement Défense.
  * **Contraintes :** Sécurité, allocation sous contraintes, infrastructure souveraine.
  * **Stratégie :** Architecture hybride : couplage maintenance prédictive (**LGBoost**) et recherche opérationnelle pour respecter les limites logistiques.
  * **Exécution :** Moteur de recommandation (**ORTool**), DevOps, mentorat technique.
  * **Impact :** Réactivité logistique accrue de 15% et gain de 10% sur l'efficacité d'allocation des ressources.
- Architecte IA :
  * **Enjeu :** Harmoniser les configurations (xBOM/mBOM) pour réduire les délais d'analyse d'impact.
  * **Contraintes :** Volumétrie (10M), traçabilité, interopérabilité ERP.
  * **Stratégie :** Modèle hybride (**ArangoDB**) : structure en graphe pour modéliser nativement les dépendances vs relationnel rigide.
  * **Exécution :** Pipeline **Polars**, requêtes AQL, API **FastAPI**, transfert de compétence.
  * **Impact :** Mise en service de la *Graph factory*, automatisation du calcul des "delta" et réduction de 20% du temps d'analyse d'impact.

## Preuve

| Domaine                       | Étude / Référence        | Lien / DOI (ou source officielle)                                                                                                                                                              | Impact Clé                                                                  |
| :---------------------------- | :-------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------- |
| **Qualité Logicielle** | Nagappan et al. (2008)      | [DOI: 10.1109/ESEM.2008.36](https://www.microsoft.com/en-us/research/publication/realizing-quality-improvement-through-test-driven-development-results-and-experiences-of-four-industrial-teams/) | Réduction des bugs de 60 à 90% via TDD.                                    |
| **Cadrage & Contrat**   | Ricca et al. (2017)         | [DOI: 10.1109/ICSE.2017.74](https://ieeexplore.ieee.org/document/7965354)                                                                                                                         | Amélioration de la compréhension métier via Gherkin.                      |
| **Pilotage Risque**     | Hulett, D. T. (2011)        | [ISBN: 9781610331562](https://www.amazon.com/Practical-Schedule-Risk-Analysis-Hulett/dp/1610331569)                                                                                               | Standard Monte-Carlo pour contrer l'échec des méthodes déterministes.     |
| **Gestion de Projet**   | Flyvbjerg & Gardner (2023)  | [Livre: How Big Things Get Done](https://www.bentflyvbjerg.com/books)                                                                                                                             | Preuve que 92% des projets dérapent par manque de planification rigoureuse. |
| **Créativité**        | Taylor, D. W. et al. (1958) | [DOI: 10.2307/2390603](https://pubmed.ncbi.nlm.nih.gov/13539151/)                                                                                                                                 | Supériorité du travail individuel (Brainstorming) sur le groupe.           |
| **Innovation**          | BCG (2018)                  | [Source: BCG.com](https://www.bcg.com/publications/2018/how-diverse-leadership-teams-boost-innovation)                                                                                            | La mixité augmente les revenus d'innovation de 19%.                         |
| **Valeur de l'IA**      | IDC (2023)                  | [White Paper IDC](https://www.idc.com/getdoc.jsp?containerId=US51330523)                                                                                                                          | ROI de 3,50 $ pour chaque dollar investi dans l'IA.                          |
| **Productivité IA**    | MIT & BCG (2023)            | [Lien: Experimental Evidence](https://www.bcg.com/publications/2023/experimental-evidence-on-the-productivity-effects-of-generative-ai)                                                           | Gain de productivité de 25% avec l'IA générative.                         |
| **Robustesse Data**     | Makridakis et al. (2018)    | [DOI: 10.1016/j.ijforecast.2018.05.013](https://doi.org/10.1016/j.ijforecast.2018.05.013)                                                                                                         | Supériorité des stats classiques sur le Deep Learning en robustesse.       |
| **Biais Cognitif**      | Flyvbjerg (2008)            | [DOI: 10.1080/01944360802293012](https://www.tandfonline.com/doi/abs/10.1080/01944360802293012)                                                                                                   | Nécessité du Monte-Carlo pour corriger le biais d'optimisme.               |



## Lexique des Acronymes

| Domaine | Acronyme | Signification | Application au Edge / Data Science |
| --- | --- | --- | --- |
| **Qualité Code** | **SOLID** | Single resp, Open/Closed, Liskov, Interface, Dependency | Garantit que tes scripts Python restent maintenables quand le projet grossit. |
| **Philosophie** | **KISS** | Keep It Simple, Stupid | Évite la sur-ingénierie sur des machines à ressources limitées. |
| **Maintenance** | **DRY** | Don't Repeat Yourself | Centralise la logique (ex: une seule fonction pour valider tes données de capteurs). |
| **Pragmatisme** | **YAGNI** | You Ain't Gonna Need It | Ne code pas une synchro Cloud complexe si tu n'en as pas encore besoin. |
| **Données** | **ACID** | Atomicity, Consistency, Isolation, Durability | Indispensable pour **LanceDB/SQLite** afin d'éviter la corruption en cas de coupure. |
| **Systèmes Dist.** | **BASE** | Basically Available, Soft state, Eventual consistency | Utilisé pour la synchronisation Edge-to-Cloud (la donnée finit par arriver). |
| **Architecture** | **CAP** | Consistency, Availability, Partition tolerance | Aide à choisir entre "donnée toujours juste" et "système toujours disponible". |
| **Sécurité** | **CIA** | Confidentiality, Integrity, Availability | Le triangle d'or : tes données doivent être secrètes, exactes et accessibles. |
| **Performance** | **RT** | Real-Time | Critique pour le Edge (ex: traiter un signal en moins de 10ms). |
| **Data Management** | **ETL** | Extract, Transform, Load | Le flux classique : lire le capteur, nettoyer le signal, stocker dans LanceDB. |
| **Méthodologie** | **TDD** | Test-Driven Development | Écrire le test avant le code pour garantir que tes calculs statistiques sont justes. |


## TODO


### Concept de Gouvernance et Rôles

* **Définition de la Gouvernance** : Système de règles et de pouvoir (le "cadre") vs les acteurs (le "qui").
* **RACI** : Matrice de répartition des responsabilités (R, A, C, I).
* **Rôle du "A" (Accountable)** : Seul redevable, pilier de la gouvernance dans le RACI.
* **Rôle du "R" (Responsible)** : L'exécutant technique (ne porte pas la redevabilité décisionnelle).
* **Architectes** : Garants de la gouvernance technique et de la vision long terme.
* **Sponsors** : Moteurs politiques et financiers, souvent le "A" final du projet.

### Méthodologies et Idéologies

* **Cycle en V** : Approche prédictive basée sur le contrôle, le WBS et le RACI.
* **Agile** : Approche empirique basée sur l'auto-organisation et la valeur (souvent incompatible avec le RACI rigide).
* **WBS (Work Breakdown Structure)** : Décomposition statique du travail, typique du Cycle en V.
* **Backlog** : Liste dynamique et priorisée (DEEP) des besoins (User Stories).
* **Conflit Idéologique** : Opposition entre le dogme du "Contrôle & Commande" et celui de la "Liberté/Anarchie".

### Framework "V-Agile"

* **Hybridation** : Concilier la rigueur industrielle (Hardware/Normes) et la réactivité logicielle.
* **Structure IMRAD** : Application des standards de publication scientifique à la documentation projet.
* **Posture Bayésienne** : Gestion de l'incertitude par la mise à jour des connaissances (vs Posture Axiomatique).
* **Heuristique de Confiance** : Assurance extérieure pour stabiliser, doute méthodique interne pour la robustesse.
* **Outils de Pilotage Mathématiques** : PERT, Monte-Carlo (risque), ROI, IPR (AMDEC), MTTR.
* **Leadership Situationnel** : Adaptation du style (Directif à Délégatif) selon la maturité de l'équipe (Hersey-Blanchard).
* **Outils de Conception** : BPMN, UML-C4, Gherkin (contrat de test), TDD, ADR.

### Concepts de Management & Limites

* **DP (Delegation Poker)** : Alternative au RACI pour graduer la délégation de décision.
* **Loi de Godhart** : Quand une mesure devient un objectif, elle perd sa valeur d'indicateur.
* **Loi de Kingman (VUT)** : Impact de la saturation des ressources sur les délais (nécessité de buffers).
* **Biais d'Optimisme** : Tendance à sous-estimer les risques, corrigée par les simulations stochastiques.
* **Just-In-Time (JIT)** : Risques de stress et de dette technique par suppression des marges.