# Discours de la présentation : retour d'expérience « Mission IA »

**Durée visée : 30 minutes** (environ 3 600 mots à un rythme posé de 120 mots par minute).
**Termes :** ceux du PDF public (entité de service et centre de compétence, base de données SI, gconf, HUMS). Le texte est donc partageable tel quel.
**Numérotation :** celle du PDF interne (1 = couverture, 2 = sommaire). Dans le PDF public, retire 2 à chaque numéro.

---

## Avant de commencer

### Le fil rouge en une phrase

> On n'a pas besoin de plus d'IA : on a besoin de mieux **orienter**, de **partir du besoin métier**, et de construire un **socle de données gouvernées** sur lequel une technologie qui évolue très vite pourra se brancher.

### Les trois messages à faire passer

1. **Partir du besoin, pas de l'outil.** Un outil IA n'est pas un cas d'usage.
2. **Un langage commun et une priorisation mesurable.** Un gabarit unique, des critères de faisabilité et des OKR.
3. **Le vrai verrou, c'est la donnée.** Et la technologie doit suivre la trajectoire de l'IA, pas l'effet de mode.

### Conseils de présentation

- Parle lentement, fais des pauses après chaque message clé (les phrases en **gras** dans le texte).
- Ne lis pas les slides : elles montrent la structure, toi tu racontes.
- Quand tu cites un auteur, dis simplement « une étude publiée » ou « les travaux de ... » : les liens sont cliquables sur les slides pour ceux qui veulent vérifier.
- Trois endroits demandent de la **prudence à l'oral** : les gains visés du démonstrateur (slide 11), l'horizon 2030-2035 (slide 5) et le fait que les seuils de priorité sont indicatifs (slide 8).

### Minutage

| Slide | Titre | Durée | Cumul |
| --- | --- | --- | --- |
| 1 | Couverture | 0:30 | 0:30 |
| 2 | Sommaire | 0:30 | 1:00 |
| 3 | Ma mission | 2:00 | 3:00 |
| 4 | Le constat initial | 2:00 | 5:00 |
| 5 | Roadmap de l'IA | 2:30 | 7:30 |
| 6 | Partir du besoin métier | 2:00 | 9:30 |
| 7 | Ma méthode : un gabarit unique | 3:00 | 12:30 |
| 8 | Qualifier et prioriser | 3:00 | 15:30 |
| 9 | Un portefeuille de cas d'usage | 1:00 | 16:30 |
| 10 | Le SI conversationnel | 2:00 | 18:30 |
| 11 | Du concept au démonstrateur | 2:30 | 21:00 |
| 12 | Les briques techniques | 3:00 | 24:00 |
| 13 | Le verrou : la donnée | 2:30 | 26:30 |
| 14 | Les enseignements | 1:00 | 27:30 |
| 15 | Bilan et prochaines étapes | 1:30 | 29:00 |

Il reste une minute de marge. Si tu es en retard, voir la section « Si le temps manque » à la fin.

---

## Slide 1 : Couverture (0:30)

**À dire**

Bonjour à toutes et à tous. Je vais vous présenter le retour d'expérience de ma mission : comment nous avons structuré et accéléré l'adoption de l'IA au service des métiers, au sein de notre entité de service et centre de compétence. Je vais vous montrer ce qui a marché, ce qui nous a bloqués, et surtout la méthode que je propose à tous les métiers pour travailler ensemble.

---

## Slide 2 : Sommaire (0:30)

**À dire**

Cinq parties. D'abord le contexte, la mission et la vision de l'IA. Ensuite le besoin, la méthode et la priorisation. Puis un cas d'usage concret : le système d'information conversationnel. Enfin les enseignements, et le bilan avec les prochaines étapes. Vous verrez en haut à droite de chaque slide une pastille qui indique où nous en sommes dans ce plan.

---

## Slide 3 : Ma mission (2:00)

**Message clé** : mon rôle est celui d'un facilitateur entre métier, data, architecture et IA.

**À dire**

Commençons par ma mission. Je suis le point de jonction entre trois mondes. À gauche du schéma : les besoins opérationnels des métiers, les équipes digitales, et les solutions d'IA du Groupe. Au centre : l'entité de service et centre de compétence. À droite : ce que nous produisons, c'est-à-dire identifier les usages, qualifier les initiatives, et créer des démonstrateurs. Tout cela converge vers une trajectoire d'industrialisation.

Concrètement, cela veut dire quatre choses. **Faire le lien** entre les besoins, les équipes digitales et les solutions du Groupe. **Identifier** les processus métiers qui peuvent bénéficier de l'IA. **Qualifier** chaque initiative selon sa valeur, sa faisabilité et sa conformité. Et **transformer** les besoins prioritaires en démonstrateurs, puis en trajectoires d'industrialisation.

Un point de contexte important, dans l'encadré : à mon arrivée, il n'y avait **aucun profil spécialisé en IA** dans le service. J'ai donc porté trois casquettes : architecte, product owner et tech lead. Cela explique la nature de ce retour d'expérience : il couvre à la fois la vision, la méthode et la réalisation technique.

Mon rôle, en une phrase : **facilitateur entre métier, data, architecture et IA.**

**Transition** : voyons ce que j'ai trouvé en arrivant.

---

## Slide 4 : Le constat initial (2:00)

**Message clé** : le premier enjeu n'était pas de développer plus, mais d'orienter, mutualiser et prioriser.

**À dire**

En arrivant, le constat était clair : beaucoup d'initiatives, mais une forte fragmentation. Quatre symptômes.

Un : des **solutions peu visibles**. Les métiers connaissaient mal les outils réellement disponibles. Deux : des **initiatives dispersées**. Il existe de nombreuses équipes IA, au niveau du Groupe, des GBU et en local. Trois : un **risque de doublons** : on pouvait refaire ailleurs ce qui avait déjà été développé. Quatre : une **approche centrée sur les outils**. La discussion démarrait par « on veut tel outil » plutôt que par « voici le problème à résoudre et voici comment on le mesurerait ».

Le premier enjeu n'était donc pas de développer davantage. C'était de **mieux orienter** les demandes vers ce qui existe, de **mutualiser** ce qui peut l'être, et de **prioriser** ce qui crée de la valeur. Ces trois verbes sont le fil de toute ma présentation.

**Transition** : avant la méthode, je veux poser le cadre technologique, parce qu'il explique pourquoi cette organisation est indispensable.

---

## Slide 5 : Roadmap de l'IA, 2020 vers 2035 (2:30)

**Message clé** : nos choix techniques doivent suivre cette trajectoire, pas l'outil du moment.

**À montrer** : parcours de gauche à droite, un palier après l'autre.

**À dire**

Cette slide, c'est la vision stratégique. Elle répond à une question : où va la technologie, et dans quel cadre doivent s'inscrire nos choix ?

En **2020**, il y a une rupture : les **modèles de fondation**. Avant, on entraînait un modèle par tâche. Avec ces modèles, pré-entraînés à très grande échelle, un même modèle s'adapte à de nombreuses tâches. C'est ce que montrent les travaux sur GPT-3 et le rapport de Stanford de 2021. Pour nous, la conséquence est importante : la valeur se déplace vers **les données et les usages**.

Deuxième palier, de 2021 à 2024 environ : les **LLM avec RAG**. RAG veut dire « génération augmentée par la récupération » : le modèle ne répond plus de mémoire, il va chercher des documents ou des données au moment de la question, puis il rédige sa réponse à partir d'eux. Pour nous : des données **documentées, accessibles et gouvernées**.

Troisième palier : les **agents**. Là, le modèle ne se contente plus de répondre : il raisonne, il planifie et il appelle des outils pour mener une tâche en plusieurs étapes. Le protocole MCP standardise la façon d'exposer ces outils à un agent. Pour nous : des services exposés en API ou en MCP, avec des **droits maîtrisés**.

Quatrième palier, et là je suis volontairement prudent : la perspective **2030-2035**. Les « world models » sont des modèles qui apprennent une représentation prédictive d'un environnement pour simuler et planifier. Ils existent en recherche. L'idée, et **c'est ma projection, pas un fait établi**, c'est qu'un système d'information pourrait un jour maintenir un tel modèle de l'entreprise. Ce qui est sûr, c'est ce que cela suppose : une couche sémantique et un état de l'entreprise fiables.

Ce qu'il faut retenir : **chaque palier réutilise le précédent**. Données gouvernées, puis outils exposés, puis modèle de l'entreprise. Donc nos choix techniques doivent suivre cette trajectoire, pas l'outil du moment.

**Transition** : voyons maintenant comment on part d'un besoin.

---

## Slide 6 : Partir du besoin métier (2:00)

**Message clé** : un outil IA n'est pas un cas d'usage ; la valeur commence par un problème métier bien formulé.

**À dire**

Premier principe de méthode : séparer clairement trois choses qu'on mélange tout le temps.

Le **besoin** : quel problème opérationnel doit être résolu ? Le **cas d'usage** : comment l'utilisateur souhaite-t-il le résoudre ? La **solution** : quelles briques techniques, quelles données, quelle organisation ? Dans la solution, il y a trois dimensions : données, technologies, organisation. Et c'est souvent l'organisation qui fait échouer un projet, pas la technologie : c'est ce que disent aussi les cadres d'adoption de l'IA publiés.

On formalise systématiquement quatre éléments : les utilisateurs, les données, les résultats attendus et les indicateurs de succès. Et j'applique une **règle d'or** : pas de POC sans pilote métier ni valeur attendue identifiable. Un POC sans pilote, c'est un projet technique qui n'a personne pour s'en servir.

Cela rejoint la méthode de référence en science des données, CRISP-DM, qui place la compréhension du besoin avant les données et avant le modèle.

**Un outil IA n'est pas un cas d'usage. La valeur commence par un problème métier bien formulé.**

**Transition** : pour que tous les métiers formulent leur besoin de la même façon, j'ai construit un gabarit.

---

## Slide 7 : Ma méthode, un gabarit unique (3:00)

**Message clé** : un langage commun entre métiers, data et IT, dans un seul document.

**À montrer** : les trois colonnes de gauche à droite, puis les trois encadrés du bas.

**À dire**

Voici la méthode que je propose à **tous les métiers**. L'idée est simple : un seul gabarit, rempli ensemble, qui exprime le besoin, le cas d'usage et la mesure. Il se lit en trois colonnes.

Colonne de gauche : **qui, pourquoi, contexte**. On donne un nom au cas d'usage. Puis l'objectif en trois phrases : « Afin de » la valeur métier, « En tant que » tel utilisateur, « Je souhaite » tel besoin. Puis le contexte : les contraintes métier et les systèmes concernés. Puis les données d'entrée.

Colonne du milieu : le **scénario**. Il se formule en quatre mots : « Étant donné », « Quand », « Alors », « Et ». C'est un exemple concret : étant donné cette situation, quand l'utilisateur fait cela, alors il obtient ceci. Ce scénario devient notre **critère d'acceptation** : on pourra le tester avec les métiers.

Colonne de droite : **sorties, moyens, mesure**. Les données de sortie, les sources de données, les capacités nécessaires, comme les connecteurs, et enfin les **indicateurs de succès** : temps gagné, qualité, réduction du risque.

Pour illustrer, prenez notre cas d'usage. Fonctionnalité : analyser l'impact de l'obsolescence d'un composant sur le parc. Afin de réduire le temps d'analyse, en tant que responsable de parc, je souhaite connaître les équipements concernés. Étant donné un composant déclaré obsolète, quand je pose la question, alors j'obtiens la liste des équipements, avec leur criticité. L'indicateur : le temps d'analyse. *(C'est un exemple pour t'aider à l'expliquer ; il reprend le cas d'usage de la suite.)*

Pourquoi ce format ? Trois raisons, appuyées sur des études. D'abord, c'est un **langage commun** : les scénarios « Étant donné, Quand, Alors » sont compréhensibles par tous. Ensuite, le besoin est **clarifié et testé** : des expériences montrent que les tests d'acceptation lèvent les ambiguïtés sur les exigences, et qu'écrire le test d'abord réduit les défauts de 40 à 90 %, au prix d'un temps de développement plus long, de l'ordre de 15 à 35 %. Enfin, c'est **mesurable** : les indicateurs de succès alimentent directement la priorisation, que je vous montre maintenant.

---

## Slide 8 : Qualifier et prioriser (3:00)

**Message clé** : on lance ce qui fait bouger un résultat clé et qui est réalisable.

**À montrer** : la barre bleue « Priorité = C × F », puis les trois cases du bas.

**À dire**

Une fois le cas d'usage décrit, il faut décider s'il passe en POC. J'utilise six dimensions d'analyse, regroupées en **deux familles**.

La dimension 1, c'est la **valeur**, notée **C** pour contribution. On se demande : quel résultat clé de nos OKR ce cas d'usage fait-il bouger, et de combien ? Un OKR, c'est un objectif de l'entité décliné en résultats clés mesurables. Les indicateurs de succès du gabarit nous donnent directement les résultats clés candidats.

Les dimensions 2 à 6 forment la **faisabilité**, notée **F** : un pilote métier, des données disponibles et de qualité, la faisabilité technique et l'intégration au système d'information, la sécurité et la conformité, et la capacité à déployer puis à maintenir.

La **formule**, maintenant. C est une note de 0 à 3 : la contribution estimée aux résultats clés. F est une note de 0 à 3 : le **score le plus faible** des dimensions 2 à 6. Pourquoi le plus faible ? Parce qu'un projet est aussi solide que son maillon le plus fragile : sans pilote ou sans accès aux données, rien ne se fait. **Un F à zéro est bloquant.** La priorité est le produit des deux : **C fois F**.

Un exemple fictif pour que ce soit concret. Un cas avec C égal à 3, et des notes de faisabilité de 3, 2, 3, 3 et 2 : le plus faible est 2, donc F vaut 2, et la priorité est 3 fois 2, soit 6. Prioritaire. Même cas, mais avec des données de qualité très insuffisante, notées 1 : F tombe à 1, la priorité à 3. Il faut alors approfondir le cadrage.

Trois issues : à partir de **6**, on lance un POC ; de **3 à 5**, on approfondit le cadrage ; en dessous de **3**, on met en attente. Précision importante : **ces seuils sont indicatifs**, ils sont à calibrer.

Deux garde-fous. D'abord, quand un indicateur devient un objectif, il perd sa valeur : c'est la loi de Goodhart. Il faut donc garder un œil critique. Ensuite, les gains se mesurent avec un **groupe pilote**, sur une référence observée plutôt que sur l'intuition : les études sur les projets montrent que nous sommes tous trop optimistes.

*(Si on te demande : la littérature scientifique sur les OKR est encore limitée, surtout des études de cas. Ce qui est solide, c'est que des objectifs précis et exigeants améliorent la performance.)*

---

## Slide 9 : Un portefeuille de cas d'usage (1:00)

**Message clé** : une vision commune des priorités, pour faciliter les arbitrages.

**À dire**

Cette méthode produit un **portefeuille**. On part du recueil des besoins auprès des pôles et fonctions de l'entité, on qualifie, on cherche si une solution existe déjà, on évalue valeur et complexité, puis on arbitre. Chaque initiative est positionnée selon sa maturité : idéation, POC, MVP ou production. Et nous avons déjà fait ressortir plusieurs thèmes : l'accès à l'information, la synthèse documentaire, la maintenance, les offres, la qualité et l'exploitation des données.

Le bénéfice : une **vision commune des priorités**, qui facilite les arbitrages d'investissement.

**Transition** : prenons le cas d'usage prioritaire.

---

## Slide 10 : Le SI conversationnel (2:00)

**Message clé** : transformer des données techniques complexes en réponses exploitables par les métiers.

**À dire**

Le cas d'usage prioritaire : le **système d'information conversationnel**. Le principe : interroger les données métier **en langage naturel**.

Le besoin : réduire le temps passé à chercher une information dans les systèmes métier. Les utilisateurs : les responsables de parc, la maintenance, les méthodes, les devis, les experts et l'exploitation. Le principe : poser une question métier **sans connaître les tables ni le SQL**.

Un exemple, dans l'encadré : « Quel est l'impact de l'obsolescence de ce composant sur le parc ? » La réponse attendue : les équipements concernés, la criticité, les impacts opérationnels et des recommandations.

Sur le schéma : l'utilisateur pose sa question à l'assistant, qui interroge les sources, la base de données SI, SAP et d'autres, puis produit une **réponse contextualisée** : impact, criticité, recommandation. Cette approche, traduire une question en requêtes sur une base, est étudiée dans la recherche, avec des benchmarks publiés. Mais ces études montrent aussi que c'est plus difficile dans un contexte d'entreprise, et c'est ce que nous allons voir.

**Transition** : voyons si cela fonctionne.

---

## Slide 11 : Du concept au démonstrateur (2:30)

**Message clé** : le démonstrateur rend la vision concrète et valide l'intérêt métier avant d'industrialiser.

**À dire**

Nous avons construit un démonstrateur, c'est-à-dire une première validation technique sur la base de données SI. Le parcours est complet, de bout en bout : la question métier arrive à un agent conversationnel ; il passe par une couche MCP, qui lui donne accès à la base de données SI ; il analyse les résultats ; il rédige la réponse en langage naturel. Le raisonnement s'appuie sur les **services IA sécurisés du Groupe**.

En haut, trois **résultats visés**. Insiste sur le mot « visés ». Recherche d'information : de 30 minutes à moins d'une minute. Analyse d'impact : d'une journée à quelques minutes. Et environ 100 utilisateurs potentiels.

**Soyons honnêtes sur ces chiffres.** Ce sont des objectifs, pas des mesures. Pour situer l'ordre de grandeur de ce que la littérature a mesuré : un essai randomisé sur 453 professionnels a trouvé **40 % de temps en moins et 18 % de qualité en plus** ; une étude sur des consultants, environ 25 % de temps gagné. Nos gains visés sont **supérieurs**, parce que la tâche est très spécifique. C'est exactement pour cela que la prochaine étape est de les **valider avec un groupe pilote**.

---

## Slide 12 : Les briques techniques (3:00)

**Message clé** : des briques simples et remplaçables, pour changer de technologie sans reconstruire les usages.

**À montrer** : les quatre cartes, de haut en bas et de gauche à droite.

**À dire**

Quelles briques techniques avons-nous utilisées ? Quatre, et chacune a un rôle précis.

**WayFlow et PyAgentSpec**, pour définir les agents de façon **déclarative**. Agent Spec est un langage ouvert, indépendant du framework : on décrit l'agent une fois, comme une configuration, sans l'écrire dans un code propre à un outil. PyAgentSpec est le SDK Python qui sert à le définir, et WayFlow est le runtime de référence qui l'exécute. L'intérêt : on peut changer de moteur d'exécution sans réécrire l'agent.

**FastAPI et FastMCP**. FastAPI expose l'accès aux données sous forme de services Python. FastMCP les publie ensuite à l'agent comme un **serveur MCP**. Point d'attention que je garde en tête : la documentation recommande plutôt des outils MCP choisis à la main qu'une conversion automatique de toutes les routes.

**Sidemantic et Apache Ossie**, pour la **couche sémantique**. Sidemantic définit une fois les règles de gestion et les indicateurs métier. Apache Ossie, anciennement Open Semantic Interchange, est un format ouvert d'échange de modèles sémantiques. Il est aujourd'hui en incubation à l'Apache Software Foundation : c'est donc une direction, pas encore un standard installé.

**LanceDB**, une base vectorielle : elle stocke et retrouve l'information par **similarité**. C'est la brique de la recherche sémantique, donc du RAG.

Deux principes pour finir. Le raisonnement de l'agent est assuré par les services IA sécurisés du Groupe. Et on **choisit la brique selon le besoin, pas selon la tendance** : data warehouse ou data lake, statistiques classiques ou deep learning. Les études montrent que le plus récent n'est pas toujours le plus adapté.

*(Si on te demande une source pour WayFlow, Ossie ou FastMCP : ce sont des outils sans publication académique, les liens des slides pointent vers leur documentation officielle. La publication existe pour Agent Spec.)*

---

## Slide 13 : Le verrou, la donnée (2:30)

**Message clé** : le vrai socle n'est pas le chatbot, c'est une donnée métier gouvernée.

**À montrer** : le schéma de gauche à droite, puis l'encadré « Preuve expérimentale ».

**À dire**

Voici le principal verrou que nous avons identifié : **la donnée**. L'IA ne compense pas une architecture de données trop complexe.

À gauche, nos sources actuelles : la base de données SI, SAP, gconf, HUMS, le référentiel de SQL et des fichiers. Trois problèmes. **Tout est dans un même SQL** : données, règles métier, métriques et affichage sont mélangés dans la même requête. Les **règles sont dupliquées** : les mêmes règles se retrouvent dans le SQL, Power BI, Excel et d'autres outils. Et c'est donc **peu adapté aux agents IA** : difficile à maintenir et à exploiter par une IA.

La cible, au milieu : une **couche sémantique**. Elle standardise les objets métier, les règles de gestion communes et les indicateurs gouvernés. En sortie : des applications IA fiables.

Est-ce une intuition ? Non, il y a des preuves. Dans une étude sur une base SQL d'entreprise, un modèle de type GPT-4 donne **16 % de réponses exactes** sur le SQL brut, et **54 %** quand on lui fournit une représentation sémantique des données. Et le benchmark Spider 2.0, qui reproduit des tâches d'entreprise, montre qu'un agent récent ne résout que **21 % des tâches**, contre 91 % sur un benchmark plus simple. Autrement dit : plus la donnée est complexe, plus l'IA a besoin d'une base propre.

Pour le dire en une phrase : **le vrai socle du SI conversationnel n'est pas le chatbot, c'est une donnée métier gouvernée.**

*(Nuance si on te la demande : l'étude à 16 % puis 54 % utilise un graphe de connaissances, pas l'outil Sidemantic lui-même. Elle prouve que la sémantique aide, pas qu'un outil précis fait mieux.)*

---

## Slide 14 : Les enseignements (1:00)

**Message clé** : l'IA est rarement la principale difficulté. La donnée, l'intégration, la gouvernance et l'adoption le sont.

**À dire**

Pour résumer ce que ce projet nous a appris, quatre domaines.

**Métier** : partir du terrain et pas de la technologie ; nommer un pilote responsable de la valeur ; mesurer les gains avant d'industrialiser, car beaucoup de projets d'IA butent sur le passage du prototype à la production.

**Données** : vérifier la qualité, standardiser les règles de gestion, impliquer la gouvernance dès le cadrage.

**Technologie** : réutiliser les solutions du Groupe avant de développer ; construire une architecture modulaire, pour pouvoir remplacer une technologie sans tout reconstruire, comme le disait déjà un article de 1972 ; et prévoir la sécurité dès le cadrage.

**Adoption** : impliquer les utilisateurs, démontrer vite, accompagner le changement.

L'IA est rarement la principale difficulté.

---

## Slide 15 : Bilan et prochaines étapes (1:30)

**Message clé** : d'un intérêt général pour l'IA à une démarche structurée, centrée sur la valeur métier.

**À dire**

Pour conclure, ce que nous avons réalisé. Nous avons **clarifié le rôle** de l'entité dans l'écosystème IA. Nous avons une **méthode** de qualification des cas d'usage. Nous avons fait une **première cartographie** des initiatives. Nous avons un **démonstrateur** du SI conversationnel. Et nous avons identifié les **prérequis** en données et en architecture.

Les prochaines étapes, dans l'ordre : un, **valider les gains avec un groupe pilote**. Deux, cibler un périmètre métier limité et mesurable. Trois, construire progressivement la couche sémantique. Quatre, sécuriser la gouvernance, le support et la responsabilité produit. Cinq, passer du démonstrateur au MVP.

Pour terminer : nous sommes passés d'un intérêt général pour l'IA à une démarche structurée, **centrée sur la valeur métier** et tournée vers l'industrialisation. Merci de votre attention, je suis à votre disposition pour vos questions.

---

## Si le temps manque

Dans l'ordre de ce que tu peux raccourcir, du plus facile au plus difficile :

1. **Slide 9** (portefeuille) : dis seulement « cette méthode produit un portefeuille priorisé » (gain : 30 secondes).
2. **Slide 12** (briques) : ne détaille que WayFlow et la couche sémantique, cite les deux autres en une phrase (gain : 1 minute).
3. **Slide 14** (enseignements) : lis seulement le message clé et un exemple par colonne (gain : 30 secondes).
4. **Slide 5** (roadmap) : ne détaille que les deux derniers paliers (gain : 1 minute).

À éviter de raccourcir : les slides 6, 7 et 8, qui contiennent ta méthode.

---

## Mini-glossaire (à garder sous la main)

| Terme | En une phrase |
| --- | --- |
| **Modèle de fondation** | Grand modèle pré-entraîné qui s'adapte à de nombreuses tâches. |
| **LLM** | Modèle de langage de grande taille (le « moteur » des assistants). |
| **RAG** | Le modèle va chercher des documents ou des données au moment de la question, puis répond à partir d'eux. |
| **Agent** | Un modèle qui raisonne, planifie et appelle des outils pour accomplir une tâche. |
| **MCP** | Protocole qui standardise la façon dont on expose des outils et des données à un agent. |
| **World model** | Modèle qui apprend une représentation prédictive d'un environnement pour simuler et planifier. |
| **Couche sémantique** | Définition unique des objets, règles et indicateurs métier, partagée par tous les outils. |
| **POC / MVP** | Preuve de concept (technique) / première version utilisable (produit). |
| **OKR / KR** | Objectif de l'entité / résultats clés mesurables qui permettent de savoir si on l'atteint. |
| **Gherkin (Étant donné / Quand / Alors)** | Façon d'écrire un scénario en langage presque naturel, lisible par les métiers et testable. |
| **Déclaratif** | On décrit ce que l'agent doit être, pas comment le programmer pas à pas. |

---

## Questions probables et réponses courtes

**« Pourquoi ne pas utiliser directement un assistant grand public ? »**
Parce qu'il ne connaît pas nos données et nos règles. Le sujet n'est pas le modèle, c'est l'accès fiable aux données métier, avec les bons droits. C'est la leçon de la slide 13.

**« Les gains de 30 minutes à moins d'une minute, c'est fiable ? »**
Ce sont des objectifs, pas des mesures. La littérature donne des gains plus modestes, de 25 à 40 %, sur des tâches plus larges. Notre cas est très ciblé, donc on vise plus haut, et on le valide avec un groupe pilote avant d'industrialiser.

**« Les OKR, c'est vraiment prouvé ? »**
La littérature sur les OKR est encore limitée, surtout des études de cas. Ce qui est solide, c'est que des objectifs précis et exigeants améliorent la performance. D'où mes deux garde-fous : seuils indicatifs, et gains mesurés avec un groupe pilote.

**« Les world models en 2030-2035, c'est sérieux ? »**
C'est une **hypothèse de travail**. Les world models existent en recherche. Leur application aux systèmes d'information d'entreprise est ma projection. Ce que je défends, ce sont les prérequis, qui sont utiles dans tous les cas : données gouvernées et couche sémantique.

**« Pourquoi une couche sémantique plutôt que d'améliorer les requêtes ? »**
Parce que sinon les règles restent dupliquées et mélangées au SQL. La couche sémantique les définit une fois, pour tous les outils, et elle est lisible par les agents. Une étude montre un gain d'exactitude de 16 % à 54 % avec ce type de représentation.

**« Et la sécurité ? »**
Elle est prévue dès le cadrage. Le raisonnement s'appuie sur les services IA sécurisés du Groupe, et les droits d'accès sont maîtrisés au niveau des services exposés en MCP.

**« Pourquoi autant de briques, ce n'est pas trop complexe ? »**
Chaque brique a un rôle unique et reste remplaçable. C'est le principe d'une architecture modulaire. Et on choisit chaque brique selon le besoin, pas selon la mode.

**« Pourquoi un gabarit, plutôt qu'un cahier des charges classique ? »**
Parce qu'il fait parler tous les métiers le même langage, il reste court, et le scénario sert directement de test d'acceptation. Un cahier des charges classique est plus long et moins partagé.
