## Pitch et Question d'interview

*Tour de table :*
- Je suis Lead Tech et Architecte IA chez Lincoln (groupe Alten).
- J'interviens chez les clients de la conception jusqu'à l'industrialisation de solutions IA dans les secteurs de l'industrie et des services.
- Ce projet m’intéresse car il montre une volonté de passage de l’usage simple des LLM à une véritable architecture agentique intégrée à l'ensemble du cycle de vie logicielle.

*Présentation :*
- Initialement, je suis docteur en Physique depuis 2019, où j'ai acquis mon expertise en Datascience et en IA.
- Je suis passé de la recherche à l'industrie en 2022 en travaillant pour Capgemini, où j'ai contribué aussi bien à des projets en Cycle en V qu'en Agile.
- Je suis intervenu dans les secteurs de l'automobile, de l'énergie, de la défense pour Thales et de l'aérospatiale.
- Mon travail consiste à expliciter la vision, analyser le besoin, identifier la valeur et concevoir, piloter et développer la solution.


- Dans le secteur de l'automobile, j'ai eu l'opportunité de gérer une équipe de 10 ingénieurs pour un projet d'optimisation énergétique.
- Mon travail était de prioriser la valeur des technologies de refroidissement et de piloter la roadmap technique ainsi que le suivi des activités.
- L'objectif était de transformer un besoin métier en solution industrielle, incluant de l'IA et de l'ingénierie système via MBSE (Simulink).
- Pour anticiper la demande lors de la démocratisation des LLM, nous avons développé un outil d'explicabilité pour la génération de rapports de diagnostic automobile.

- Dans le secteur de la défense, je suis intervenu sur un projet de gestion logistique et de maintenance prédictive.
- Mon rôle était de cadrer le projet et de faire le lien entre le chef de projet client et les équipes techniques opérationnelles.
- Je me suis particulièrement occupé du moteur IA, de l'estimation des temps de livraison jusqu'au développement logiciel.
- Chez Thales, l'environnement était agile mais avec une exigence forte sur le cycle de vie logiciel (TDD, CI, Kubernetes).

- Enfin de le secteur aero, J'ai travaillé pour plusieurs clients, dont Safran et Airbus.
- Pour Airbus, j'ai initié la Graph Factory pour réduire les délais d'analyse de configuration d'avion.
- J'ai également travaillé sur l'optimisation du développement logiciel clé en main à partir d'agents LLM et de la méthode BMAD.
- L'exigence principale était que la génération soit conforme aux standards industriels, avec un code valide via Pydantic et une observabilité forte via Phoenix et Deepeval.

*Question :*

- D'après ma lecture, votre projet vise à passer d'une assistance ponctuelle à une architecture d'agents structurée sur tout le SDLC. Pour préciser mon approche, j'ai trois questions :
- Quelle est votre vision de ce projet dans 5 ans ?
- Est-ce-que vous avez défini des scénarios/objectif ? Utilisez-vous Gherkin pour structurer le lien entre vos exigences métier et l'architecture de vos agents ?
- Quelle est votre stack technique actuelle pour l'industrialisation (Docker, LiteLLM, observabilité) ?
- Concernant l'EU AI Act, la priorité est-elle l'anonymisation des flux ou l'auditabilité des décisions de l'IA ?

Le conseil : Si une question devient trop théorique, utilise l'analogie du chantier : "On ne valide pas les finitions d'un bâtiment si les fondations ne correspondent pas au plan de l'architecte."

10 Questions qu'on peut poser à partir de notre approche :

1.  **"Comment gérez-vous le conflit entre la rapidité de l'Agile et la rigueur d'un cycle industriel contraignant ?"**
    *   *Réponse courte :* Les Sprints servent à construire les briques de manière itérative, tandis que les jalons du cycle maître garantissent que l'assemblage final respecte le plan homologué.
2.  **"Sur quoi vous basez-vous pour affirmer qu'une deadline est réaliste ?"**
    *   *Réponse courte :* Sur la vélocité historique de l'équipe et une simulation de **Monte-Carlo** intégrant les variables de risques techniques.
3.  **"Comment garantissez-vous que l'IA ne va pas halluciner des données sensibles ?"**
    *   *Réponse courte :* Par la mise en place d'un **RAG** avec sources vérifiées et une surveillance étroite via des outils d'observabilité comme **Arize Phoenix**.
4.  **"C'est quoi pour vous une tâche réellement 'finie' (Definition of Done) ?"**
    *   *Réponse courte :* Le code est revu, les tests **Gherkin** sont au vert, la documentation technique est à jour et les métriques de validation sont générées.
5.  **"Si un projet prend du retard, quelle est votre stratégie de rattrapage ?"**
    *   *Réponse courte :* Analyse du chemin critique et arbitrage sur le périmètre (MVP) pour protéger le jalon de livraison majeur.
6.  **"Comment assurez-vous la traçabilité des exigences (V&V) ?"**
    *   *Réponse courte :* Via une matrice de traçabilité liant chaque besoin utilisateur à son scénario **Gherkin** et son test de validation final.
7.  **"Comment gérez-vous la dette technique au sein de votre équipe ?"**
    *   *Réponse courte :* En intégrant des barrières de qualité automatisées et en réservant une partie de la capacité de l'équipe à la refactorisation et à la documentation **ADR**.
8.  **"Comment intégrez-vous la sécurité dès la conception (Security by Design) ?"**
    *   *Réponse courte :* En validant l'architecture avec les experts sécurité avant tout développement et en privilégiant des solutions souveraines ou locales quand c'est nécessaire.
9.  **"Pourquoi utiliser Gherkin pour un projet IA ?"**
    *   *Réponse courte :* Pour aligner les attentes métier et les tests techniques dans un langage commun, auditable et sans ambiguïté.
10. **"Comment mesurez-vous le succès d'un projet IA au-delà de la performance technique ?"**
    *   *Réponse courte :* Par le calcul du **ROI** métier, l'adoption par les utilisateurs finaux et la réduction mesurable de la complexité opérationnelle.


## Pitch and Interview Questions

### Round Table
*   I am the Lead Tech and AI Architect at Lincoln (Alten Group).
*   I work with clients from initial design to the industrialization of AI solutions in the industry and service sectors.
*   I am interested in this project because it shows a clear goal to move from simple LLM use to a real agentic architecture integrated into the full software development lifecycle (SDLC).

---

### Presentation
*   I have a PhD in Physics (2019), where I built my expertise in Data Science and AI.
*   I moved to the industry in 2022 at Capgemini, working on both V-model and Agile projects.
*   I have worked in automotive, energy, aerospace, and defense for Thales.
*   My job is to clarify the vision, analyze needs, identify value, and then design and lead the development of the solution.

#### Key Projects:
*   **Automotive:** I managed a team of 10 engineers for an energy optimization project. I prioritized the value of cooling technologies and managed the technical roadmap. We turned a business need into an industrial solution using AI and System Engineering (MBSE/Simulink). We also built an explainability tool for automotive diagnostic reports using LLMs.
*   **Defense:** I worked on logistics and predictive maintenance. My role was to bridge the gap between the client’s project manager and the technical teams. I focused on the AI engine for delivery time estimation and software development. At Thales, we worked in an Agile environment with high standards for the software lifecycle (TDD, CI, Kubernetes).
*   **Aerospace:** I worked for Safran and Airbus. For Airbus, I launched the "Graph Factory" to speed up aircraft configuration analysis. I also optimized software development using LLM agents and the BMAD method. The main requirement was industry-standard code, using Pydantic for validation and Phoenix/Deepeval for observability.

---

### Questions
*   From what I understand, you want to move from basic AI help to a structured agent architecture across the whole SDLC. I have three questions to refine my approach:
*   What is your vision for this project in 5 years?
*   Have you defined specific scenarios or goals? Do you use Gherkin to link your business requirements to your agent architecture?
*   What is your current technical stack for industrialization (Docker, LiteLLM, observability)?
*   Regarding the EU AI Act, is your priority data anonymization or the auditability of AI decisions?

> **The Tip:** If a question gets too theoretical, use the construction site analogy: "You don't check the wall paint if the foundations don't match the architect's plan."

---

### 10 Potential Interview Questions & Simple Answers

1.  **"How do you balance Agile speed with industrial quality?"**
    *   *Short Answer:* Sprints build the pieces step-by-step, while master milestones ensure the final product follows the main plan.
2.  **"How do you know if a deadline is realistic?"**
    *   *Short Answer:* I use the team's past speed and **Monte-Carlo** simulations to include technical risks.
3.  **"How do you stop the AI from hallucinating sensitive data?"**
    *   *Short Answer:* By using **RAG** with verified data and tracking everything with observability tools like **Arize Phoenix**.
4.  **"What does 'Done' (Definition of Done) mean to you?"**
    *   *Short Answer:* Code is reviewed, **Gherkin** tests are pass, documentation is ready, and validation metrics are generated.
5.  **"What is your plan if a project is late?"**
    *   *Short Answer:* I analyze the critical path and focus on the **MVP** to make sure we hit the most important delivery date.
6.  **"How do you track requirements (V&V)?"**
    *   *Short Answer:* Using a matrix that links every user need to a **Gherkin** scenario and a final test.
7.  **"How do you handle technical debt?"**
    *   *Short Answer:* By using automated quality gates and giving the team time for refactoring and **ADR** documentation.
8.  **"How do you handle security (Security by Design)?"**
    *   *Short Answer:* By checking the architecture with security experts before coding and choosing local or secure solutions when needed.
9.  **"Why use Gherkin for an AI project?"**
    *   *Short Answer:* To align business goals and technical tests in a simple, clear, and auditable language.
10. **"How do you measure AI success besides tech performance?"**
    *   *Short Answer:* By looking at the business **ROI**, how much users actually use the tool, and if it makes work less complex.