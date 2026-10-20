# RETEX Mission IA (Typst)

Une seule source, deux versions :

| Version | Commande | Contenu |
| --- | --- | --- |
| publique (défaut) | `make public` ou `typst compile retex.typ RETEX_IA_public.pdf` | aucun logo, sans couverture ni sommaire |
| interne | `make interne` ou `typst compile --input version=interne retex.typ RETEX_IA_interne.pdf` | logos, couverture et sommaire |

`make` (ou `make all`) génère la version publique, puis l'interne si les fichiers privés sont présents.

## Fichiers
- `retex.typ` : le contenu des slides (versionné).
- `terms.typ` : termes anonymisés, communs aux deux versions (versionné) : **le contenu des slides est identique**.
- `config_public.typ` : options de la version publique (aucun logo, pas de pages 1 et 2) (versionné).
- `refs.bib` : références BibTeX ; chaque slide cite ses sources avec un lien cliquable (liste complète en annexe).
- **Fichiers privés, ignorés par git** (voir `.gitignore`) : `config_interne.typ` (logos), `front.typ` (couverture et sommaire) et le dossier `assets/` (logos et images).

La version publique ne référence aucun de ces fichiers privés : un clone du dépôt sans eux compile sans erreur.

## Prérequis
Typst ≥ 0.13 ; aucune extension. Polices : Arial / Arial Black (repli Liberation / DejaVu si absentes).
