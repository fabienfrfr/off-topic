// =====================================================================
//  RETEX – Mission IA  ·  Présentation Typst (16:9, ~30 min)
//  Aucun paquet externe : compile avec `typst compile retex.typ`
//  Polices : Arial / Arial Black (repli automatique sur Liberation / DejaVu)
// =====================================================================

// ---------- Version : public (défaut) ou interne ----------
//   typst compile retex.typ                              -> version publique
//   typst compile --input version=interne retex.typ ...  -> version interne (si config_interne.typ est présent)
#let VERSION = sys.inputs.at("version", default: "public")
#import "terms.typ": T
#import "config_" + VERSION + ".typ": LOGOS, front

// ---------- Palette ----------
#let NAVY = rgb("#043962")
#let DARK = rgb("#063C67")
#let BLUE = rgb("#1D93C9")
#let TINT = rgb("#E8F3FA")
#let TINT2 = rgb("#CFE6F4")
#let MID = rgb("#7FBFE0")
#let GRAY = rgb("#F2F4F7")
#let INK = rgb("#1F2937")
#let YEL = rgb("#FFC72C")

#let SANS = ("Arial", "Liberation Sans", "DejaVu Sans")
#let HEAVY = ("Arial Black", "DejaVu Sans")
#let MONO = ("DejaVu Sans Mono", "Liberation Mono", "Courier New")

// ---------- Page ----------
#set text(font: SANS, size: 11pt, fill: INK, lang: "fr")
#set page(
  width: 10in,
  height: 5.625in,
  margin: (left: 0.4in, right: 0.4in, top: 0.16in, bottom: 0.5in),
  background: place(left + top, rect(
    width: 0.1in, height: 100%,
    fill: gradient.linear(NAVY, BLUE, angle: 90deg), stroke: none)),
  footer: align(right + horizon, context stack(dir: ltr, spacing: 7pt,
    text(size: 15pt, fill: luma(190))[#counter(page).display()],
    ..(if LOGOS.len() > 0 { (text(size: 12pt, fill: luma(200))[|],) } else { () }),
    ..LOGOS.map(l => box(height: l.at(1), image(l.at(0), height: l.at(1)))))),
  footer-descent: 0pt,
)
#set par(leading: 0.5em, spacing: 0.7em)

// ---------- Sources : libellé court + lien cliquable (DOI / éditeur) ----------
#let SRC = (
  binamungu2023bdd: ("Binamungu & Maro, 2023", "https://arxiv.org/abs/2305.05567"),
  solis2011bdd: ("Solis & Wang, 2011", "https://ieeexplore.ieee.org/abstract/document/6068372"),
  lucassen2016qus: ("Lucassen et al., 2016", "https://doi.org/10.1007/s00766-016-0250-x"),
  ricca2009tests: ("Ricca et al., 2009", "https://doi.org/10.1016/j.infsof.2008.01.007"),
  nagappan2008tdd: ("Nagappan et al., 2008", "https://doi.org/10.1007/s10664-008-9062-z"),
  martinez2021crispdm: ("Martínez-Plumed et al., 2021", "https://doi.org/10.1109/TKDE.2019.2962680"),
  sanchez2025toe: ("Sánchez et al., 2025", "https://doi.org/10.3390/app15126465"),
  locke2002goal: ("Locke & Latham, 2002", "https://doi.org/10.1037/0003-066X.57.9.705"),
  stray2022okr: ("Stray et al., 2022", "https://doi.org/10.1145/3529320.3529332"),
  silva2023okr: ("Silva & Souza, 2023", "https://sol.sbc.org.br/index.php/sbsi/article/view/25161"),
  strathern1997goodhart: ("Strathern, 1997", "https://doi.org/10.1002/(SICI)1234-981X(199707)5:3<305::AID-EURO184>3.0.CO;2-4"),
  flyvbjerg2008rcf: ("Flyvbjerg, 2008", "https://doi.org/10.1080/09654310701747936"),
  paleyes2022deploy: ("Paleyes et al., 2022", "https://doi.org/10.1145/3533378"),
  gao2024dailsql: ("Gao et al., 2024", "https://vldb.org/pvldb/volumes/17/paper/Text-to-SQL%20Empowered%20by%20Large%20Language%20Models%3A%20A%20Benchmark%20Evaluation"),
  lei2025spider2: ("Lei et al., 2025", "https://arxiv.org/abs/2411.07763"),
  sequeda2023kg: ("Sequeda et al., 2023", "https://arxiv.org/abs/2311.07509"),
  yao2023react: ("Yao et al., 2023", "https://arxiv.org/abs/2210.03629"),
  ross1977sa: ("Ross, 1977", "https://doi.org/10.1109/TSE.1977.229900"),
  afnorbete: ("NF X50-150", "https://elearning.univ-bejaia.dz/mod/resource/view.php?id=376222"),
  vanriesen2024dor: ("van Riesen & Wagenaar, 2024", "https://ceur-ws.org/Vol-3672/AgileRE-paper1.pdf"),
  schwaber2020scrum: ("Schwaber & Sutherland, 2020", "https://scrumguides.org/scrum-guide.html"),
  kuhrmann2017hybrid: ("Kuhrmann et al., 2017", "https://doi.org/10.1145/3084100.3084104"),
  fastmcpdoc: ("FastMCP, doc.", "https://gofastmcp.com/integrations/fastapi"),
  ossiespec: ("Apache Ossie, doc.", "https://ossie.apache.org"),
  sidemanticdoc: ("Sidemantic, doc.", "https://sidequery-web.pages.dev/sidemantic/adapters"),
  amini2025agentspec: ("Amini et al., 2025", "https://arxiv.org/abs/2510.04173"),
  hou2025mcp: ("Hou et al., 2025", "https://arxiv.org/abs/2503.23278"),
  lewis2020rag: ("Lewis et al., 2020", "https://arxiv.org/abs/2005.11401"),
  jegou2011pq: ("Jégou et al., 2011", "https://doi.org/10.1109/TPAMI.2010.57"),
  pace2025lance: ("Pace et al., 2025", "https://arxiv.org/abs/2504.15247"),
  sculley2015debt: ("Sculley et al., 2015", "https://scholar.google.com/scholar?q=Hidden+Technical+Debt+in+Machine+Learning+Systems"),
  sambasivan2021cascades: ("Sambasivan et al., 2021", "https://doi.org/10.1145/3411764.3445518"),
  bommasani2021fm: ("Bommasani et al., 2021", "https://arxiv.org/abs/2108.07258"),
  brown2020gpt3: ("Brown et al., 2020", "https://arxiv.org/abs/2005.14165"),
  wang2024agents: ("Wang et al., 2024", "https://arxiv.org/abs/2308.11432"),
  ha2018worldmodels: ("Ha & Schmidhuber, 2018", "https://arxiv.org/abs/1803.10122"),
  lecun2022path: ("LeCun, 2022", "https://scholar.google.com/scholar?q=A+Path+Towards+Autonomous+Machine+Intelligence+LeCun"),
  parnas1972modules: ("Parnas, 1972", "https://doi.org/10.1145/361598.361623"),
  noy2023science: ("Noy & Zhang, 2023", "https://doi.org/10.1126/science.adh2586"),
  dellacqua2023jagged: ("Dell'Acqua et al., 2023", "https://doi.org/10.2139/ssrn.4573321"),
  nambiar2022dwdl: ("Nambiar & Mundra, 2022", "https://doi.org/10.3390/bdcc6040132"),
  makridakis2018stat: ("Makridakis et al., 2018", "https://doi.org/10.1371/journal.pone.0194889"),
)
#show link: set text(fill: BLUE)
// Citation inline : (Auteur, année) cliquable
#let S(k) = { let (l, u) = SRC.at(k); link(u, text(size: 0.88em)[(#l)]) }
// Ligne de sources en pied de slide
#let srcline(keys) = keys.map(k => {
  if type(k) == array { let (l, u) = SRC.at(k.at(1)); [#k.at(0) : #link(u)[#l]] }
  else { let (l, u) = SRC.at(k); link(u)[#l] }
}).join([ · ])

// ---------- Briques graphiques ----------
// Flèche horizontale / verticale (polygone, pas de dépendance)
#let harrow(len: 0.26in, col: BLUE) = box(width: len, height: 9pt)[
  #place(left + horizon, line(length: len - 5pt, stroke: 1.6pt + col))
  #place(right + horizon, polygon(fill: col, (0pt, 0pt), (6pt, 4.5pt), (0pt, 9pt)))
]
#let varrow(len: 0.28in, col: BLUE) = box(width: 9pt, height: len)[
  #place(top + center, line(angle: 90deg, length: len - 5pt, stroke: 1.6pt + col))
  #place(bottom + center, polygon(fill: col, (0pt, 0pt), (9pt, 0pt), (4.5pt, 6pt)))
]

// Noeud de diagramme (remplit sa cellule)
#let node(body, fill: TINT, color: NAVY, size: 10.5pt, bold: true, radius: 4pt) = rect(
  width: 100%, height: 100%, fill: fill, radius: radius, inset: 6pt, stroke: none,
  align(center + horizon, text(size: size, weight: if bold { "bold" } else { "regular" }, fill: color, body)))

// Petit titre de section (bleu, capitales)
#let lbl(t) = text(size: 9pt, weight: "bold", fill: BLUE, tracking: 0.04em)[#upper(t)]

// Pastille numérotée
#let badge(n, fill: NAVY) = circle(radius: 9pt, fill: fill, stroke: none,
  align(center + horizon, text(size: 10.5pt, weight: "bold", fill: white)[#n]))

// Flux horizontal : noeuds séparés par des flèches
#let flow(items, h: 0.8in, aw: 0.26in) = {
  let n = items.len()
  let cols = range(2 * n - 1).map(i => if calc.even(i) { 1fr } else { aw })
  let cells = ()
  for (i, it) in items.enumerate() {
    cells.push(it)
    if i < n - 1 { cells.push(align(center + horizon, harrow(len: aw - 4pt))) }
  }
  grid(columns: cols, rows: h, ..cells)
}

// Liste à puces bleues
#let bullets(..items, size: 11.5pt, gap: 11pt) = {
  set list(marker: text(fill: BLUE)[•], body-indent: 7pt, spacing: gap)
  set text(size: size)
  list(..items)
}

// Bandeau « message clé » en bas de slide
#let msg(t) = place(bottom + left, rect(
  width: 7.35in, height: 0.5in, fill: TINT, radius: 8pt, stroke: none, inset: (x: 14pt),
  align(center + horizon, text(size: 10.5pt, weight: "bold", fill: NAVY, t))))

// Repère de section (reprend la numérotation du sommaire) : pastille active + pastilles numérotées
#let SECTIONS = ("Contexte", "Méthode", "Cas d'usage", "Enseignements", "Bilan")
#let tracker(n) = stack(dir: ltr, spacing: 4pt, ..range(5).map(i => {
  if i + 1 == n {
    box(height: 0.2in, fill: NAVY, radius: 10pt, inset: (x: 8pt),
      align(horizon, text(size: 8pt, weight: "bold", fill: white)[#(i + 1) · #SECTIONS.at(i)]))
  } else {
    box(width: 0.2in, height: 0.2in, fill: TINT, stroke: 0.7pt + TINT2, radius: 10pt,
      align(center + horizon, text(size: 8pt, fill: NAVY)[#(i + 1)]))
  }
}))

// Slide de contenu (refs : clés BibTeX citées en pied de slide)
#let slide(title, sub, message: none, refs: (), sec: 0, body) = page[
  #if sec > 0 { place(top + right, tracker(sec)) }
  #text(font: HEAVY, size: 21pt, weight: "bold", fill: NAVY)[#upper(title)]
  #v(-7pt)
  #text(size: 12pt)[#sub]
  #v(0.14in)
  #block(width: 100%, height: 3.75in, body)
  #if message != none { msg(message) }
  #if refs.len() > 0 {
    context {
      let b = block(width: 7.3in, text(size: 7.5pt, fill: luma(110))[*Sources :* #srcline(refs)])
      let h = measure(b).height
      place(bottom + left, dy: 0.08in + h, b)
    }
  }
]

// =====================================================================
// 1-2 · Couverture + sommaire (fournis par la configuration ; vides en version publique)
// =====================================================================
#front(T, (NAVY: NAVY, BLUE: BLUE, DARK: DARK), HEAVY)

// =====================================================================
// 3 · Ma mission
// =====================================================================
// NOTES : à mon arrivée, pas de profil IA dans le service -> triple casquette architecte / PO / tech lead ;
// lien entre besoins opérationnels des métiers, équipes digitales et solutions IA
// Groupe ; 4 missions (faire le lien, identifier, qualifier, transformer) ;
// rôle de facilitateur entre métier, data, architecture et IA.
#slide(T.mission_title,
  T.mission_sub,
  sec: 1,
  message: [Mon rôle : facilitateur entre métier, data, architecture et IA.],
)[
  #grid(columns: (3.9in, 1fr), column-gutter: 0.3in,
    [
      #bullets(size: 11.5pt, gap: 10pt,
        [*Faire le lien* #T.bullet_lien],
        [*Identifier* les processus métiers qui peuvent bénéficier de l'IA],
        [*Qualifier* les initiatives : valeur, faisabilité, conformité],
        [*Transformer* les besoins prioritaires en démonstrateurs et trajectoires d'industrialisation],
      )
      #v(0.12in)
      #rect(width: 100%, fill: TINT, radius: 6pt, stroke: none, inset: 11pt)[
        #text(size: 10.5pt)[*#text(fill: NAVY)[À mon arrivée :]* aucun profil spécialisé en IA dans le service, j'ai porté trois casquettes]
        #v(5pt)
        #grid(columns: (1fr,) * 3, column-gutter: 4pt, rows: 0.36in,
          node(fill: NAVY, color: white, size: 9pt)[Architecte],
          node(fill: NAVY, color: white, size: 9pt)[Product Owner],
          node(fill: NAVY, color: white, size: 9pt)[Tech Lead])
      ]
    ],
    [
      #grid(columns: (1fr, 0.3in, 1.15in, 0.3in, 1fr), rows: (0.7in,) * 3, row-gutter: 0.1in,
        node[#T.besoins_metiers], align(center + horizon, harrow()),
        grid.cell(rowspan: 3, node(fill: NAVY, color: white, size: 10.5pt)[#T.hub]),
        align(center + horizon, harrow()), node(fill: TINT2)[Identifier les usages],
        node[Équipes digitales], align(center + horizon, harrow()),
        align(center + horizon, harrow()), node(fill: TINT2)[Qualifier les initiatives],
        node[Solutions IA Groupe], align(center + horizon, harrow()),
        align(center + horizon, harrow()), node(fill: TINT2)[Créer des démonstrateurs],
      )
      #v(2pt)
      #align(right)[#box(width: 1.5in, align(center, varrow()))]
      #rect(width: 100%, height: 0.5in, fill: BLUE, radius: 4pt, stroke: none,
        align(center + horizon, text(size: 12pt, weight: "bold", fill: white)[Trajectoire d'industrialisation]))
    ],
  )
]

// =====================================================================
// 4 · Le constat initial
// =====================================================================
// NOTES : beaucoup de solutions IA (Groupe, GBU, local) mais peu de visibilité ;
// risque de doublons ; discussions démarrant par l'outil plutôt que par le problème.
#slide("Le constat initial", "Beaucoup d'initiatives, mais une forte fragmentation",
  sec: 1,
  message: [Le premier enjeu n'était pas de développer plus, mais de mieux orienter, mutualiser et prioriser.],
)[
  #let card(n, h, d) = rect(width: 100%, height: 100%, fill: GRAY, radius: 4pt, stroke: none, inset: (x: 10pt),
    grid(columns: (0.45in, 1fr), align: horizon,
      badge(n),
      [#text(weight: "bold", fill: NAVY, size: 11.5pt)[#h] \ #text(size: 10.5pt)[#d]]))
  #grid(columns: (5.2in, 0.5in, 1fr), rows: 3.5in, align: horizon,
    grid(rows: (0.78in,) * 4, row-gutter: 0.12in,
      card(1)[Solutions peu visibles][Les métiers connaissent mal les outils réellement disponibles],
      card(2)[Initiatives dispersées][De nombreuses équipes IA : Groupe, GBU et local],
      card(3)[Risque de doublons][Des solutions déjà développées ailleurs pourraient être refaites],
      card(4)[Approche centrée sur les outils][On démarre par la technologie, pas par un problème métier mesurable],
    ),
    align(center, harrow(len: 0.36in)),
    rect(width: 100%, height: 100%, fill: NAVY, radius: 6pt, stroke: none, inset: 14pt)[
      #text(size: 11pt, weight: "bold", fill: white)[Plutôt que développer davantage :]
      #v(0.12in)
      #for t in ("Orienter", "Mutualiser", "Prioriser") {
        rect(width: 100%, height: 0.7in, fill: white, radius: 4pt, stroke: none,
          align(center + horizon, text(size: 15pt, weight: "bold", fill: NAVY, t)))
        v(0.13in)
      }
    ],
  )
]

// =====================================================================
// 3b · Roadmap de l'IA
// =====================================================================
// NOTES : vision stratégique. 2020 : rupture des modèles de fondation (un modèle général adaptable, GPT-3 / few-shot) ;
// ensuite LLM + RAG (le modèle est ancré dans les données de l'entreprise) ; puis agents (raisonner, planifier, appeler des
// outils via MCP) ; perspective 2030-35 : SI et world models (modèle prédictif de l'entreprise pour simuler et planifier).
// Les paliers 1 à 3 sont documentés ; le palier 2030-35 est une HYPOTHÈSE stratégique (les world models existent en recherche,
// leur application aux SI d'entreprise est une projection). Message : nos choix techniques doivent s'aligner sur la trajectoire.
#slide("Roadmap de l'IA : 2020 vers 2035",
  "Où va la technologie : le cadre dans lequel nos choix doivent s'inscrire",
  sec: 1,
  message: [Nos choix techniques doivent suivre cette trajectoire, pas l'outil du moment.],
  refs: ("bommasani2021fm", "brown2020gpt3", "lewis2020rag", "yao2023react", "wang2024agents", "hou2025mcp", "ha2018worldmodels", "lecun2022path"),
)[
  #let stage(period, fill, color, title, desc, us, dashed: false) = stack(
    rect(width: 100%, height: 0.42in, fill: fill, stroke: none, radius: (top: 4pt),
      align(center + horizon, text(size: 10.5pt, weight: "bold", fill: color, period))),
    rect(width: 100%, height: 2.3in, fill: GRAY, radius: (bottom: 4pt),
      stroke: if dashed { (paint: NAVY, thickness: 1.2pt, dash: "dashed") } else { none }, inset: 10pt)[
      #text(size: 11.5pt, weight: "bold", fill: NAVY)[#title] \
      #v(3pt)
      #text(size: 9.8pt)[#desc] \
      #v(5pt)
      #text(size: 9.5pt, weight: "bold", fill: BLUE)[Pour nous] \
      #text(size: 9.8pt)[#us]
    ],
  )
  #let arr = align(center, pad(top: 0.14in, harrow(len: 0.2in)))
  #grid(columns: (1fr, 0.22in, 1fr, 0.22in, 1fr, 0.22in, 1fr), align: top,
    stage("2020 · Rupture", TINT2, NAVY, "Modèles de fondation",
      [Un modèle pré-entraîné à grande échelle s'adapte à de nombreuses tâches : un modèle général remplace un modèle par tâche #S("bommasani2021fm") #S("brown2020gpt3").],
      [La valeur se déplace vers les données et les usages.]),
    arr,
    stage("2021–24 · LLM + RAG", MID, NAVY, "Un modèle ancré dans les données",
      [Le modèle génère à partir de documents et de bases récupérés à la demande #S("lewis2020rag").],
      [Des données documentées, accessibles et gouvernées.]),
    arr,
    stage("2024–27 · Agents", BLUE, white, "Le modèle agit",
      [Il raisonne, planifie et appelle des outils pour mener une tâche en plusieurs étapes #S("yao2023react") #S("wang2024agents") #S("hou2025mcp").],
      [Des services exposés en API / MCP, avec des droits maîtrisés.]),
    arr,
    stage("2030–35 · Perspective", NAVY, white, "SI et world models",
      [Le SI maintiendrait un modèle prédictif de l'entreprise, utilisable pour simuler et planifier #S("ha2018worldmodels") #S("lecun2022path").],
      [Une couche sémantique et l'état de l'entreprise comme socle. *Hypothèse de travail.*], dashed: true),
  )
  #v(0.1in)
  #rect(width: 100%, height: 0.5in, fill: TINT, radius: 6pt, stroke: none, inset: 10pt, align(horizon,
    text(size: 10pt)[*Lecture stratégique.* Chaque palier réutilise le précédent : données gouvernées, puis outils exposés, puis modèle de l'entreprise. Les trois premiers paliers s'appuient sur la littérature ; 2030–35 est une projection.]))
]

// =====================================================================
// 4 · Partir du besoin métier
// =====================================================================
// NOTES : besoin / cas d'usage / solution ; formalisation systématique ;
// refus de lancer un POC sans pilote métier ni valeur identifiable.
#slide("Partir du besoin métier", "Séparer clairement le besoin, le cas d'usage et la solution",
  sec: 2,
  message: [Un outil IA n'est pas un cas d'usage : la valeur commence par un problème métier bien formulé.],
  refs: ("martinez2021crispdm", "sanchez2025toe"),
)[
  #let col(head, fill, body, extra: none) = stack(
    rect(width: 100%, height: 0.46in, fill: fill, stroke: none,
      align(center + horizon, text(size: 12.5pt, weight: "bold", fill: white, head))),
    rect(width: 100%, height: 0.9in, fill: GRAY, stroke: none, inset: 10pt,
      align(center + horizon, text(size: 11pt, body))),
  )
  #grid(columns: (1fr, 0.3in, 1fr, 0.3in, 1fr), align: top,
    col("BESOIN", NAVY)[Quel problème opérationnel doit être résolu ?],
    align(center, pad(top: 0.55in, harrow())),
    col("CAS D'USAGE", DARK)[Comment l'utilisateur souhaite-t-il résoudre ce problème ?],
    align(center, pad(top: 0.55in, harrow())),
    col("SOLUTION", BLUE)[Quelles briques techniques, données et organisations sont nécessaires ?],
  )
  #v(4pt)
  #align(right, box(width: 3 * 1.0in + 0.2in,
    grid(columns: (1fr,) * 3, column-gutter: 4pt, rows: 0.3in,
      node(fill: TINT2, size: 9.5pt)[Données], node(fill: TINT2, size: 9.5pt)[Technologies],
      node(fill: TINT2, size: 9.5pt)[Organisation])))
  #v(0.08in)
  #grid(columns: (1.45fr, 1fr), column-gutter: 0.2in, rows: 0.9in,
    rect(width: 100%, height: 100%, fill: TINT, radius: 6pt, stroke: none, inset: 16pt, align(horizon)[
      #text(weight: "bold", fill: NAVY, size: 12pt)[Formalisé systématiquement] \
      #v(2pt) Utilisateurs · données · résultats attendus · indicateurs de succès]),
    rect(width: 100%, height: 100%, fill: YEL, radius: 6pt, stroke: none, inset: 16pt, align(horizon)[
      #text(weight: "bold", fill: NAVY, size: 12pt)[Règle d'or] \
      #v(2pt) Pas de POC sans pilote métier ni valeur attendue identifiable]),
  )
  #v(0.06in)
  #text(size: 9pt, fill: luma(70))[Le besoin précède la donnée et le modèle #S("martinez2021crispdm"), et la réussite d'une adoption de l'IA dépend autant de l'organisation et de l'environnement que de la technologie #S("sanchez2025toe").]
]

// =====================================================================
// 4 · Ma méthode (1/2) : le gabarit
// =====================================================================
// NOTES : un seul gabarit pour exprimer besoin + cas d'usage + analyse fonctionnelle.
// Format Gherkin (Given/When/Then) : scénarios lisibles par les métiers et testables ;
// "Afin de / En tant que / Je souhaite" = user story ; indicateurs = base de la priorisation OKR.
// Règle : pas de POC sans pilote métier ni valeur attendue identifiable.
// Inspirations : IDEF0 (entrées / sorties / contraintes / mécanismes), bête à cornes (à qui, sur quoi, dans quel but = définition du besoin),
// DoR / DoD implicites ; fruit de l'expérience du cycle en V et des méthodes agiles (approches hybrides : Kuhrmann et al., 2017).
#slide("Ma méthode : un gabarit unique",
  "Le gabarit que je propose à tous les métiers pour construire ensemble le cas d'usage",
  sec: 2,
  message: [Un langage commun entre métiers, data et IT : le besoin, le scénario et la mesure dans un seul document.],
  refs: ("binamungu2023bdd", "solis2011bdd", "lucassen2016qus", "ricca2009tests", "nagappan2008tdd", ("IDEF0", "ross1977sa"), ("bête à cornes", "afnorbete"), ("DoR", "vanriesen2024dor"), ("DoD", "schwaber2020scrum"), ("cycle en V + agile", "kuhrmann2017hybrid")),
)[
  #let kw(t) = text(weight: "bold", fill: NAVY, t)
  #let st(t) = text(weight: "bold", fill: BLUE, t)
  #let ph(t) = text(style: "italic", fill: rgb("#5B6B7C"), "<" + t + ">")
  #let L(n, ..p) = pad(left: n * 9pt, p.pos().join())
  #let code(h: 100%, ..lines) = rect(width: 100%, height: h, fill: GRAY, radius: 6pt, stroke: none, inset: 9pt,
    text(font: MONO, size: 8.3pt, stack(spacing: 3pt, ..lines)))
  #grid(columns: (1fr,) * 3, column-gutter: 0.12in, rows: (auto, 2.05in), row-gutter: 3pt,
    lbl[Qui · pourquoi · contexte], lbl[Scénario], lbl[Sorties · moyens · mesure],
    code(
      L(0, kw[Fonctionnalité :], " ", ph("Nom du cas d'usage")),
      v(2pt),
      L(0, kw[Objectif :]),
      L(1, st[Afin de], " ", ph("Valeur métier")),
      L(1, st[En tant que], " ", ph("Utilisateur / Rôle")),
      L(1, st[Je souhaite], " ", ph("Besoin")),
      v(2pt),
      L(0, kw[Contexte :]),
      L(1, st[Étant donné que :]),
      L(1, "- ", ph("Contrainte métier")),
      L(1, "- ", ph("Système concerné")),
      v(2pt),
      L(0, kw[Données d'entrée :]),
      L(1, "- ", ph("Entrée 1")),
      L(1, "- ", ph("Entrée 2")),
    ),
    stack(
      code(h: 1.0in,
        L(0, kw[Scénario :], " ", ph("Nom du scénario")),
        L(1, st[Étant donné], " ", ph("Contexte métier")),
        L(1, st[Quand], " ", ph("Action utilisateur")),
        L(1, st[Alors], " ", ph("Résultat attendu")),
        L(1, st[Et], " ", ph("Résultat complémentaire")),
      ),
      v(0.1in),
      rect(width: 100%, height: 0.93in, fill: TINT, radius: 6pt, stroke: none, inset: 9pt, align(horizon,
        text(size: 9.5pt)[*#text(fill: NAVY)[Scénario = critère d'acceptation.]* Le Given / When / Then décrit un exemple concret, testable avec les métiers, en langage semi-structuré.])),
    ),
    code(
      L(0, kw[Données de sortie :]),
      L(1, "- ", ph("Sortie 1")),
      L(1, "- ", ph("Sortie 2")),
      v(2pt),
      L(0, kw[Sources de données :]),
      L(1, "- ", ph("Système 1")),
      L(1, "- ", ph("Système 2")),
      v(2pt),
      L(0, kw[Capacités nécessaires :]),
      L(1, "- Connecteur ", ph("Système 1")),
      L(1, "- Connecteur ", ph("Système 2")),
      v(2pt),
      L(0, kw[Indicateurs de succès :]),
      L(1, "- Temps gagné : ", ph("x % ou x min")),
      L(1, "- Qualité : ", ph("x % d'erreurs en moins")),
      L(1, "- Réduction du risque : ", ph("x % ou indicateur")),
    ),
  )
  #v(0.07in)
  #grid(columns: (1fr,) * 3, column-gutter: 0.12in, rows: 0.68in,
    rect(width: 100%, height: 100%, fill: TINT, radius: 6pt, stroke: none, inset: 8pt, align(horizon,
      text(size: 9pt)[*Langage commun* : scénarios Given / When / Then compréhensibles par tous #S("binamungu2023bdd")])),
    rect(width: 100%, height: 100%, fill: TINT, radius: 6pt, stroke: none, inset: 8pt, align(horizon,
      text(size: 9pt)[*Besoin clarifié et testé* : les tests d'acceptation lèvent les ambiguïtés #S("ricca2009tests"), le test d'abord réduit les défauts de 40 à 90 % #S("nagappan2008tdd")])),
    rect(width: 100%, height: 100%, fill: TINT, radius: 6pt, stroke: none, inset: 8pt, align(horizon,
      text(size: 9pt)[*Mesurable* : entrées, sorties, contraintes et indicateurs de succès alimentent la priorisation OKR])),
  )
  #v(0.06in)
  #rect(width: 100%, height: 0.46in, fill: white, stroke: 0.8pt + TINT2, radius: 6pt, inset: (x: 9pt, y: 4pt), align(horizon,
    text(size: 9pt)[*#text(fill: NAVY)[Inspirations.]* IDEF0 (entrées, sorties, contraintes, mécanismes) · bête à cornes (à qui, sur quoi, dans quel but : définition du besoin) · DoR / DoD implicites. *Fruit de mon expérience du cycle en V et des méthodes agiles : un gabarit qui unifie simplement les deux.*]))
]

// =====================================================================
// 6 · Qualifier et prioriser (OKR)
// =====================================================================
// NOTES : 6 dimensions : la 1 (valeur) devient C = contribution estimée aux KR des OKR de l'entité (0 à 3) ;
// les dimensions 2 à 6 donnent F = faisabilité = score le plus faible (maillon faible, 0 à 3 ; 0 = bloquant).
// Priorité = C x F ; seuils indicatifs : >= 6 prioritaire, 3 à 5 à compléter, < 3 en attente. Règle : pas de POC sans pilote métier.
// Évidence : les objectifs spécifiques et exigeants améliorent la performance (Locke & Latham) ;
// littérature OKR encore limitée (études de cas, cartographie de 30 études).
#slide("Qualifier et prioriser", T.okr_sub,
  sec: 2,
  message: [Priorité = contribution aux OKR × faisabilité : on lance ce qui fait bouger un KR et qui est réalisable.],
  refs: ("locke2002goal", "stray2022okr", "silva2023okr", "strathern1997goodhart", "flyvbjerg2008rcf", "paleyes2022deploy"),
)[
  #let crit(n, h, d) = rect(width: 100%, height: 100%, fill: GRAY, radius: 4pt, stroke: none, inset: 8pt,
    grid(columns: (24pt, 1fr), column-gutter: 2pt, align: top,
      badge(n, fill: BLUE),
      [#text(size: 10.5pt)[#h] \ #text(size: 9.5pt)[#d]]))
  #grid(columns: (5.3in, 0.3in, 1fr), align: top,
    [
      #lbl[6 dimensions : 1 = contribution (C) · 2 à 6 = faisabilité (F)] #v(3pt)
      #grid(columns: (1fr,) * 3, rows: (0.75in,) * 2, gutter: 0.08in,
        crit(1)[*Valeur (C)*][Impact estimé sur les KR],
        crit(2)[*Pilote métier*][Obligatoire pour lancer un POC],
        crit(3)[*Données*][Disponibilité et qualité],
        crit(4)[*Faisabilité technique*][Intégration au SI],
        crit(5)[*Sécurité & conformité*][Confidentialité],
        crit(6)[*Capacité à déployer*][Puis à maintenir],
      )
    ],
    align(center, pad(top: 0.9in, harrow(len: 0.26in))),
    [
      #stack(dir: ttb, spacing: 3pt,
        lbl[Alignement OKR],
        rect(width: 100%, height: 0.42in, fill: NAVY, radius: 4pt, stroke: none,
          align(center + horizon, text(size: 10.5pt, weight: "bold", fill: white)[#T.okr_obj])),
        align(center, varrow(len: 0.17in)),
        rect(width: 100%, height: 0.42in, fill: BLUE, radius: 4pt, stroke: none,
          align(center + horizon, text(size: 10.5pt, weight: "bold", fill: white)[Key Results (KR) mesurables])),
        align(center, rotate(180deg, varrow(len: 0.17in))),
        rect(width: 100%, height: 0.55in, fill: TINT2, radius: 4pt, stroke: none,
          align(center + horizon, text(size: 9.5pt, fill: NAVY)[*Indicateurs de succès du cas d'usage* \ temps gagné · qualité · risque])),
      )
    ],
  )
  #v(0.03in)
  #rect(width: 100%, height: 0.54in, fill: NAVY, radius: 4pt, stroke: none, inset: (x: 10pt),
    align(center + horizon)[
      #text(size: 12.5pt, weight: "bold", fill: white)[Priorité = C × F] \
      #text(size: 9pt, fill: white)[C : contribution estimée aux KR (0 à 3) · F : faisabilité = score le plus faible des dimensions 2 à 6 (0 à 3) · F = 0 est bloquant]
    ])
  #v(0.05in)
  #grid(columns: (1fr,) * 3, column-gutter: 0.1in, rows: 0.46in,
    node(fill: BLUE, color: white, size: 10pt)[Prioritaire · C × F ≥ 6 \ #text(weight: "regular")[Lancer un POC]],
    node(fill: TINT2, size: 10pt)[À compléter · C × F de 3 à 5 \ #text(weight: "regular")[Approfondir le cadrage]],
    node(fill: GRAY, size: 10pt)[Valeur insuffisante · C × F < 3 \ #text(weight: "regular")[Mettre en attente]],
  )
  #v(0.04in)
  #text(size: 9pt, fill: luma(70))[*Garde-fous.* Un indicateur devenu objectif perd sa valeur #S("strathern1997goodhart"). Les seuils sont indicatifs ; les gains se mesurent avec un groupe pilote #S("flyvbjerg2008rcf").]
]

// =====================================================================
// 7 · Portefeuille de cas d'usage
// =====================================================================
// NOTES : recueil auprès des pôles de l'entité, cartographie par maturité, recherche de
// solutions existantes (anti-doublons), comparaison valeur / complexité.
#slide("Un portefeuille de cas d'usage", "Passer d'idées dispersées à une vision consolidée",
  sec: 2,
  message: [Une vision commune des priorités, qui facilite les arbitrages d'investissement.],
)[
  #lbl[Démarche] #v(2pt)
  #flow(h: 0.72in, (
    node[#T.pf_recueil], node[Qualification],
    node[Recherche de solutions existantes], node[Évaluation valeur / complexité],
    node(fill: NAVY, color: white)[Arbitrage et priorisation]))
  #v(0.1in)
  #lbl[Maturité des initiatives] #v(2pt)
  #flow(h: 0.46in, aw: 0.3in, (
    node(size: 11.5pt)[Idéation], node(fill: TINT2, size: 11.5pt)[POC],
    node(fill: MID, size: 11.5pt)[MVP], node(fill: NAVY, color: white, size: 11.5pt)[Production]))
  #v(0.1in)
  #lbl[Thèmes mis en évidence] #v(2pt)
  #grid(columns: (1fr,) * 3, rows: 0.44in, gutter: 0.1in,
    ..("Accès à l'information", "Synthèse documentaire", "Maintenance",
       "Offres", "Qualité", "Exploitation des données").map(t => node(fill: GRAY, size: 10.5pt, t)))
]

// =====================================================================
// 8 · Le SI conversationnel
// =====================================================================
// NOTES : besoin = temps de recherche ; utilisateurs = parc, maintenance, méthodes,
// devis, experts, exploitation ; exemple = obsolescence d'un PN.
#slide("Le SI conversationnel", "Cas d'usage prioritaire : interroger les données métier en langage naturel",
  sec: 3,
  message: [Transformer des données techniques complexes en réponses directement exploitables par les métiers.],
  refs: ("gao2024dailsql", "lei2025spider2"),
)[
  #grid(columns: (4.2in, 1fr), column-gutter: 0.4in,
    [
      #bullets(size: 11.5pt, gap: 9pt,
        [*Besoin :* réduire le temps de recherche d'information dans les systèmes #T.sys_label],
        [*Utilisateurs :* parc, maintenance, méthodes, devis, experts, exploitation],
        [*Principe :* poser une question métier sans connaître les tables ni le SQL],
      )
      #v(0.14in)
      #rect(width: 100%, fill: TINT, radius: 6pt, stroke: none, inset: 14pt,
        text(size: 11.5pt, style: "italic", weight: "bold", fill: NAVY)[
          « Quel est l'impact de l'obsolescence de ce PN sur le parc ? »])
      #v(0.1in)
      #text(size: 10.5pt)[*Restitution :* équipements concernés, criticité, impacts opérationnels, recommandations]
    ],
    [
      #rect(width: 100%, height: 0.55in, fill: TINT, radius: 4pt, stroke: none,
        align(center + horizon, text(fill: NAVY, size: 11.5pt)[*Utilisateur métier* \ #text(size: 9.5pt)[question en langage naturel]]))
      #align(center, varrow(len: 0.26in))
      #rect(width: 100%, height: 0.5in, fill: NAVY, radius: 4pt, stroke: none,
        align(center + horizon, text(size: 11.5pt, weight: "bold", fill: white)[Assistant conversationnel]))
      #align(center, varrow(len: 0.26in))
      #grid(columns: (1fr,) * 3, rows: 0.46in, column-gutter: 0.1in,
        node(fill: TINT2)[#T.db], node(fill: TINT2)[SAP], node(fill: TINT2)[Autres sources])
      #align(center, varrow(len: 0.26in))
      #rect(width: 100%, height: 0.62in, fill: BLUE, radius: 4pt, stroke: none,
        align(center + horizon, text(fill: white, size: 11.5pt)[*Réponse contextualisée* \ #text(size: 10pt)[impact, criticité et recommandation]]))
    ],
  )
]

// =====================================================================
// 9 · Du concept au démonstrateur
// =====================================================================
// NOTES : agent conversationnel + couche MCP sur la base de données SI + services IA sécurisés du Groupe ;
// gains VISÉS (à confirmer avec un groupe pilote).
#slide("Du concept au démonstrateur", T.demo_sub,
  sec: 3,
  message: [Le démonstrateur rend la vision concrète et valide l'intérêt métier avant d'industrialiser.],
  refs: ("yao2023react", "hou2025mcp", "noy2023science", "dellacqua2023jagged"),
)[
  #lbl[Résultats visés] #v(2pt)
  #grid(columns: (1fr,) * 3, column-gutter: 0.14in, rows: 0.95in,
    ..(("30 min → < 1 min", "Recherche d'information"),
       ("1 jour → quelques min", "Analyse d'impact"),
       ("≈ 100", "Utilisateurs potentiels")).map(((big, small)) => rect(
      width: 100%, height: 100%, fill: TINT, radius: 6pt, stroke: none, inset: 6pt,
      align(center + horizon)[#text(size: 16pt, weight: "bold", fill: NAVY)[#big] \ #v(2pt) #text(size: 10.5pt)[#small]])))
  #v(0.1in)
  #lbl[Parcours validé de bout en bout] #v(2pt)
  #flow(h: 0.72in, aw: 0.28in, (
    node[Question métier],
    node(fill: NAVY, color: white)[Agent conversationnel],
    node(fill: TINT2)[Couche MCP],
    node(fill: TINT2)[#T.db \ #text(size: 8.5pt, weight: "regular")[requêtes]],
    node(fill: NAVY, color: white)[Réponse \ #text(size: 8.5pt, weight: "regular")[analyse en langage naturel]]))
  #v(0.1in)
  #bullets(size: 11pt, gap: 5pt,
    [Services IA sécurisés du Groupe : interprétation de la demande et synthèse de la réponse],
    [Question traduite en requêtes, résultats analysés puis restitués en langage naturel],
    [Ordre de grandeur publié : −40 % de temps, +18 % de qualité (essai randomisé, 453 professionnels) #S("noy2023science") ; −25 % de temps (consultants) #S("dellacqua2023jagged"). Nos gains visés sont supérieurs : à valider avec un groupe pilote.],
  )
]

// =====================================================================
// 10 · Les briques techniques
// =====================================================================
// NOTES : WayFlow + PyAgentSpec (agents définis de façon déclarative, portables), FastAPI + FastMCP (FastMCP.from_fastapi :
// les routes deviennent des outils/ressources MCP ; la doc FastMCP recommande des outils MCP curés plutôt qu'une conversion automatique),
// Sidemantic + Apache Ossie (format ouvert d'échange de modèles sémantiques, ex-OSI, en incubation Apache), LanceDB (base vectorielle) ; raisonnement assuré par les services IA sécurisés du Groupe.
// Agent Spec (Oracle) : langage déclaratif indépendant du framework ; PyAgentSpec = SDK Python ; WayFlow = runtime de référence.
#slide("Les briques techniques", "Une architecture légère et modulaire pour le démonstrateur",
  sec: 3,
  message: [Des briques simples et remplaçables : changer de technologie sans reconstruire les usages.],
  refs: ("amini2025agentspec", "hou2025mcp", "fastmcpdoc", "ossiespec", "sidemanticdoc", "lewis2020rag", "jegou2011pq", "pace2025lance", "nambiar2022dwdl", "makridakis2018stat"),
)[
  #let tool(name, tag, desc, role) = rect(width: 100%, height: 100%, fill: GRAY, radius: 6pt, stroke: none, inset: 10pt)[
    #grid(columns: (1fr, auto), align: horizon,
      text(size: 14pt, weight: "bold", fill: NAVY)[#name],
      rect(fill: BLUE, radius: 10pt, stroke: none, inset: (x: 9pt, y: 3pt),
        text(size: 9pt, weight: "bold", fill: white)[#tag]))
    #v(4pt)
    #text(size: 11.5pt)[#desc]
    #v(4pt)
    #text(size: 10pt)[*#text(fill: NAVY)[Rôle ici :]* #role]
  ]
  #grid(columns: (1fr, 1fr), column-gutter: 0.14in, row-gutter: 0.1in, rows: (1.4in, 1.4in),
    tool("WayFlow + PyAgentSpec", "Agents déclaratifs",
      [Agent Spec : langage ouvert, indépendant du framework],
      [PyAgentSpec (SDK Python) définit les agents de façon déclarative ; WayFlow, runtime de référence, les exécute #S("amini2025agentspec")]),
    tool("FastAPI + FastMCP", "API · MCP",
      [Services Python exposés comme serveur MCP],
      [FastAPI expose l'accès aux données ; FastMCP le publie à l'agent comme serveur MCP #S("hou2025mcp") #S("fastmcpdoc")]),
    tool("Sidemantic + Apache Ossie", "Couche sémantique",
      [Règles et indicateurs métier définis une fois],
      [Sidemantic standardise les règles de gestion ; Apache Ossie (ex-OSI, en incubation) est le format ouvert d'échange des modèles #S("ossiespec") #S("sidemanticdoc")]),
    tool("LanceDB", "Base vectorielle",
      [Stockage et recherche par similarité (embeddings)],
      [recherche sémantique (RAG #S("lewis2020rag")), index par quantification #S("jegou2011pq"), format Lance #S("pace2025lance")]),
  )
  #v(0.08in)
  #bullets(size: 10.5pt, gap: 4pt,
    [Raisonnement de l'agent assuré par les services IA sécurisés du Groupe],
    [Choisir la brique selon le besoin plutôt que la tendance : data warehouse ou data lake #S("nambiar2022dwdl"), statistiques classiques ou deep learning #S("makridakis2018stat")],
  )
]

// =====================================================================
// 10 · Le verrou : la donnée
// =====================================================================
// NOTES : données éparpillées (base de données SI, SAP, gconf, HUMS, référentiel de SQL) ; SQL monolithiques ;
// règles dupliquées (SQL, Power BI, Excel) ; cible = couche sémantique.
// Preuves : Sequeda et al. (16 % -> 54 %), Spider 2.0 (21,3 % vs 91,2 %), dette technique ML, data cascades.
#slide("Le verrou : la donnée", "L'IA ne compense pas une architecture de données trop complexe",
  sec: 3,
  message: [Le vrai socle du SI conversationnel n'est pas le chatbot : c'est une donnée métier gouvernée.],
  refs: ("sculley2015debt", "sambasivan2021cascades", "sequeda2023kg", "lei2025spider2"),
)[
  #grid(columns: (2.3in, 0.4in, 3.6in, 0.4in, 1fr), rows: (auto, 1.45in), row-gutter: 3pt,
    lbl[Sources actuelles], [], lbl[Cible : couche sémantique], [], lbl[Résultat],
    grid(rows: (1fr,) * 5, row-gutter: 3pt,
      ..T.chips.map(t => node(fill: GRAY, size: 9pt, t))),
    align(center + horizon, harrow(len: 0.3in)),
    rect(width: 100%, height: 100%, fill: NAVY, radius: 6pt, stroke: none, inset: 8pt,
      grid(rows: (1fr,) * 3, row-gutter: 5pt,
        ..("Objets métier standardisés", "Règles de gestion communes", "Indicateurs gouvernés").map(t => node(fill: white, size: 10.5pt, t)))),
    align(center + horizon, harrow(len: 0.3in)),
    node(fill: BLUE, color: white, size: 12.5pt, radius: 6pt)[Applications IA fiables],
  )
  #v(0.1in)
  #lbl[Le problème actuel] #v(2pt)
  #grid(columns: (1fr,) * 3, column-gutter: 0.14in, rows: 0.74in,
    ..(("Tout dans un même SQL", T.req_card),
       ("Règles dupliquées", "Mêmes règles dans SQL, Power BI, Excel ou d'autres outils"),
       ("Peu adapté aux agents IA", "Traitements difficiles à maintenir et à exploiter par une IA")).map(((h, d)) => rect(
      width: 100%, height: 100%, fill: GRAY, radius: 6pt, stroke: none, inset: 10pt, align(horizon)[
        #text(weight: "bold", fill: NAVY, size: 10.5pt)[#h] \ #v(1pt) #text(size: 9.5pt)[#d]])))
  #v(0.1in)
  #rect(width: 100%, height: 0.6in, fill: TINT, radius: 6pt, stroke: none, inset: 9pt, align(horizon,
    text(size: 9.5pt)[*#text(fill: NAVY)[Preuve expérimentale.]* GPT-4, base SQL d'entreprise : 16 % d'exactitude sur le SQL brut, 54 % avec une représentation sémantique (graphe de connaissances) #S("sequeda2023kg"). Spider 2.0 : un agent (o1-preview) résout 21,3 % des tâches d'entreprise, contre 91,2 % sur Spider 1.0 #S("lei2025spider2").]))
]

// =====================================================================
// 11 · Les enseignements
// =====================================================================
// NOTES : partir du terrain ; pilote métier ; réutiliser Groupe ; sécurité et
// gouvernance dès le cadrage ; mesurer avant d'industrialiser ; architecture modulaire.
#slide("Les enseignements", "Ce qui conditionne réellement la réussite d'une initiative IA",
  sec: 4,
  message: [L'IA est rarement la principale difficulté : donnée, intégration, gouvernance et adoption le sont.],
)[
  #let col(head, fill, ..items) = stack(
    rect(width: 100%, height: 0.46in, fill: fill, stroke: none,
      align(center + horizon, text(size: 11.5pt, weight: "bold", fill: white, head))),
    rect(width: 100%, height: 2.25in, fill: GRAY, stroke: none, inset: 12pt, bullets(size: 11.5pt, gap: 12pt, ..items)),
  )
  #grid(columns: (1fr,) * 4, column-gutter: 0.12in, align: top,
    col("MÉTIER", NAVY, [Partir du terrain, pas de la technologie], [Nommer un pilote responsable de la valeur],
      [Mesurer les gains avant d'industrialiser #S("paleyes2022deploy")]),
    col("DONNÉES", BLUE, [Vérifier la qualité des données #S("sambasivan2021cascades")], [Standardiser les règles de gestion],
      [Impliquer la gouvernance dès le cadrage]),
    col("TECHNOLOGIE", NAVY, [Réutiliser les solutions Groupe avant de développer],
      [Architecture modulaire : technologies remplaçables #S("parnas1972modules")], [Sécurité dès le cadrage]),
    col("ADOPTION", BLUE, [Impliquer les utilisateurs], [Démontrer rapidement], [Accompagner le changement]),
  )
]

// =====================================================================
// 12 · Bilan et prochaines étapes
// =====================================================================
// NOTES : contributions réalisées -> prochaines étapes ; terminer sur la questions / échanges.
#slide("Bilan et prochaines étapes", "Du foisonnement initial à une trajectoire structurée",
  sec: 5,
  message: [D'un intérêt général pour l'IA à une démarche structurée, centrée sur la valeur métier.],
)[
  #let panel(head, fill, bg, body) = stack(
    rect(width: 100%, height: 0.46in, fill: fill, stroke: none,
      align(center + horizon, text(size: 12pt, weight: "bold", fill: white, head))),
    rect(width: 100%, height: 2.55in, fill: bg, stroke: none, inset: 16pt, body),
  )
  #grid(columns: (1fr, 0.5in, 1fr), align: top,
    panel("CONTRIBUTIONS RÉALISÉES", NAVY, GRAY, bullets(size: 11.5pt, gap: 11pt,
      [#T.bilan_role],
      [Méthode de qualification des cas d'usage],
      [#T.bilan_carto],
      [Démonstrateur du SI conversationnel],
      [Prérequis data et architecture identifiés])),
    align(center, pad(top: 1.2in, harrow(len: 0.36in))),
    panel("PROCHAINES ÉTAPES", BLUE, TINT, {
      set enum(numbering: n => text(fill: NAVY, weight: "bold")[#n.], body-indent: 7pt, spacing: 11pt)
      set text(size: 11.5pt)
      enum(
        [Valider les gains avec un groupe pilote],
        [Cibler un périmètre métier limité et mesurable],
        [Construire progressivement la couche sémantique],
        [Sécuriser gouvernance, support et responsabilité produit],
        [Passer du démonstrateur au MVP])
    }),
  )
]

// =====================================================================
// Annexe · Références (non présentée)
// =====================================================================
#page[
  #text(font: HEAVY, size: 21pt, weight: "bold", fill: NAVY)[ANNEXE · RÉFÉRENCES]
  #v(-7pt)
  #text(size: 12pt)[Sources vérifiées qui justifient les approches (BibTeX : refs.bib). Chaque libellé de slide est un lien cliquable.]
  #v(0.1in)
  #set text(size: 6.8pt)
  #show bibliography: set par(spacing: 3.5pt, leading: 0.4em)
  #columns(3, gutter: 0.14in, bibliography("refs.bib", title: none, style: "chicago-author-date", full: true))
]
