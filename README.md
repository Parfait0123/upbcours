# upbcours : rédiger ses notes de cours au format des UPB

`upbcours` est un modèle LaTeX qui met en forme vos notes de cours selon le « Canevas harmonisé de notes de
cours dans les UPB » : page de garde, droits d'utilisation, remerciements, table des matières, syllabus,
chapitres avec petites icônes dans la marge, résumé et évaluations en fin de chapitre, fiches de TP et de TD.

Vous écrivez le contenu ; le modèle s'occupe de la présentation.

## Télécharger

Cliquez sur le bouton vert **Code → Download ZIP** en haut de cette page, ou récupérez le zip de la dernière
version dans l'onglet **Releases**. Décompressez-le : vous obtenez tous les fichiers décrits ci-dessous.

### Avec Git

Si Git est installé, clonez le dépôt pour récupérer les fichiers et pouvoir suivre les mises à jour :

```bash
git clone https://github.com/parfait0123/eeia-test.git
cd eeia-test
```

Pour récupérer les dernières modifications publiées :

```bash
git pull origin main
```
Pour vérifier l'état de votre copie locale :

```bash
git status
```

Si vous contribuez au modèle, créez une branche avant de modifier les fichiers :

```bash
git switch -c ma-contribution
```

Après vos modifications, vous pouvez les enregistrer et les publier sur GitHub :

```bash
git add .
git commit -m "Décrire brièvement la modification"
git push -u origin ma-contribution
```

Vous pourrez ensuite ouvrir une *pull request* sur GitHub. Ne faites pas `git add .` si votre dossier contient
des fichiers personnels ou des fichiers générés par LaTeX ; ajoutez plutôt les fichiers concernés explicitement.

---

## 1. Ce que contient le dossier

| Élément | À quoi il sert |
|---|---|
| `upbcours.cls` | le modèle lui-même. Ne le modifiez pas. |
| `exemple.tex` | un cours complet d'exemple. **Partez de ce fichier.** |
| `icones/` | les 16 icônes de marge (indispensable) |
| `fonts/` | la police des gros numéros de chapitre (indispensable pour le rendu d'origine) |
| `logos/` | des logos prêts à l'emploi (UAC, UNA, UNSTIM, UP, FAST, armoiries) |
| `syllabus_autonome/` | le canevas de syllabus seul, sur 3 pages |

Pour un nouveau cours, copiez `upbcours.cls`, `icones/` et `fonts/` (et `logos/` si besoin) dans le dossier
de votre document, à côté de votre fichier `.tex`.



## 2. Obtenir le PDF

Le modèle fonctionne avec **pdfLaTeX**. Compilez **deux fois** : la première passe prépare la table des
matières et les en-têtes, la seconde les place.

- **Overleaf** : importez le dossier en zip, ouvrez `exemple.tex` et cliquez sur *Recompile* (deux fois).
  Vérifiez dans *Menu → Compiler* que le compilateur est **pdfLaTeX**.






- **TeXstudio / TeXworks** : choisissez *PDFLaTeX* et lancez la compilation deux fois.


- **Ligne de commande** :

      pdflatex exemple.tex
      pdflatex exemple.tex

Quelques détails utiles :
- La police du texte est *Carlito* (proche de Calibri). Si elle n'est pas installée sur votre ordinateur,
  *Helvetica* la remplace automatiquement : le document reste correct.
- XeLaTeX et LuaLaTeX ne sont pas nécessaires.

## 3. Votre premier document

Voici un cours minimal, complet, à enregistrer sous le nom `moncours.tex` :

```latex
% !TEX program = pdflatex
\documentclass{upbcours}

\upbsetup{
  titre           = {Introduction à l'analyse numérique},
  codes           = {UE MAT-201 -- EC MAT-201-1},
  auteurs         = {Prénom NOM},
  etablissement   = {Université d'Abomey-Calavi (UAC)},
  faculte         = {Faculté des Sciences et Techniques},
  anneeacademique = {2026 – 2027},
  logouniversite  = {logos/uac.jpeg},
  logoufr         = {logos/fast.jpeg},
}

\begin{document}
\frontmatter
\pagedegarde
\pagedroits
\tabledesmatieres

\mainmatter
\chapitreupb{Mon premier chapitre}
\introduction
\begin{survol}
  Résumé du chapitre en deux phrases.
\end{survol}
\sujet{Premier sujet}
Du texte, des formules comme $x^2 + 1$, des listes…
\end{document}
```



**Une règle à retenir** : dans `\upbsetup{…}`, si une valeur contient une virgule, un signe `=` ou un
crochet, mettez-la entre accolades, par exemple `titre = {Algèbre, analyse et probabilités}`. Une faute de
frappe dans le nom d'un réglage provoque un message clair : « Clé inconnue dans \upbsetup ».

## 4. Écrire le contenu

### Structure

| Vous voulez… | Écrivez |
|---|---|
| un chapitre | `\chapitreupb{Titre}` |
| l'introduction du chapitre | `\introduction` |
| un sujet (sous-titre de chapitre) | `\sujet{Titre}` |
| un sous-sujet | `\sousujet{Titre}` |
| une grande partie (Syllabus, Annexes…) | `\partieupb{Titre}` |
| une page de remerciements | `\begin{remerciements} \personne{Nom, rôle} \end{remerciements}` |

Pour renvoyer à un chapitre ou à un sujet, mettez `\label{mon-nom}` juste après son titre, puis `\ref{mon-nom}`
dans le texte.

### Blocs d'un chapitre

```latex
\begin{survol} Résumé du chapitre. \end{survol}

À la fin de ce chapitre, vous serez en mesure de :
\begin{objectifs}
  \item d'énoncer la notion de fonction holomorphe ;
  \item de calculer une intégrale par la méthode des résidus.
\end{objectifs}

Dans ce chapitre, vous verrez les notions suivantes :
\begin{concepts}
  \notion{Résidu}{Coefficient du terme en $1/(z-a)$ du développement de Laurent.}
\end{concepts}
```

À la fin d'un chapitre : `resumechapitre`, `evalformative` et `autoevaluation` s'utilisent comme
`\begin{resumechapitre} … \end{resumechapitre}`.



### Énoncés mathématiques

`theoreme`, `proposition`, `lemme`, `corollaire`, `definition`, `exemple`, `exercice`, `remarque`, `preuve`.
La numérotation est automatique (« Théorème 2.3 »). Un titre est facultatif :

```latex
\begin{theoreme}[de Pythagore]
  Dans un triangle rectangle, $a^2 + b^2 = c^2$.
\end{theoreme}
```

Raccourcis pratiques : `\R \N \Z \Q \C` pour les ensembles de nombres, `\abs{x}` pour la valeur absolue,
`\norm{x}` pour la norme. Si un titre contient une formule, écrivez `\texorpdfstring{$\R$}{R}`.

### Icônes de marge

```latex
\begin{icone}{astuce}      Un conseil pratique.           \end{icone}
\begin{icone}[Attention !]{miseengarde} Légende changée.  \end{icone}
\begin{icone}[-]{note}     Sans légende.                  \end{icone}
```

Icônes disponibles : `duree`, `objectifs`, `preorganisateur`, `survol`, `lecture`, `cas`, `activite`, `jeu`,
`guide`, `miseengarde`, `astuce`, `saviezvous`, `note`, `devoir`, `glossaire`, `evaluation`, `aide`.
La commande `\explicationicones` affiche une page qui explique toutes les icônes aux étudiants.



### Figures, tableaux et code

Les figures (`\includegraphics`), les tableaux (`booktabs`), les légendes (`\caption`) et le code
(`lstlisting`) sont déjà prêts à l'emploi, avec le style du modèle.

## 5. Le syllabus

Remplissez chaque rubrique avec `\sylset{rubrique}{texte}`, puis terminez par `\syllabusupb` :

```latex
\partieupb{Syllabus}
\sylset{formation}{Licence en Mathématiques}
\sylset{semestre}{3}
\sylset{credits}{5}
\sylset{contenu}{\begin{enumerate}\item Équations\item Interpolation\end{enumerate}}
\sylset{evalinter}{x}      % n'importe quel texte coche la case
\syllabusupb
```

Rubriques : `formation grade domaine annee semestre mention specialite ue codeec intituleec masse ct tptd tpe
credits effectifs enseignants contacts prerequis descriptif objectifgeneral objectifsspecifiques contenu
methodes lieu materiel references evalinter evalfinale pcinter pcfinal`.

Une rubrique laissée vide affiche son texte indicatif en gris. Dans un champ court (comme `contacts`),
passez à la ligne avec `\newline`.


## 6. Fiches de TP et de TD

```latex
\fichetp{1}                       % fiche vierge, à remplir à la main
\fichetd[                         % fiche préremplie : tous les champs sont facultatifs
  titre      = {Méthode de Newton},
  duree      = {2 h},
  objectif   = {Appliquer la méthode de Newton.},
  materiel   = {Calculatrice ou Python.},
  consignes  = {\begin{enumerate}\item Calculer 5 itérations.\end{enumerate}},
  restitution= {Compte rendu de 2 pages.}
]{1}
```

Autres champs possibles : `equipe`, `individuel`, `role`, `evaluation`, `reponses`.


## 7. Personnaliser

Tous les réglages se font dans `\upbsetup{…}`, avant `\begin{document}`. Ils sont tous facultatifs : sans eux,
le document suit le canevas officiel.

### Les réglages les plus utiles


| Réglage | Effet | Exemple |
|---|---|---|
| `titre`, `titrecourt`, `codes`, `soustitre`, `auteurs` | identité du cours (le titre court va dans l'en-tête) | `titrecourt={MMI-I}` |
| `etablissement`, `faculte` | établissement et faculté | `etablissement={Université …\\\textbf{(UNSTIM)}}` |
| `anneeacademique`, `datemiseajour`, `dateproduction` | dates (un champ vide est ignoré) | `datemiseajour={\today}` |
| `telephone`, `courriel`, `siteweb` | contacts de la page des droits | `courriel={nom@exemple.bj}` |
| `logouniversite`, `logoufr` | logos de la page de garde et des en-têtes | `logos/unstim.png` |
| `typechapitre` | mot employé : Chapitre, Module, Séquence, Leçon… | `typechapitre={Module}` |
| `numeroter` | numérote les sujets (1.1, 1.2…) | `numeroter=oui` |
| `niveautdm` | profondeur de la table des matières (0, 1 ou 2) | `niveautdm=1` |
| `stylegarde` | style de page de garde, de 0 à 11 (11 = simple, par défaut) | `stylegarde=3` |
| `stylechapitre` | style d'ouverture de chapitre, de 1 à 10 (7 par défaut) | `stylechapitre=2` |
| `couleurtitres`, `couleurfilets`, `couleuronglet` | couleurs (code à 6 caractères, sans `#`) | `couleurtitres={1F3A93}` |
| `couleurfondsyllabus` | fond des pages du syllabus (`FFFFFF` = blanc) | `couleurfondsyllabus={FFFFFF}` |
| `couleurliens` | rend les liens cliquables colorés | `couleurliens={1F3A93}` |
| `interligne`, `espacementparagraphes`, `echelletitres` | confort de lecture | `interligne=1.15` |
| `margeinterieure`, `margeexterieure`, `margehaut`, `margebas` | marges en mm, sans unité | `margeinterieure=30` |
| `icones`, `legendes` | masquer les icônes ou leurs légendes | `icones=non` |
| `tailleicones` | taille des icônes | `tailleicones=12mm` |
| `entete`, `piedpage` | masquer l'en-tête ou le pied de page | `entete=non` |
| `titreresume` | titre de la rubrique de résumé | `titreresume={Résumé du chapitre}` |

Pour les réglages de oui/non, tout ce qui n'est pas `non`, `faux` ou `0` compte pour « oui ».


### Options du document

À placer dans `\documentclass[…]{upbcours}` : `10pt`, `11pt` ou `12pt` (défaut), `oneside` (recto seul) ou
`twoside` (recto verso, défaut), `a4paper` (défaut) ou `letterpaper`, `french` (défaut) ou `english`.
Exemple : `\documentclass[letterpaper,11pt,oneside,english]{upbcours}` produit un document entièrement en
anglais (libellés, syllabus et fiches compris).


### Changer de police

Par défaut, vous n'avez rien à faire. Pour une autre police, chargez son paquet puis indiquez son **nom de
famille LaTeX** (et non son nom habituel) :

```latex
\usepackage{mathpazo}                              % Palatino
\upbsetup{policecorps={ppl}, policetitres={ppl}, policesans={ppl}}
```

Noms courants : `phv` (Helvetica), `ptm` (Times), `ppl` (Palatino), `lmr` et `lmss` (Latin Modern).
La police des formules se choisit avec `policemaths` : `lm` (défaut), `palatino` ou `times`.

### Recettes

```latex
% Version sobre pour imprimer à moindre coût
\upbsetup{icones=non, entete=non, couleurfilets={000000}, couleurtitres={000000}}

% Version compacte (moins de pages)
\documentclass[10pt]{upbcours}
\upbsetup{interligne=1, espacementparagraphes=4pt}
```

## 8. En cas de problème


| Ce que vous voyez | Ce qu'il faut faire |
|---|---|
| Table des matières vide, logos ou en-têtes absents | Compilez une **deuxième fois**. |
| `File '…' not found` pour un logo ou une icône | Vérifiez le nom et le dossier : le chemin part du dossier de votre `.tex` (par exemple `logos/uac.jpeg`). |
| `Clé inconnue dans \upbsetup` | Faute de frappe dans le nom d'un réglage : comparez avec le tableau du § 7. |
| `Icône inconnue` | Le nom n'est pas dans la liste du § 4. |
| Message sur `carlito` dans le journal | Normal : Helvetica est utilisée à la place. Installez le paquet `carlito` pour retrouver la police du canevas. |
| Message sur `fonts/` dans le journal | Le dossier `fonts/` n'est pas à côté de `upbcours.cls` : les numéros de chapitre s'affichent alors en gras simple. |
| Un titre contient une formule et LaTeX se plaint (« Token not allowed in a PDF string ») | Écrivez `\texorpdfstring{$\R$}{R}`. |
| Un `&` ou un `\\` casse un champ du syllabus | Dans les champs courts, passez à la ligne avec `\newline`. |
| Titre de couverture trop long | Raccourcissez-le, ou ajoutez `echelletitres=0.85`. |

## 9. Si vous utilisiez une ancienne version

Rien n'est à modifier : les anciennes commandes (`\titrecours`, `\auteurs`, `\policecorps`…) fonctionnent
toujours. Seule différence : le modèle compile maintenant avec **pdfLaTeX** au lieu de XeLaTeX, et les polices
se désignent par leur nom de famille LaTeX (voir § 7).

La police des gros numéros de chapitre, *Bagel Fat One*, est distribuée sous licence libre SIL OFL
(`fonts/OFL.txt`).

## 10. Licence et contributions

- Le modèle (`upbcours.cls`, `exemple.tex`, `syllabus_autonome/`) est publié sous licence MIT : voir `LICENSE`.
- La police *Bagel Fat One* (`fonts/`) reste sous sa propre licence, la SIL Open Font License : voir `fonts/OFL.txt`.
- Les logos appartiennent à leurs institutions respectives.
- Une erreur, une idée ? Ouvrez une *issue* sur GitHub en joignant le message d'erreur et, si possible, un
  petit fichier `.tex` qui reproduit le problème. Les historiques des versions sont dans `CHANGELOG.md`.
