# Quick Setup: Kroki + AsciiDoc in VSCode

## 📌 Prerequisites

- **VSCode** installed.
- **Docker** (for local Kroki server, optional).

---

## 🛠 Setup

### 1. Install Ruby + Gems

#### **Windows**

1. Install Ruby with [RubyInstaller](https://rubyinstaller.org/).
2. Open **Command Prompt as Admin** and run:
   ```bash
   gem install asciidoctor asciidoctor-revealjs asciidoctor-kroki
   ```

#### **Ubuntu**

1. Install Ruby and dependencies:
   ```bash
   sudo apt update && sudo apt install ruby ruby-dev
   ```
2. Install gems:
   ```bash
   sudo gem install asciidoctor asciidoctor-revealjs asciidoctor-kroki
   # mieux :
   export PATH="$PATH:$HOME/.gem/ruby/bin"
   export GEM_HOME="$HOME/.gem/ruby"
   export PATH="$PATH:$HOME/.gem/ruby/bin"
   gem install --user-install asciidoctor asciidoctor-kroki
   echo 'export PATH="$HOME/.gem/ruby/<version>/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrcbashrc source ~/.bashrc
   ```

---

### 2. Configure Kroki

Add these attributes to your `.adoc` file:

```asciidoc
:kroki-fetch-diagram: true
:kroki-server-url: https://demo.kroki.io
```

#### (Optional) Run Kroki locally with Docker:

```bash
docker run -p 8000:8000 yuzutech/kroki
```

Then update the URL in your `.adoc` file:

```asciidoc
:kroki-server-url: http://localhost:8000
```

---

### 3. Create and Generate Slides

#### Example `presentation.adoc`:

```asciidoc
= Kroki Demo
:backend: revealjs
:kroki-fetch-diagram: true
:kroki-server-url: https://demo.kroki.io

== Slide 1: PlantUML
[kroki, type="plantuml", format="svg"]
----
@startuml
Alice -> Bob : Hello
@enduml
----
```

#### Generate slides:

```bash
asciidoctor-revealjs -r asciidoctor-kroki presentation.adoc
```

On VSCode :

Install Asciidoc Slides : Ctrl+Shift+P :

---

### 4. Preview

Open the generated `presentation.html` in your browser.

Sur VSCode : Installer l'extension **Live Server ou **HTML Preview ou **vscode-reveal******


**`Ctrl+K` puis `R`**

---
