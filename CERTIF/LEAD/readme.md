# Quick Setup: Kroki + AsciiDoc in VSCode

*Créez des présentations techniques avec diagrammes intégrés, en utilisant AsciiDoc, Kroki, PlantUML, Mermaid, et reveal.js.*

---

## 📌 **Prérequis Communs**
- **VS Code** (recommandé pour l'édition et la prévisualisation).
- **Node.js** (pour les outils npm) **ou** **Ruby** (pour les gems).
- **Docker** (optionnel, pour un serveur Kroki local).

---

## 🔧 **Méthodes d'Installation et d'Utilisation**

### 1️⃣ **Avec npm/Node.js (JavaScript)**
**Pour qui ?** Développeurs Node.js, projets simples, intégration dans un workflow JavaScript.

#### Installation
```bash
npm install -g @asciidoctor/core @asciidoctor/reveal.js asciidoctor-kroki
```

#### Génération des slides
```bash
npx asciidoctor -r @asciidoctor/reveal.js -r asciidoctor-kroki -b revealjs slides.adoc
```

#### Avantages
- Intégration facile dans un projet Node.js.
- Pas besoin d'installer Ruby.

#### Inconvénients
- Certaines extensions (comme `asciidoctor-revealjs`) ne sont pas disponibles sur npm.
- Peut avoir des retards de fonctionnalités par rapport à la version Ruby.

---

### 2️⃣ **Avec Ruby/Gems (Version Officielle)**
**Pour qui ?** Utilisateurs avancés, besoin de fonctionnalités complètes, stabilité.

#### Installation
- **Windows** : [RubyInstaller](https://rubyinstaller.org/), puis :
  ```bash
  gem install asciidoctor asciidoctor-revealjs asciidoctor-kroki
  ```
- **Ubuntu** :
  ```bash
  sudo apt update && sudo apt install ruby ruby-dev
  gem install --user-install asciidoctor asciidoctor-revealjs asciidoctor-kroki
  ```

#### Génération des slides
```bash
asciidoctor-revealjs -r asciidoctor-kroki slides.adoc
```

#### Avantages
- Version officielle, plus stable et complète.
- Accès à toutes les extensions (ex: `asciidoctor-revealjs`).

#### Inconvénients
- Nécessite l'installation de Ruby.

---

### 3️⃣ **Avec VS Code (Extension AsciiDoc Slides)**
**Pour qui ?** Développeurs qui veulent une prévisualisation et un export rapides.

#### Installation
1. Installez l'extension **AsciiDoc Slides** depuis le marketplace VS Code.
2. Ouvrez un fichier `.adoc` et utilisez :
   - `Ctrl+Shift+P` > "AsciiDoc Slides: Preview" pour la prévisualisation.
   - `Ctrl+Shift+P` > "AsciiDoc Slides: Export to HTML" pour générer le fichier HTML.

#### Avantages
- Prévisualisation en temps réel.
- Export HTML intégré.

#### Inconvénients
- Dépend de VS Code.

---

## 🎨 **Intégration de Diagrammes**

### Kroki (PlantUML, Mermaid, Graphviz, etc.)
**Configuration dans le fichier `.adoc` :**
```asciidoc
:kroki-fetch-diagram: true
:kroki-server-url: https://demo.kroki.io  # ou http://localhost:8000 pour un serveur local
```

#### Exemple avec PlantUML
```asciidoc
== Slide avec PlantUML
[kroki, type="plantuml", format="svg"]
----
@startuml
Alice -> Bob : Hello
@enduml
----
```

#### Exemple avec Mermaid
```asciidoc
== Slide avec Mermaid
[kroki, type="mermaid", format="svg"]
----
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
----
```

#### Serveur Kroki local (Docker)
```bash
docker run -p 8000:8000 yuzutech/kroki
```

---

### PlantUML Direct (sans Kroki)
**Pour qui ?** Utilisateurs qui préfèrent PlantUML sans dépendre de Kroki.

#### Configuration
```asciidoc
:plantuml-server-url: https://www.plantuml.com/plantuml/svg/
```

#### Exemple
```asciidoc
== Slide avec PlantUML direct
[plantuml]
----
@startuml
Alice -> Bob : Hello
@enduml
----
```

---

### Mermaid Direct (sans Kroki)
**Pour qui ?** Utilisateurs qui veulent utiliser Mermaid directement dans reveal.js.

#### Configuration
Ajoutez ce script dans votre fichier HTML final ou utilisez un template reveal.js compatible Mermaid.

#### Exemple
```asciidoc
== Slide avec Mermaid direct
```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
```

---

## 📄 **Exemple de Fichier `slides.adoc` Complet**
```asciidoc
= Titre de la Présentation
:revealjsdir: https://cdn.jsdelivr.net/npm/reveal.js@4.3.1
:revealjs_theme: black
:kroki-fetch-diagram: true
:kroki-server-url: https://demo.kroki.io

== Slide 1 : Introduction
[.text-center]
Bienvenue !

== Slide 2 : Diagramme PlantUML
[kroki, type="plantuml", format="svg"]
----
@startuml
Alice -> Bob : Hello
@enduml
----

== Slide 3 : Diagramme Mermaid
[kroki, type="mermaid", format="svg"]
----
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
----

== Slide 4 : Code Python
[source,python]
----
def hello():
    print("Hello, World!")
----
```

---

## 📥 **Export et Conversion**
### En HTML
- **VS Code** : Utilisez l'extension pour exporter.
- **Ligne de commande** :
  ```bash
  # npm
  npx asciidoctor -r @asciidoctor/reveal.js -r asciidoctor-kroki -b revealjs slides.adoc
  # Ruby
  asciidoctor-revealjs -r asciidoctor-kroki slides.adoc
  ```

### En PDF
1. Ouvrez le fichier HTML dans Chrome/Edge.
2. Ajoutez `?print-pdf` à l'URL :
   ```
   file:///chemin/vers/slides.html?print-pdf
   ```
3. `Ctrl+P` > Enregistrez en PDF.

**Alternative** : Utilisez `decktape` (automatisation) :
```bash
npm install -g decktape
decktape reveal slides.html slides.pdf
```

---

## 🔍 **Dépannage**
| Problème                | Solution                                                                 |
|-------------------------|--------------------------------------------------------------------------|
| Kroki ne s'affiche pas  | Vérifiez la connexion Internet et les attributs `:kroki-server-url:`.   |
| PDF incomplet           | Utilisez Chrome/Edge et ajoutez `?print-pdf` à l'URL.                   |
| Erreur de gem           | Installez Ruby et exécutez `gem install` en tant qu'administrateur.    |

---

## 📌 **Résumé des Commandes**
| Action                          | Commande (npm)                                      | Commande (Ruby)                          |
|---------------------------------|----------------------------------------------------|------------------------------------------|
| Installer les outils            | `npm install -g @asciidoctor/core @asciidoctor/reveal.js asciidoctor-kroki` | `gem install asciidoctor asciidoctor-revealjs asciidoctor-kroki` |
| Générer les slides              | `npx asciidoctor -r @asciidoctor/reveal.js -r asciidoctor-kroki -b revealjs slides.adoc` | `asciidoctor-revealjs -r asciidoctor-kroki slides.adoc` |
| Convertir en PDF (decktape)     | `decktape reveal slides.html slides.pdf`            | `decktape reveal slides.html slides.pdf` |

---

## 💡 **Conseils**
- **Thèmes** : Changez `:revealjs_theme:` (ex: `white`, `league`, `beige`).
- **Transitions** : Changez `:revealjs_transition:` (ex: `fade`, `slide`, `convex`).
- **Serveur local** : Utilisez `npx serve` pour tester en local.

---
```

---

### Points clés du README :
- **Clarté** : Chaque méthode est présentée avec ses avantages/inconvénients.
- **Exemples concrets** : Pour Kroki, PlantUML, Mermaid, etc.
- **Dépannage** : Tableau récapitulatif des problèmes courants.
- **Flexibilité** : Adapté aux préférences de l'utilisateur (npm, Ruby, VS Code).

Si tu veux ajouter ou modifier une section, dis-le-moi ! 😊