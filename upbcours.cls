%% =====================================================================
%%  upbcours.cls  --  Notes de cours au canevas harmonisé des UPB
%%
%%  Reproduction LaTeX du « Canevas harmonisé de notes de cours dans les UPB ».
%%  Moteur : pdfLaTeX (deux passes : table des matières, page de garde).
%%
%%  Principe de conception (v3) : 
%%    - la mise en page découle de la géométrie réelle de la page (geometry) ;
%%    - les tailles de titres suivent la taille de base choisie (10, 11 ou 12 pt) ;
%%    - les largeurs de colonnes sont des fractions de la largeur du texte ;
%%    - la page de garde est dessinée sur une grille qui épouse le format du papier ;
%%    - les titres reposent sur les commandes standard (\chapter, \section...),
%%      donc \label, \ref, la table des matières et les signets PDF fonctionnent.
%%
%%  Tout se règle avec :   \upbsetup{clé=valeur, clé={valeur, avec virgule}, ...}
%%  (liste complète des clés : README.md).
%% =====================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{upbcours}[2026/11/05 v3.1 Notes de cours au canevas harmonise des UPB]

%% ---------- Options de classe -----------------------------------------
%%   10pt | 11pt | 12pt (défaut) ; oneside | twoside (défaut) ;
%%   a4paper (défaut) | letterpaper ; openany (défaut) | openright ;
%%   french (défaut) | english ; draft | final
\newcommand{\upb@size}{12pt}
\newcommand{\upb@basesize}{12}                     % taille de base (nombre), sert à l'échelle des titres
\newcommand{\upb@side}{twoside}
\newcommand{\upb@paper}{a4paper}
\newcommand{\upb@open}{openany}
\newcommand{\upb@draft}{final}
\newif\ifupb@en \upb@enfalse
\DeclareOption{10pt}{\renewcommand{\upb@size}{10pt}\renewcommand{\upb@basesize}{10}}
\DeclareOption{11pt}{\renewcommand{\upb@size}{11pt}\renewcommand{\upb@basesize}{11}}
\DeclareOption{12pt}{\renewcommand{\upb@size}{12pt}\renewcommand{\upb@basesize}{12}}
\DeclareOption{oneside}{\renewcommand{\upb@side}{oneside}}
\DeclareOption{twoside}{\renewcommand{\upb@side}{twoside}}
\DeclareOption{a4paper}{\renewcommand{\upb@paper}{a4paper}}
\DeclareOption{letterpaper}{\renewcommand{\upb@paper}{letterpaper}}
\DeclareOption{openany}{\renewcommand{\upb@open}{openany}}
\DeclareOption{openright}{\renewcommand{\upb@open}{openright}}
\DeclareOption{draft}{\renewcommand{\upb@draft}{draft}}
\DeclareOption{final}{\renewcommand{\upb@draft}{final}}
\DeclareOption{french}{\upb@enfalse}
\DeclareOption{english}{\upb@entrue}
\DeclareOption*{\ClassWarning{upbcours}{Option inconnue : \CurrentOption}}
\ProcessOptions\relax
\LoadClass[\upb@paper,\upb@size,\upb@side,\upb@open,\upb@draft]{report}

%% ---------- Packages ---------------------------------------------------
\RequirePackage[\upb@paper,inner=20mm,outer=20mm,top=30mm,bottom=30mm,
                headheight=18mm,headsep=8mm,footskip=10mm]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\RequirePackage{lmodern}          % base : Latin Modern (formules, code) ; le texte est réglé plus bas
\RequirePackage{amsmath,mathtools,amssymb,amsthm}
\ifupb@en
  \RequirePackage[english]{babel}
\else
  \RequirePackage[french]{babel}
\fi
\RequirePackage{microtype}
\RequirePackage{csquotes}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\usetikzlibrary{babel}   % évite les conflits entre les caractères actifs du français (: ; ! ?) et TikZ
\RequirePackage{pgfkeys}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{multicol}
\RequirePackage{etoolbox}
\RequirePackage{needspace}
\RequirePackage{colortbl}
\RequirePackage{caption}
\RequirePackage{listings}
\RequirePackage{tcolorbox}
\tcbuselibrary{breakable,skins}
\providecommand{\phantomsection}{}

%% ---------- Textes (français / anglais) -------------------------------
% \upb@str{\macro}{texte français}{texte anglais}
\newcommand{\upb@str}[3]{\ifupb@en\def#1{#3}\else\def#1{#2}\fi}
\upb@str{\upb@longlet}{NOTES DE COURS}{COURSE NOTES}
\upb@str{\upb@tdroits}{Droits d’utilisation}{Terms of use}
\upb@str{\upb@xdroits}{Toute utilisation de ce document à des fins commerciales est interdite.}
  {Any commercial use of this document is prohibited.}
\upb@str{\upb@lcontacts}{Contacts}{Contact}
\upb@str{\upb@ltel}{Téléphone}{Phone}
\upb@str{\upb@lmail}{Courriel}{Email}
\upb@str{\upb@lweb}{Site web}{Website}
\newcommand{\upb@lwwwpref}{www.}
\upb@str{\upb@tremerc}{Remerciements (si nécessaire)}{Acknowledgements}
\upb@str{\upb@xremerc}{Les personnes et organismes suivants ont contribué à la réalisation de ce matériel.
  Leur détermination et leur créativité ont permis de développer un matériel de qualité :}
  {The following people and organisations contributed to this material.
  Their determination and creativity made it possible to produce high-quality material:}
\upb@str{\upb@ttdm}{Table des matières}{Table of contents}
\upb@str{\upb@tintro}{Introduction}{Introduction}
\upb@str{\upb@tresume}{Résumé du chapitre ou séquence ou module (facultatif)}{Summary (optional)}
\upb@str{\upb@tevalf}{Évaluation formative}{Formative assessment}
\upb@str{\upb@tautoev}{Auto-évaluation}{Self-assessment}
\upb@str{\upb@ticones}{Icônes de marge}{Margin icons}
\upb@str{\upb@xicones}{Dans ce document, vous remarquerez l’utilisation assez fréquente d’icônes dans la marge de
  gauche. Elles sont là pour vous aider à repérer différentes composantes du cours. Jetez un
  coup d’œil sur l’ensemble des icônes dans le tableau ci-bas — familiarisez-vous avec leur
  signification.}
  {You will notice fairly frequent use of icons in the left margin. They help you spot the different
  components of the course. Have a look at all the icons in the table below and get familiar with
  their meaning.}
\upb@str{\upb@lnotion}{ : }{: }
\upb@str{\upb@typechap}{Chapitre}{Chapter}
\upb@str{\upb@mfigure}{Figure}{Figure}
% environnements de type théorème
\upb@str{\upb@nthm}{Théorème}{Theorem}
\upb@str{\upb@nprop}{Proposition}{Proposition}
\upb@str{\upb@nlem}{Lemme}{Lemma}
\upb@str{\upb@ncor}{Corollaire}{Corollary}
\upb@str{\upb@ndef}{Définition}{Definition}
\upb@str{\upb@nex}{Exemple}{Example}
\upb@str{\upb@nexo}{Exercice}{Exercise}
\upb@str{\upb@nrem}{Remarque}{Remark}
\upb@str{\upb@nproof}{Preuve}{Proof}
% rubriques du syllabus : libellés
\upb@str{\upb@L@formation}{Intitulé de la Formation}{Programme title}
\upb@str{\upb@L@grade}{Grade}{Degree}
\upb@str{\upb@L@domaine}{Domaine}{Field}
\upb@str{\upb@L@annee}{Année académique}{Academic year}
\upb@str{\upb@L@semestre}{Semestre}{Semester}
\upb@str{\upb@L@mention}{Mention}{Major}
\upb@str{\upb@L@specialite}{Spécialité}{Specialty}
\upb@str{\upb@L@ue}{UE}{Teaching unit}
\upb@str{\upb@L@codeec}{Code de l'EC}{Course code}
\upb@str{\upb@L@intituleec}{Intitulé de l'EC}{Course title}
\upb@str{\upb@L@masse}{Masse horaire}{Total hours}
\upb@str{\upb@L@ct}{CT}{Lectures}
\upb@str{\upb@L@tptd}{TP/TD}{Labs/Tut.}
\upb@str{\upb@L@tpe}{TPE}{Self-study}
\upb@str{\upb@L@credits}{Nombre de crédits}{Credits}
\upb@str{\upb@L@effectifs}{Effectifs des apprenants}{Class size}
\upb@str{\upb@L@enseignants}{Chargé(es) de l'enseignement}{Instructor(s)}
\upb@str{\upb@L@contacts}{Contacts}{Contact}
\upb@str{\upb@L@prerequis}{Prérequis}{Prerequisites}
\upb@str{\upb@L@descriptif}{Court descriptif de l'EC}{Short description}
\upb@str{\upb@L@objgen}{Objectif général de l'EC}{General objective}
\upb@str{\upb@L@objspe}{Objectifs spécifiques}{Specific objectives}
\upb@str{\upb@L@contenu}{Contenu de l'enseignement}{Course content}
\upb@str{\upb@L@methodes}{Méthodes d'enseignement}{Teaching methods}
\upb@str{\upb@L@lieu}{Lieu d'apprentissage}{Learning venue}
\upb@str{\upb@L@materiel}{Matériel pédagogique}{Teaching material}
\upb@str{\upb@L@refs}{Lectures et références proposées}{Suggested reading and references}
\upb@str{\upb@L@modalites}{Modalités d'évaluation}{Assessment}
\upb@str{\upb@L@evint}{Évaluation intermédiaire}{Mid-term assessment}
\upb@str{\upb@L@evfin}{Évaluation finale}{Final assessment}
\upb@str{\upb@L@pcint}{\% Évaluation intermédiaire}{\% Mid-term}
\upb@str{\upb@L@pcfin}{\% Évaluation finale}{\% Final}
% fiches de TP / TD
\upb@str{\upb@F@tp}{travaux pratiques}{practical work}
\upb@str{\upb@F@td}{travaux dirigés}{tutorial}
\upb@str{\upb@F@fiche}{Fiche de}{Worksheet:}
\upb@str{\upb@F@enonce}{Énoncé}{Statement}
\upb@str{\upb@F@reponses}{Éléments de réponses}{Answer key}
\upb@str{\upb@F@titre}{Titre :}{Title:}
\upb@str{\upb@F@objectif}{Objectif de l’activité}{Objective of the activity}
\upb@str{\upb@F@duree}{Durée :}{Duration:}
\upb@str{\upb@F@orga}{Organisation / méthodes}{Organisation / methods}
\upb@str{\upb@F@equipe}{équipe (proposer un mode de constitution et de fonctionnement d’équipes)}
  {team (suggest how teams are formed and run)}
\upb@str{\upb@F@indiv}{individuel}{individual}
\upb@str{\upb@F@materiel}{Matériel nécessaire}{Required material}
\upb@str{\upb@F@consignes}{Consignes : questions, protocole, TAF, etc.}{Instructions: questions, protocol, tasks, etc.}
\upb@str{\upb@F@restit}{Mode de restitution}{Format of submission}
\upb@str{\upb@F@role}{Rôle de l’enseignant}{Role of the instructor}
\upb@str{\upb@F@eval}{Mode d’évaluation de l’activité}{Assessment of the activity}

%% ---------- Outils internes -------------------------------------------
% \upb@ouinon{booléen}{valeur} : « non », « false », « faux » ou « 0 » => faux, sinon vrai
\newcommand{\upb@ouinon}[2]{%
  \ifboolexpr{test{\ifstrequal{#2}{non}} or test{\ifstrequal{#2}{false}}
              or test{\ifstrequal{#2}{faux}} or test{\ifstrequal{#2}{0}}
              or test{\ifstrequal{#2}{no}}}%
    {\boolfalse{#1}}{\booltrue{#1}}}
\newbool{upb@head}\booltrue{upb@head}       % en-tête affiché
\newbool{upb@foot}\booltrue{upb@foot}       % pied de page affiché
\newbool{upb@icons}\booltrue{upb@icons}     % icônes de marge affichées
\newbool{upb@caps}\booltrue{upb@caps}       % légendes sous les icônes
\newbool{upb@numsuj}\boolfalse{upb@numsuj}  % numérotation des sujets (1.1, 1.2...)

%% ---------- Polices ---------------------------------------------------
% pdfLaTeX : les polices sont désignées par leur FAMILLE NFSS (phv, ptm, ppl, lmss...), pas par leur
% nom système. Valeurs possibles de chaque clé :
%   auto   : choix automatique (défaut) ; texte = Carlito (≈ Calibri) si le paquet « carlito » est
%            installé, sinon Helvetica (paquet « helvet », toujours présent)
%   aucune : la classe ne touche pas à cette police (chargez vous-même le paquet voulu)
%   <nom>  : nom de famille NFSS d'une police déjà chargée (ex. phv, ppl, lmss)
%   \upbsetup{policecorps=..., policetitres=..., policesans=..., policesyllabus=...,
%             policemaths=..., policemono=...}
% policemaths : lm (Latin Modern, défaut) | palatino | times | aucune
\newcommand{\upb@fcorps}{auto}
\newcommand{\upb@ftitres}{auto}
\newcommand{\upb@fsans}{auto}
\newcommand{\upb@fsyl}{auto}
\newcommand{\upb@fmath}{lm}
\newcommand{\upb@fmono}{auto}
\newcommand{\policecorps}[1]{\renewcommand{\upb@fcorps}{#1}}
\newcommand{\policetitres}[1]{\renewcommand{\upb@ftitres}{#1}}
\newcommand{\policesans}[1]{\renewcommand{\upb@fsans}{#1}}
\newcommand{\cnfont}{\normalfont}               % police des titres (redéfinie en fin de préambule)
\AtEndPreamble{%
  % 1. formules
  \ifdefstring{\upb@fmath}{palatino}{\RequirePackage{mathpazo}}{}%
  \ifdefstring{\upb@fmath}{times}{\RequirePackage{mathptmx}}{}%
  % 2. police sans-serif (\sffamily, \sfdefault)
  \ifdefstring{\upb@fsans}{auto}%
    {\IfFileExists{carlito.sty}%
       {\RequirePackage[sfdefault]{carlito}}%
       {\ClassWarningNoLine{upbcours}{Paquet carlito introuvable : remplacement par Helvetica}%
        \RequirePackage[scaled=.92]{helvet}}}%
    {\ifdefstring{\upb@fsans}{aucune}{}{\renewcommand{\sfdefault}{\upb@fsans}}}%
  % 3. police du texte
  \ifdefstring{\upb@fcorps}{auto}{\renewcommand{\familydefault}{\sfdefault}}%
    {\ifdefstring{\upb@fcorps}{aucune}{}{\renewcommand{\familydefault}{\upb@fcorps}}}%
  % 4. police des titres
  \ifdefstring{\upb@ftitres}{auto}{\renewcommand{\cnfont}{\normalfont}}%
    {\ifdefstring{\upb@ftitres}{aucune}{\renewcommand{\cnfont}{\normalfont}}%
      {\renewcommand{\cnfont}{\fontfamily{\upb@ftitres}\selectfont}}}%
  % 5. police du syllabus
  \ifdefstring{\upb@fsyl}{auto}{\let\upb@fsyl\sfdefault}{}%
  \ifdefstring{\upb@fsyl}{aucune}{\let\upb@fsyl\sfdefault}{}%
  % 6. police à chasse fixe
  \ifdefstring{\upb@fmono}{auto}{}%
    {\ifdefstring{\upb@fmono}{aucune}{}{\renewcommand{\ttdefault}{\upb@fmono}}}}

%% ---------- Couleurs du canevas ---------------------------------------
\definecolor{upbnavy}{HTML}{000080}    % titres
\definecolor{upbor}{HTML}{666699}      % accent des pages de garde à courbes
\definecolor{upbviolet}{HTML}{666699}  % filets d'en-tête / pied de page
\definecolor{upbviolet2}{HTML}{333399} % auteurs
\definecolor{upbgris}{HTML}{E6E6E6}    % onglet gris
\definecolor{upbfiche}{HTML}{0F4761}   % titre des fiches de TP
\definecolor{upblabel}{HTML}{ECECF4}   % fond des libellés du syllabus
\definecolor{upbbandeau}{HTML}{F2F2F2} % bandeau d'en-tête du syllabus
\definecolor{upbfondsyl}{HTML}{E2EFD9} % fond des pages du syllabus
\definecolor{upbtheo}{HTML}{000080}    % théorèmes, propositions, lemmes, corollaires
\definecolor{upbdefn}{HTML}{1B6B5A}    % définitions
\definecolor{upbexem}{HTML}{666699}    % exemples, exercices
\definecolor{upbrem}{HTML}{7F7F7F}     % remarques

%% ---------- Réglages de paragraphe ------------------------------------
% interligne : \interligne{1.08} (1 = simple) ; défaut conservé du canevas.
\newcommand{\interligne}[1]{\linespread{#1}\selectfont}
\setlength{\parindent}{0pt}
\setlength{\parskip}{.5em plus 1pt minus 1pt}
\linespread{1.08}
\raggedbottom
\setlist{nosep,leftmargin=*}
\renewcommand{\labelitemi}{\textbullet}\renewcommand{\labelitemii}{\textbullet}
\renewcommand{\labelitemiii}{\textbullet}\renewcommand{\labelitemiv}{\textbullet}
% babel-french modifie sinon les listes (tirets, marges, alinéas) : on garde la mise en forme de la classe
\ifupb@en\else\frenchsetup{StandardLists=true,IndentFirst=false}\fi
\numberwithin{equation}{chapter}

%% ---------- Paramètres réglables --------------------------------------
\newcommand{\upb@rw}{0.7}          % épaisseur des filets (mm, sans unité)
\newcommand{\upb@tabw}{100}        % largeur de l'onglet gris d'en-tête (mm, sans unité)
\newcommand{\upb@lf}{1.3}          % facteur d'agrandissement des logos d'en-tête
\newcommand{\upb@lh}{12mm}         % hauteur des logos d'en-tête
\newcommand{\upb@sc}{1}            % échelle des titres
\newcommand{\upb@isize}{14mm}      % taille des icônes
\newcommand{\upb@icw}{22mm}        % largeur de la colonne des icônes
\newcommand{\upb@wnot}{.275}       % largeur de la colonne « notion » (fraction de la largeur utile)
\newcommand{\upb@puce}{$\bullet$}  % puce des objectifs
\newcommand{\upb@ncol}{2}          % colonnes des remerciements
\newcommand{\upb@icdir}{icones/}   % dossier des icônes
% \upb@fs{taille}{interligne} : taille FIXE (pages de garde), multipliée par l'échelle des titres
\newcommand{\upb@fs}[2]{\fontsize{\fpeval{#1*\upb@sc}}{\fpeval{#2*\upb@sc}}\selectfont}
% \upb@fh{taille}{interligne} : taille de TITRE du texte courant ; les valeurs sont données
% pour le corps 12 pt et suivent l'option de classe (10pt, 11pt, 12pt)
\newcommand{\upb@fh}[2]{\fontsize{\fpeval{#1*\upb@sc*\upb@basesize/12}}{\fpeval{#2*\upb@sc*\upb@basesize/12}}\selectfont}

%% ---------- Repère de la page de garde -------------------------------
% Les pages de garde sont composées sur une grille de 210 x 297 unités (le format A4 en mm),
% étirée sur le format réel du papier : A4 reste identique, Letter ou autre est épousé.
\newlength{\upb@ux}\newlength{\upb@uy}
\AtBeginDocument{\setlength{\upb@ux}{\dimexpr\paperwidth/210\relax}%
                 \setlength{\upb@uy}{\dimexpr\paperheight/297\relax}}
\tikzset{pgmm/.style={remember picture,overlay,
  x={(\upb@ux,0pt)},y={(0pt,-\upb@uy)},shift={(current page.north west)}}}

%% =====================================================================
%%  Métadonnées du cours
%% =====================================================================
\newcommand{\upb@titre}{[Entrer le titre du cours ici]}
\newcommand{\upb@titrecourt}{}
\newcommand{\upb@codes}{[Entrer l'UE]}
\newcommand{\upb@soustitre}{}
\newcommand{\upb@auteurs}{Auteur(s)}
\newcommand{\upb@etab}{[Nom de l'établissement]}
\newcommand{\upb@fac}{[Nom de la Faculté ou du Département]}
\upb@str{\upb@lannee}{Année académique}{Academic year}
\upb@str{\upb@lmaj}{Mise à jour}{Last update}
\newcommand{\upb@dprod}{[Date de production]}
\newcommand{\upb@dmaj}{[Date de dernière mise à jour]}
\newcommand{\upb@annee}{[Année académique]}
\newcommand{\upb@tel}{[No. de téléphone]}
\newcommand{\upb@mail}{[Adresse de courriel]}
\newcommand{\upb@web}{[Adresse du site web]}
\newcommand{\upb@logouniv}{}
\newcommand{\upb@logoufr}{}
\newcommand{\upb@chapstyle}{7}     % style d'ouverture de chapitre (1 à 10)
\newcommand{\upb@gardestyle}{11}   % style de page de garde (0 = ancienne, 1 à 10 = courbes, 11 = officielle)
\newcommand{\upb@linkcolor}{}      % vide = liens invisibles ; sinon code HTML de la couleur des liens
\newcommand{\upb@htitle}{\ifdefempty{\upb@titrecourt}{\upb@titre}{\upb@titrecourt}}

%% ---------- Interface par clés :  \upbsetup{clé=valeur,...} -----------
\newcommand{\upbsetup}[1]{\pgfkeys{/upb/.cd,#1}}
\pgfkeys{/upb/.cd,
  % --- identité du cours
  titre/.store in=\upb@titre,
  titrecourt/.store in=\upb@titrecourt,
  codes/.store in=\upb@codes,
  soustitre/.store in=\upb@soustitre,
  auteurs/.store in=\upb@auteurs,
  etablissement/.store in=\upb@etab,
  faculte/.store in=\upb@fac,
  libelleannee/.store in=\upb@lannee,
  libellemaj/.store in=\upb@lmaj,
  dateproduction/.store in=\upb@dprod,
  datemiseajour/.store in=\upb@dmaj,
  anneeacademique/.store in=\upb@annee,
  telephone/.store in=\upb@tel,
  courriel/.store in=\upb@mail,
  siteweb/.store in=\upb@web,
  logouniversite/.store in=\upb@logouniv,
  logoufr/.store in=\upb@logoufr,
  typechapitre/.store in=\upb@typechap,
  stylechapitre/.store in=\upb@chapstyle,
  stylegarde/.store in=\upb@gardestyle,
  policenumeros/.code={},   % conservées pour compatibilité, sans effet en pdfLaTeX
  dossierpolices/.code={},
  % --- textes
  libelleonglet/.store in=\upb@longlet,
  titredroits/.store in=\upb@tdroits,
  textedroits/.store in=\upb@xdroits,
  libellecontacts/.store in=\upb@lcontacts,
  libelletelephone/.store in=\upb@ltel,
  libellecourriel/.store in=\upb@lmail,
  libelleweb/.store in=\upb@lweb,
  prefixeweb/.store in=\upb@lwwwpref,
  titreremerciements/.store in=\upb@tremerc,
  texteremerciements/.store in=\upb@xremerc,
  titretdm/.store in=\upb@ttdm,
  titreintroduction/.store in=\upb@tintro,
  titreresume/.store in=\upb@tresume,
  titreevalformative/.store in=\upb@tevalf,
  titreautoevaluation/.store in=\upb@tautoev,
  titreicones/.store in=\upb@ticones,
  texteicones/.store in=\upb@xicones,
  separateurnotion/.store in=\upb@lnotion,
  % --- polices, interligne, paragraphes
  policecorps/.store in=\upb@fcorps,
  policetitres/.store in=\upb@ftitres,
  policesans/.store in=\upb@fsans,
  policesyllabus/.store in=\upb@fsyl,
  policemaths/.store in=\upb@fmath,
  policemono/.store in=\upb@fmono,
  interligne/.code={\interligne{#1}},
  espacementparagraphes/.code={\setlength{\parskip}{#1 plus 1pt minus 1pt}},
  echelletitres/.store in=\upb@sc,
  % --- couleurs (code HTML sans #, ex. 1F3A93)
  couleurtitres/.code={\definecolor{upbnavy}{HTML}{#1}},
  couleuraccent/.code={\definecolor{upbor}{HTML}{#1}},
  couleurfilets/.code={\definecolor{upbviolet}{HTML}{#1}},
  couleurauteurs/.code={\definecolor{upbviolet2}{HTML}{#1}},
  couleuronglet/.code={\definecolor{upbgris}{HTML}{#1}},
  couleurfiche/.code={\definecolor{upbfiche}{HTML}{#1}},
  couleurlibelles/.code={\definecolor{upblabel}{HTML}{#1}},
  couleurbandeau/.code={\definecolor{upbbandeau}{HTML}{#1}},
  couleurfondsyllabus/.code={\definecolor{upbfondsyl}{HTML}{#1}},
  couleurtheoremes/.code={\definecolor{upbtheo}{HTML}{#1}},
  couleurdefinitions/.code={\definecolor{upbdefn}{HTML}{#1}},
  couleurexemples/.code={\definecolor{upbexem}{HTML}{#1}},
  couleurremarques/.code={\definecolor{upbrem}{HTML}{#1}},
  couleurliens/.store in=\upb@linkcolor,
  % --- page (valeurs en mm, sans unité)
  margeinterieure/.code={\geometry{inner=#1mm}},
  margeexterieure/.code={\geometry{outer=#1mm}},
  margehaut/.code={\geometry{top=#1mm}},
  margebas/.code={\geometry{bottom=#1mm}},
  reliure/.code={\geometry{bindingoffset=#1mm}},
  epaisseurfilets/.store in=\upb@rw,
  largeuronglet/.store in=\upb@tabw,
  hauteurlogoentete/.store in=\upb@lh,
  facteurlogoentete/.store in=\upb@lf,
  entete/.code={\upb@ouinon{upb@head}{#1}},
  piedpage/.code={\upb@ouinon{upb@foot}{#1}},
  % --- icônes et blocs
  icones/.code={\upb@ouinon{upb@icons}{#1}},
  legendes/.code={\upb@ouinon{upb@caps}{#1}},
  dossiericones/.code={\renewcommand{\upb@icdir}{#1}\graphicspath{{#1}{./}}},
  tailleicones/.store in=\upb@isize,
  largeurcolonneicones/.store in=\upb@icw,
  puceobjectifs/.store in=\upb@puce,
  largeurnotions/.store in=\upb@wnot,
  % --- structure
  numeroter/.code={\upb@ouinon{upb@numsuj}{#1}\ifbool{upb@numsuj}{\setcounter{secnumdepth}{2}}{\setcounter{secnumdepth}{0}}},
  niveautdm/.code={\setcounter{tocdepth}{#1}},
  colonnesremerciements/.store in=\upb@ncol,
  aidessyllabus/.code={},   % conservée pour compatibilité, sans effet
  % --- clé inconnue : message clair
  .unknown/.code={\ClassError{upbcours}{Clé inconnue dans \string\upbsetup : « \pgfkeyscurrentname »}%
    {Consultez la liste des clés dans README.md.}},
}

%% Anciennes commandes (conservées pour compatibilité)
\newcommand{\titrecours}[1]{\upbsetup{titre={#1}}}
\newcommand{\codesue}[1]{\upbsetup{codes={#1}}}
\newcommand{\soustitre}[1]{\upbsetup{soustitre={#1}}}
\newcommand{\auteurs}[1]{\upbsetup{auteurs={#1}}}
\newcommand{\etablissement}[1]{\upbsetup{etablissement={#1}}}
\newcommand{\faculte}[1]{\upbsetup{faculte={#1}}}
\newcommand{\dateproduction}[1]{\upbsetup{dateproduction={#1}}}
\newcommand{\datemiseajour}[1]{\upbsetup{datemiseajour={#1}}}
\newcommand{\anneeacademique}[1]{\upbsetup{anneeacademique={#1}}}
\newcommand{\telephone}[1]{\upbsetup{telephone={#1}}}
\newcommand{\courriel}[1]{\upbsetup{courriel={#1}}}
\newcommand{\siteweb}[1]{\upbsetup{siteweb={#1}}}
\newcommand{\logouniversite}[1]{\upbsetup{logouniversite={#1}}}
\newcommand{\logoufr}[1]{\upbsetup{logoufr={#1}}}
\newcommand{\typechapitre}[1]{\upbsetup{typechapitre={#1}}}
% commandes standard de LaTeX : \title et \author alimentent la page de garde
\renewcommand{\title}[1]{\upbsetup{titre={#1}}}
\renewcommand{\author}[1]{\upbsetup{auteurs={#1}}}

\graphicspath{{icones/}{./}}

%% ---------- Liens et signets PDF (chargés en dernier, après vos extensions) ---
\AtEndPreamble{%
  \RequirePackage{hyperref}%
  \RequirePackage{bookmark}%
  \hypersetup{unicode,bookmarksnumbered,pdfcreator={LaTeX avec upbcours},breaklinks}%
  \ifdefempty{\upb@linkcolor}{\hypersetup{hidelinks}}{%
    \definecolor{upblink}{HTML}{\upb@linkcolor}%
    \hypersetup{colorlinks,linkcolor=upblink,urlcolor=upblink,citecolor=upblink}}%
  % métadonnées du PDF : titre et auteurs du cours (mises en forme neutralisées)
  \pdfstringdefDisableCommands{\def\\{ }\def\newline{ }\let\textbf\@firstofone
    \let\emph\@firstofone\let\textit\@firstofone\let\mathbb\@firstofone}%
  \hypersetup{pdftitle={\upb@titre},pdfauthor={\upb@auteurs}}}

%% =====================================================================
%%  En-têtes et pieds de page
%%  Tout est dessiné par rapport à la boîte d'en-tête / de pied de page réelle
%%  (donc par rapport aux marges choisies), jamais par rapport au coin de la page.
%% =====================================================================
\newlength{\upb@bleed}\setlength{\upb@bleed}{2mm}   % débord de l'onglet hors de la zone de texte
\newcommand{\upb@lgimg}[2]{\ifdefempty{#1}{\footnotesize #2}{%
  \includegraphics[height=\dimexpr\upb@lh*\fpeval{round(\upb@lf*100)}/100\relax,keepaspectratio]{#1}}}
\newcommand{\upb@hchap}{{\small\color{black!65}\leftmark}}
% l'origine (0,0) est le coin gauche de la ligne de base de l'en-tête ; la boîte est de hauteur
% nulle pour que l'en-tête ne dépende pas de \headheight (réglé une fois pour toutes par geometry)
\tikzset{upbhf/.style={baseline=0pt,x=1mm,y=1mm}}
\newcommand{\upb@hfbox}[1]{\raisebox{0pt}[0pt][0pt]{#1}}
\newcommand{\upb@hrule}{-.36*\headsep}      % filet : sous la ligne de base (proportion de l'espace en-tête/texte)
\newcommand{\upb@htabb}{-.43*\headsep}      % bas de l'onglet
\newcommand{\upb@headrecto}{\upb@hfbox{%
  \begin{tikzpicture}[upbhf]
    \path[use as bounding box] (0,0) rectangle (\the\dimexpr\headwidth\relax,0);
    \pgfmathsetmacro{\upb@yr}{(\upb@hrule)/1mm}\pgfmathsetmacro{\upb@yb}{(\upb@htabb)/1mm}%
    \pgfmathsetmacro{\upb@yt}{\upb@yb+7.6}%
    \pgfmathsetmacro{\upb@xw}{\headwidth/1mm}%
    \pgfmathsetmacro{\upb@tx}{\upb@xw+2-\upb@tabw}%
    \fill[upbgris] (\upb@tx,\upb@yb) rectangle (\upb@xw+2,\upb@yt);
    \draw[upbviolet,line width=\upb@rw mm] (0,\upb@yr) -- (\upb@tx,\upb@yr);
    \draw[upbviolet,line width=\upb@rw mm] (\upb@tx,\upb@yb) -- (\upb@tx,\upb@yt) -- (\upb@xw+2,\upb@yt);
    \node[anchor=south west,inner sep=0pt] at (1,\upb@yb+.9)
      {\upb@lgimg{\upb@logouniv}{Logo}};
    \node[anchor=south east,inner sep=0pt,align=right,text width={\upb@tabw mm-6mm}] at (\upb@xw,\upb@yb+1.1)
      {\upb@hchap};
  \end{tikzpicture}}}
\newcommand{\upb@headverso}{\upb@hfbox{%
  \begin{tikzpicture}[upbhf]
    \path[use as bounding box] (0,0) rectangle (\the\dimexpr\headwidth\relax,0);
    \pgfmathsetmacro{\upb@yr}{(\upb@hrule)/1mm}\pgfmathsetmacro{\upb@yb}{(\upb@htabb)/1mm}%
    \pgfmathsetmacro{\upb@yt}{\upb@yb+7.6}%
    \pgfmathsetmacro{\upb@xw}{\headwidth/1mm}%
    \pgfmathsetmacro{\upb@tx}{\upb@tabw-2}%
    \fill[upbgris] (-2,\upb@yb) rectangle (\upb@tx,\upb@yt);
    \draw[upbviolet,line width=\upb@rw mm] (\upb@tx,\upb@yr) -- (\upb@xw,\upb@yr);
    \draw[upbviolet,line width=\upb@rw mm] (-2,\upb@yt) -- (\upb@tx,\upb@yt) -- (\upb@tx,\upb@yb);
    \node[anchor=south west,inner sep=0pt,align=left,text width={\upb@tabw mm-6mm}] at (0,\upb@yb+1.1)
      {\upb@hchap};
    \node[anchor=south east,inner sep=0pt] at (\upb@xw-1,\upb@yb+.9)
      {\upb@lgimg{\upb@logoufr}{Logo UFR}};
  \end{tikzpicture}}}
\newcommand{\upb@footbox}[2]{% #1 = x gauche de la case (mm), #2 = numéro
  \draw[upbviolet,fill=upbgris,line width=\upb@rw mm] (#1,-5.2) rectangle (#1+9.4,1.8);
  \node[inner sep=0pt,font=\cnfont\bfseries\small,text=upbnavy] at (#1+4.7,-1.7) {#2};}
\newcommand{\upb@footrecto}{\upb@hfbox{%
  \begin{tikzpicture}[upbhf]
    \path[use as bounding box] (0,0) rectangle (\the\dimexpr\headwidth\relax,0);
    \pgfmathsetmacro{\upb@xw}{\headwidth/1mm}%
    \draw[upbviolet,line width=\upb@rw mm] (0,-1.7) -- (\upb@xw-9,-1.7);
    \upb@footbox{\upb@xw-9.4}{\thepage}
  \end{tikzpicture}}}
\newcommand{\upb@footverso}{\upb@hfbox{%
  \begin{tikzpicture}[upbhf]
    \path[use as bounding box] (0,0) rectangle (\the\dimexpr\headwidth\relax,0);
    \pgfmathsetmacro{\upb@xw}{\headwidth/1mm}%
    \draw[upbviolet,line width=\upb@rw mm] (9,-1.7) -- (\upb@xw,-1.7);
    \upb@footbox{0}{\thepage}
  \end{tikzpicture}}}

\fancypagestyle{upb}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}\renewcommand{\footrulewidth}{0pt}%
  \fancyhead[RO]{\ifbool{upb@head}{\upb@headrecto}{}}%
  \fancyhead[LE]{\ifbool{upb@head}{\upb@headverso}{}}%
  \fancyfoot[RO]{\ifbool{upb@foot}{\upb@footrecto}{}}%
  \fancyfoot[LE]{\ifbool{upb@foot}{\upb@footverso}{}}%
}
\pagestyle{upb}
\let\ps@plain\ps@upb        % première page d'un chapitre : même en-tête et même pied de page

%% =====================================================================
%%  Titres : reposent sur \chapter, \section, \subsection (standard LaTeX)
%%    \chapitreupb = \chapter      \sujet = \section      \sousujet = \subsection
%%  Les formes étoilées, \label, \ref, \autoref et les signets PDF fonctionnent.
%% =====================================================================
\newcommand{\upb@bigtitle}[1]{{\cnfont\bfseries\upb@fh{20}{24}\color{upbnavy}#1\par}}
\newcommand{\upb@rule}{\par\noindent\rule{\linewidth}{\upb@rw mm}\par\nobreak}

% numéro de chapitre : « CHAPITRE 3 » ; chiffres en Bagel Fat One (fonts/, licence OFL) converti en
% Type 1 pour pdfLaTeX ; repli : police des titres en gras si le dossier fonts/ est absent
\newcommand{\upb@chlabel}{\MakeUppercase{\upb@typechap}\space\thechapter}
\newcommand{\upb@numfont}{\cnfont\bfseries}
\AtEndPreamble{%
  \IfFileExists{fonts/upbbagel.tfm}%
    {\pdfmapfile{+fonts/bagelfatone.map}%
     \DeclareFontFamily{T1}{upbbagel}{}%
     \DeclareFontShape{T1}{upbbagel}{m}{n}{<->fonts/upbbagel}{}%
     \renewcommand{\upb@numfont}{\fontfamily{upbbagel}\fontseries{m}\fontshape{n}}}%
    {\ClassWarningNoLine{upbcours}{Dossier fonts/ introuvable : numeros de chapitre en gras dans la police des titres}}}
\newcommand{\upb@chnum}[1]{{\upb@numfont\fontsize{#1}{#1}\selectfont\thechapter}}
\newcommand{\upb@chtitle}[3]{{\cnfont\bfseries\upb@fh{#1}{#2}#3\par}}
\newcommand{\upb@spaced}[1]{{\cnfont\bfseries\small\textls[120]{#1}}}
\tikzset{upbch/.style={x=1mm,y=1mm,baseline=(current bounding box.north)}}

% 1 -- style d'origine : « Chapitre N », gros filet noir, titre
\newcommand{\upb@chs@i}[1]{%
  {\cnfont\bfseries\upb@fh{22}{26}\color{upbnavy}\upb@typechap\space\thechapter\par}%
  \vspace{9mm}\upb@rule\vspace{1mm}%
  {\cnfont\bfseries\upb@fh{17}{20}#1\par}\vspace{3mm}}
% 2 -- grand numéro à gauche, filet vertical, titre à droite
\newcommand{\upb@chs@ii}[1]{%
  \begin{tikzpicture}[upbch]
    \node[anchor=east,inner sep=0,text=upbnavy] at (30,-15){\upb@chnum{72}};
    \draw[line width=1.4pt,upbnavy] (35,0)--(35,-30);
    \node[anchor=west,inner sep=0,text width=\dimexpr\linewidth-43mm\relax,align=left] at (41,-15){%
      {\color{upbviolet}\upb@spaced{\upb@chlabel}}\par\vspace{2mm}\upb@chtitle{20}{23}{#1}};
  \end{tikzpicture}\par\vspace{6mm}}
% 3 -- bandeau plein bleu marine, titre dessous
\newcommand{\upb@chs@iii}[1]{%
  \begin{tikzpicture}[upbch]
    \fill[upbnavy] (0,0) rectangle (\linewidth,-15);
    \node[anchor=west,inner sep=0,text=white] at (6,-7.5){\upb@chnum{26}\hspace{4mm}\upb@spaced{\upb@typechap}};
    \node[anchor=north west,inner sep=0,text width=\linewidth,align=left,text=upbnavy] at (0,-21){\upb@chtitle{20}{24}{#1}};
  \end{tikzpicture}\par\vspace{6mm}}
% 4 -- numéro dans un cercle, filet fin dessous
\newcommand{\upb@chs@iv}[1]{%
  \begin{tikzpicture}[upbch]
    \node[circle,fill=upbnavy,text=white,minimum size=24mm,inner sep=0] at (12,-12){\upb@chnum{40}};
    \node[anchor=west,inner sep=0,text width=\dimexpr\linewidth-32mm\relax,align=left] at (32,-12){%
      {\color{upbviolet}\upb@spaced{\upb@chlabel}}\par\vspace{1.5mm}\upb@chtitle{19}{22}{#1}};
    \draw[upbviolet,line width=.6pt] (0,-29)--(\linewidth,-29);
  \end{tikzpicture}\par\vspace{6mm}}
% 5 -- carré bleu avec numéro + bandeau gris pour le titre
\newcommand{\upb@chs@v}[1]{%
  \begin{tikzpicture}[upbch]
    \fill[upbgris] (26,0) rectangle (\linewidth,-26);
    \fill[upbnavy] (0,0) rectangle (26,-26);
    \node[text=white,inner sep=0] at (13,-13){\upb@chnum{48}};
    \node[anchor=west,inner sep=0,text width=\dimexpr\linewidth-38mm\relax,align=left] at (32,-13){%
      {\color{upbviolet}\upb@spaced{\upb@typechap}}\par\vspace{1.5mm}{\color{upbnavy}\upb@chtitle{19}{22}{#1}}};
  \end{tikzpicture}\par\vspace{6mm}}
% 6 -- minimal : étiquette espacée, titre, court trait épais
\newcommand{\upb@chs@vi}[1]{%
  {\color{upbviolet}\upb@spaced{\upb@chlabel}}\par\vspace{3mm}%
  {\color{upbnavy}\upb@chtitle{26}{30}{#1}}\par\vspace{4mm}%
  {\color{upbnavy}\rule{30mm}{2.2mm}}\par\vspace{6mm}}
% 7 -- numéro géant en filigrane à droite
\newcommand{\upb@chs@vii}[1]{%
  \begin{tikzpicture}[upbch]
    \node[anchor=east,inner sep=0,text=upbgris] at (\linewidth,-17){\upb@chnum{130}};
    \node[anchor=west,inner sep=0,text width=\dimexpr\linewidth-30mm\relax,align=left] at (0,-17){%
      {\color{upbviolet}\upb@spaced{\upb@chlabel}}\par\vspace{2mm}{\color{upbnavy}\upb@chtitle{22}{26}{#1}}};
    \draw[upbnavy,line width=1.4pt] (0,-40)--(\linewidth,-40);
  \end{tikzpicture}\par\vspace{6mm}}
% 8 -- cadre arrondi avec onglet (écho de l'en-tête)
\newcommand{\upb@chs@viii}[1]{%
  \begin{tikzpicture}[upbch]
    \draw[upbnavy,line width=1.2pt,rounded corners=2mm] (0,0) rectangle (\linewidth,-22);
    \fill[upbnavy,rounded corners=2mm] (0,0) rectangle (52,8);
    \node[anchor=west,inner sep=0,text=white] at (5,4){\upb@spaced{\upb@chlabel}};
    \node[anchor=west,inner sep=0,text width=\dimexpr\linewidth-12mm\relax,align=left,text=upbnavy] at (6,-11){\upb@chtitle{19}{22}{#1}};
  \end{tikzpicture}\par\vspace{6mm}}
% 9 -- double filet, étiquette et titre centrés
\newcommand{\upb@chs@ix}[1]{%
  \noindent\rule{\linewidth}{1.6pt}\par\vspace{.8mm}\noindent\rule{\linewidth}{.5pt}\par\vspace{5mm}%
  \begin{center}{\color{upbviolet}\upb@spaced{\upb@chlabel}}\par\vspace{2.5mm}%
  {\color{upbnavy}\upb@chtitle{22}{26}{#1}}\end{center}\vspace{1mm}%
  \noindent\rule{\linewidth}{.5pt}\par\vspace{.8mm}\noindent\rule{\linewidth}{1.6pt}\par\vspace{6mm}}
% 10 -- barre verticale pleine avec numéro et mot « chapitre » à la verticale
\newcommand{\upb@chs@x}[1]{%
  \begin{tikzpicture}[upbch]
    \fill[upbnavy] (0,0) rectangle (17,-36);
    \node[text=white,inner sep=0] at (8.5,-9){\upb@chnum{40}};
    \node[text=white,inner sep=0,rotate=90] at (8.5,-26){\upb@spaced{\MakeUppercase{\upb@typechap}}};
    \node[anchor=west,inner sep=0,text width=\dimexpr\linewidth-26mm\relax,align=left,text=upbnavy] at (24,-18){\upb@chtitle{22}{26}{#1}};
  \end{tikzpicture}\par\vspace{6mm}}

\newcommand{\upb@chapterstyle}[1]{%
  \ifcase\upb@chapstyle\upb@chs@i{#1}\or\upb@chs@i{#1}\or\upb@chs@ii{#1}\or\upb@chs@iii{#1}\or
  \upb@chs@iv{#1}\or\upb@chs@v{#1}\or\upb@chs@vi{#1}\or\upb@chs@vii{#1}\or\upb@chs@viii{#1}\or
  \upb@chs@ix{#1}\or\upb@chs@x{#1}\else\upb@chs@i{#1}\fi}

% ouverture d'un chapitre numéroté / non numéroté (crochets standard de la classe report)
\def\@makechapterhead#1{{\upb@chapterstyle{#1}}}
\def\@makeschapterhead#1{{\upb@bigtitle{#1}\vspace{8mm}}}
\renewcommand{\chaptermark}[1]{%
  \markboth{\upb@typechap\space\thechapter\ \textperiodcentered\ #1}%
           {\upb@typechap\space\thechapter\ \textperiodcentered\ #1}}
\newcommand{\chapitreupb}{\chapter}
% titre de premier niveau non numéroté, repris dans la table des matières (Syllabus, Annexes...)
\newcommand{\partieupb}[1]{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{plain}\global\@topnum\z@
  \phantomsection\addcontentsline{toc}{chapter}{#1}\markboth{#1}{#1}%
  \@makeschapterhead{#1}\@afterheading}

% niveaux inférieurs
\renewcommand{\section}{\par\Needspace{5\baselineskip}\@startsection{section}{1}{\z@}%
  {-6mm plus 1mm minus 1mm}{1mm}{\cnfont\bfseries\upb@fh{12}{15}}}
\renewcommand{\subsection}{\par\Needspace{4\baselineskip}\@startsection{subsection}{2}{\z@}%
  {-4mm plus 1mm minus 1mm}{.5mm}{\cnfont\bfseries\upb@fh{11}{14}\color{upbnavy}}}
\renewcommand{\subsubsection}{\par\Needspace{3\baselineskip}\@startsection{subsubsection}{3}{\z@}%
  {-3mm plus 1mm minus 1mm}{.5mm}{\cnfont\bfseries\itshape\upb@fh{11}{14}\color{upbnavy}}}
\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname\hspace{.6em}}
\newcommand{\sujet}{\section}
\newcommand{\sousujet}{\subsection}
\setcounter{secnumdepth}{0}      % défaut : titres de sujets non numérotés (numeroter=oui pour 1.1, 1.2...)
\setcounter{tocdepth}{1}         % défaut : table des matières jusqu'aux sujets (niveautdm)

% titre non numéroté de niveau « sujet », repris dans la table des matières
\newcommand{\upb@usection}[1]{\par\Needspace{5\baselineskip}\phantomsection
  \addcontentsline{toc}{section}{#1}\section*{#1}}
\newcommand{\introduction}{\upb@usection{\upb@tintro}}

% Rubrique avec filet (Résumé, Évaluation formative, Auto-évaluation...)
\newcommand{\rubrique}[1]{%
  \par\Needspace{9\baselineskip}\vspace{7mm}\upb@rule\vspace{1mm}%
  \phantomsection\addcontentsline{toc}{section}{#1}%
  {\cnfont\bfseries\upb@fh{15}{18}#1\par}\vspace{2mm}}

%% Pagination : commandes usuelles des livres
\newcommand{\frontmatter}{\clearpage\pagenumbering{roman}}
\newcommand{\mainmatter}{\clearpage\pagenumbering{arabic}}
\newcommand{\backmatter}{\clearpage}

%% =====================================================================
%%  Icônes de marge
%%  Un bloc à icône se coupe normalement d'une page à l'autre et sa hauteur
%%  minimale est celle de l'icône (légende comprise).
%% =====================================================================
\newcommand{\upb@defineicon}[3]{%
  \expandafter\def\csname upb@icf@#1\endcsname{#2}%
  \expandafter\def\csname upb@icc@#1\endcsname{#3}}
% \upb@ic{clé}{fichier}{légende française}{légende anglaise}
\newcommand{\upb@ic}[4]{\upb@defineicon{#1}{#2}{\ifupb@en #4\else #3\fi}}
\upb@ic{duree}{duree}{Durée}{Duration}
\upb@ic{objectifs}{objectifs}{Objectifs}{Objectives}
\upb@ic{preorganisateur}{preorganisateur}{Pré-organisateur /Résumé}{Advance organiser / Summary}
\upb@ic{survol}{preorganisateur}{Survol}{Overview}
\upb@ic{lecture}{lecture}{Lecture}{Reading}
\upb@ic{cas}{cas}{Cas/Problème}{Case / Problem}
\upb@ic{activite}{activite}{Activité}{Activity}
\upb@ic{jeu}{jeu}{Jeu}{Game}
\upb@ic{guide}{guide}{Guide référence}{Reference guide}
\upb@ic{miseengarde}{miseengarde}{Mise en garde}{Warning}
\upb@ic{astuce}{astuce}{Astuce}{Tip}
\upb@ic{saviezvous}{saviezvous}{Saviez-vous ?}{Did you know?}
\upb@ic{note}{note}{Note}{Note}
\upb@ic{devoir}{devoir}{Devoir/Travail}{Assignment}
\upb@ic{glossaire}{glossaire}{Glossaire}{Glossary}
\upb@ic{evaluation}{evaluation}{Évaluation}{Assessment}
\upb@ic{aide}{aide}{Aide}{Help}

% Créer ou remplacer une icône :  \nouvelleicone{clé}{fichier-image}{Légende}
\newcommand{\nouvelleicone}[3]{\upb@defineicon{#1}{#2}{#3}}
% Changer seulement la légende d'une icône :  \legendeicone{clé}{Nouvelle légende}
\newcommand{\legendeicone}[2]{\expandafter\def\csname upb@icc@#1\endcsname{#2}}

\newcommand{\upb@icon}[1]{\includegraphics[width=\upb@isize,height=\upb@isize,keepaspectratio]{\csname upb@icf@#1\endcsname}}
% colonne « icône + légende » (utilise \upb@key et \upb@cap)
\newcommand{\upb@iconcol}{\parbox[t]{\upb@icw}{\centering\upb@icon{\upb@key}\par
  \ifbool{upb@caps}{\ifdefstring{\upb@cap}{-}{}{{\color{upbnavy}\small\upb@cap\par}}}{}}}
\newlength{\upb@iconh}\newlength{\upb@lpad}
\newtcolorbox{upb@iconbox}{enhanced,breakable,blanker,
  before skip=8pt plus 2pt,after skip=10pt plus 2pt,
  left=\upb@lpad,right=0pt,top=0pt,bottom=0pt,boxsep=0pt,
  height from={\upb@iconh} to {\textheight},
  before upper={\setlength{\parskip}{4pt plus 1pt}\ignorespaces},
  overlay unbroken and first={\ifbool{upb@icons}{\node[anchor=north west,inner sep=0pt] at (frame.north west){\upb@iconcol};}{}}}

% \begin{icone}[légende]{clé} ... \end{icone}    légende « - » = aucune
\newenvironment{icone}[2][]{%
  \edef\upb@key{#2}\def\upb@cap{#1}%
  \ifcsname upb@icf@\upb@key\endcsname\else
    \ClassError{upbcours}{Icône inconnue : \upb@key}%
      {Utilisez une clé existante (voir README.md) ou créez-la avec \string\nouvelleicone.}\fi
  \ifdefempty{\upb@cap}{\edef\upb@cap{\csname upb@icc@\upb@key\endcsname}}{}%
  \ifbool{upb@icons}%
    {\settototalheight{\upb@iconh}{\upb@iconcol}\setlength{\upb@lpad}{\dimexpr\upb@icw+3mm\relax}}%
    {\setlength{\upb@iconh}{0pt}\setlength{\upb@lpad}{0pt}}%
  \begin{upb@iconbox}}{\end{upb@iconbox}}

% Raccourcis des icônes les plus utilisées dans un chapitre
\newenvironment{survol}{\begin{icone}{survol}}{\end{icone}}
\newenvironment{objectifs}{%
  \begin{icone}{objectifs}\begin{itemize}[label=\upb@puce,itemsep=2pt]}%
  {\end{itemize}\end{icone}}
\upb@str{\upb@capconcepts}{Concepts (si nécessaire)}{Concepts (if needed)}
\newenvironment{concepts}{%
  \begin{icone}[\upb@capconcepts]{glossaire}%
  \begin{tabular}{@{}>{\raggedright\cnfont\bfseries}p{\upb@wnot\linewidth}p{\dimexpr\linewidth-\upb@wnot\linewidth-2\tabcolsep\relax}@{}}}%
  {\end{tabular}\end{icone}}
\newcommand{\notion}[2]{#1\upb@lnotion & #2\\[.5em]}

% Rubriques types d'un chapitre
\newenvironment{resumechapitre}{%
  \rubrique{\upb@tresume}%
  \begin{icone}[-]{preorganisateur}}{\end{icone}}
\newenvironment{evalformative}{%
  \rubrique{\upb@tevalf}\begin{icone}[-]{devoir}}{\end{icone}}
\newenvironment{autoevaluation}{%
  \rubrique{\upb@tautoev}\begin{icone}[-]{evaluation}}{\end{icone}}

% Tableau-légende des icônes : 4 colonnes égales sur la largeur utile
\newlength{\upb@cw}\newlength{\upb@ch}
\newcommand{\upb@cellule}[1]{\parbox[c][\upb@ch][c]{\upb@cw}{\centering\upb@icon{#1}\par\vspace{1.5mm}%
  {\color{upbnavy}\small\csname upb@icc@#1\endcsname\par}}}
% Section complète « Icônes de marge » (titre + explication + tableau, jamais séparés)
\newcommand{\explicationicones}{%
  \par\Needspace{.75\textheight}\vspace{3mm}\markboth{\upb@ticones}{\upb@ticones}%
  {\cnfont\itshape\bfseries\upb@fh{14.4}{17.3}\upb@ticones\par}\vspace{2mm}
  \upb@xicones\par\legendeicones}
\newcommand{\legendeicones}{%
  \begin{center}
  \setlength{\arrayrulewidth}{.5pt}\arrayrulecolor{upbnavy}%
  \setlength{\upb@cw}{\dimexpr(\linewidth-8\tabcolsep-5\arrayrulewidth)/4\relax}%
  \setlength{\upb@ch}{.135\textheight}%
  \renewcommand{\arraystretch}{1.15}%
  \begin{tabular}{|c|c|c|c|}\hline
    \upb@cellule{duree}&\upb@cellule{objectifs}&\upb@cellule{preorganisateur}&\upb@cellule{lecture}\\\hline
    \upb@cellule{cas}&\upb@cellule{activite}&\upb@cellule{jeu}&\upb@cellule{guide}\\\hline
    \upb@cellule{miseengarde}&\upb@cellule{astuce}&\upb@cellule{saviezvous}&\upb@cellule{note}\\\hline
    \upb@cellule{devoir}&\upb@cellule{glossaire}&\upb@cellule{evaluation}&\upb@cellule{aide}\\\hline
  \end{tabular}
  \end{center}}

%% =====================================================================
%%  Pages liminaires
%% =====================================================================
% ligne facultative de la page de garde (ignorée si le champ est vide)
\newcommand{\upb@optline}[1]{\ifdefempty{#1}{}{#1\\}}

\newcommand{\upb@cv@o}{%
  \begin{tikzpicture}[pgmm]
    % logo université
    \ifdefempty{\upb@logouniv}{%
      \draw[line width=.4pt] (22.2,25.2) rectangle (62.3,44.6);
      \node[inner sep=0pt,font=\bfseries\normalsize,align=center] at (42.25,34.9) {LOGO\\UNIVERSITÉ};}{%
      \node[inner sep=0pt] at (42.25,34.9)
        {\includegraphics[width=40mm,height=19.4mm,keepaspectratio]{\upb@logouniv}};}
    % logo UFR
    \ifdefempty{\upb@logoufr}{%
      \draw[line width=.4pt] (144.1,23.8) rectangle (184.2,39.5);
      \node[inner sep=0pt,font=\bfseries\normalsize] at (164.15,31.65) {LOGO UFR};}{%
      \node[inner sep=0pt] at (164.15,31.65)
        {\includegraphics[width=40mm,height=15.7mm,keepaspectratio]{\upb@logoufr}};}
    % onglet « NOTES DE COURS »
    \draw[upbviolet,line width=1.1mm] (25,53.6) -- (135.8,53.6) -- (135.8,43.4) -- (184.7,43.4);
    \node[anchor=west,inner sep=0pt,font=\cnfont\bfseries\large,text=upbnavy]
      at (144.8,48.9) {\upb@longlet};
    % titre + codes : un seul bloc, les lignes s'empilent même si le titre passe sur 2 lignes
    \node[anchor=north,inner sep=0pt,text width=150mm,align=center,text=upbnavy]
      at (105,110.5) {{\cnfont\bfseries\upb@fs{27}{31}\upb@titre\par}\vspace{2mm}%
                      {\cnfont\bfseries\upb@fs{16}{19}\upb@codes\par}};
    % sous-titre (hauteur réservée même s'il est vide), puis auteurs juste en dessous
    \node[anchor=north,inner sep=0pt,minimum height=9mm,text width=150mm,align=center,
          font=\cnfont\bfseries\upb@fs{18}{21},text=upbnavy] (upbst)
      at (105,152.5) {\upb@soustitre};
    \node[anchor=north,inner sep=0pt,text width=150mm,align=center,
          font=\cnfont\bfseries\upb@fs{18}{21},text=upbviolet2]
      at ([yshift=-8mm]upbst.south) {\upb@auteurs};
    \node[inner sep=0pt,text width=150mm,align=center,font=\cnfont\bfseries\fontsize{13}{17}\selectfont,text=upbnavy]
      at (105,253) {\upb@optline{\upb@etab}\upb@optline{\upb@fac}\upb@optline{\upb@dprod}%
                    \upb@optline{\upb@dmaj}\ifdefempty{\upb@annee}{}{\upb@annee}};
  \end{tikzpicture}}

%% ---- Pages de garde « courbes » : dix styles, \upbsetup{stylegarde=N} (0 = d'origine) ----
% faisceau de courbes (d'après le motif fourni) ; origine = coin bas-droit, unité = cm, y vers le haut
% #1 options de scope (shift en cm, xscale/yscale/scale), #2 couleur principale, #3 accent, #4 intensité
\newcommand{\upb@waves}[4][]{%
  \begin{scope}[x={(1cm,0)},y={(0,1cm)},#1]
    \foreach \i in {0,0.5,...,6}{%
      \draw[#2,opacity={min(1,(0.02+\i/100)*#4)},line width={0.1pt+\i*0.08pt}]
        ({-22+\i*1.5},0) .. controls ({-14+\i},{0.5+\i*0.3}) and ({-5-\i*0.2},{6+\i*0.4}) .. (0,{10-\i*0.5});}
    \foreach \i in {0,0.4,...,4}{%
      \draw[#3,opacity={min(1,(0.05+\i/40)*#4)},line width={0.1pt+\i*0.1pt}]
        ({-18+\i*1.2},0.5) .. controls ({-10+\i},{3+\i*0.4}) and ({-2-\i*0.1},{9+\i*0.3}) .. (0,{14-\i*0.4});}
    \foreach \i in {0,0.3,...,3}{%
      \draw[#2,opacity={min(1,(0.1+\i/15)*#4)},line width={0.2pt+\i*0.05pt}]
        ({-15+\i},1) .. controls ({-7+\i},{5+\i*0.5}) and ({-1+\i*0.2},{11+\i*0.2}) .. (0,{17-\i*0.2});}
    \foreach \i in {0,0.5,...,6}{%
      \draw[#2,opacity={min(1,(0.03+\i/30)*#4)},line width={0.1pt+\i*0.12pt}]
        ({-21+\i*1.2},0) .. controls ({-16+\i},{2+\i*0.5}) and ({-10-\i*0.5},{10+\i}) .. (0,{15-\i*0.8});}
    \draw[#3,line width=1.4pt,opacity=0.7] (-15,1) .. controls (-7,5) and (-1,11) .. (0,17);
    \foreach \p in {0.25,0.5,0.75}{%
      \path (-15,1) .. controls (-7,5) and (-1,11) .. (0,17)
        node[pos=\p,circle,fill=white,draw=#3,line width=0.6pt,inner sep=1.2pt]{};}
    \draw[#3,line width=1pt,opacity=0.7] (0,8.1) .. controls (-4.1,4.1) and (-10.1,0.6) .. (-14.1,0);
  \end{scope}}
% logos (rien si le champ est vide) : options, position, largeur, hauteur
\newcommand{\upb@cvlu}[4][]{\ifdefempty{\upb@logouniv}{}{\node[inner sep=0pt,#1] at (#2) {\includegraphics[width=#3,height=#4,keepaspectratio]{\upb@logouniv}};}}
\newcommand{\upb@cvlf}[4][]{\ifdefempty{\upb@logoufr}{}{\node[inner sep=0pt,#1] at (#2) {\includegraphics[width=#3,height=#4,keepaspectratio]{\upb@logoufr}};}}
\tikzset{upbcard/.style={fill=white,rounded corners=2mm,inner sep=2mm}}
\newcommand{\upb@cvinst}{\upb@etab\\\upb@fac}
\newcommand{\upb@cvdates}{\upb@optline{\upb@dprod}\upb@optline{\upb@dmaj}\upb@annee}
\newcommand{\upb@cvtitle}[1]{{\cnfont\bfseries\upb@fs{#1}{\fpeval{#1*1.16}}\upb@titre\par}}
\newcommand{\upb@cvcodes}[1]{{\cnfont\bfseries\upb@fs{#1}{\fpeval{#1*1.2}}\upb@codes\par}}
\newcommand{\upb@cvsub}[1]{\ifdefempty{\upb@soustitre}{}{{\cnfont\bfseries\upb@fs{#1}{\fpeval{#1*1.2}}\upb@soustitre\par}\vspace{3mm}}}
\newcommand{\upb@cvaut}[1]{{\cnfont\bfseries\upb@fs{#1}{\fpeval{#1*1.2}}\upb@auteurs\par}}
\newcommand{\upb@cvfoot}[1]{{\cnfont\bfseries\fontsize{#1}{\fpeval{#1*1.3}}\selectfont\upb@cvinst\\\upb@cvdates}}

% 1 -- Éventail bas-droite, composition centrée
\newcommand{\upb@cv@i}{%
  \begin{tikzpicture}[pgmm]
    \upb@waves[shift={(21,-29.7)}]{upbnavy}{upbor}{1}
    \upb@cvlu{35,33}{45mm}{22mm}\upb@cvlf{175,33}{45mm}{22mm}
    \node[inner sep=0pt,text=upbviolet] at (105,82){\upb@spaced{\upb@longlet}};
    \draw[upbor,line width=1pt] (88,89)--(122,89);
    \node[inner sep=0pt,text width=160mm,align=center,text=upbnavy] at (105,128)
      {\upb@cvtitle{30}\vspace{3mm}{\color{upbviolet}\upb@cvcodes{16}}};
    \node[anchor=north,inner sep=0pt,text width=150mm,align=center,text=upbnavy] at (105,165)
      {\upb@cvsub{18}{\color{upbviolet2}\upb@cvaut{17}}};
    \node[inner sep=0pt,text width=150mm,align=center,text=upbnavy] at (105,266){\upb@cvfoot{12}};
  \end{tikzpicture}}
% 2 -- Asymétrique : texte à gauche, barre, courbes en haut à droite
\newcommand{\upb@cv@ii}{%
  \begin{tikzpicture}[pgmm]
    \upb@waves[shift={(21,0)},yscale=-1,scale=.9]{upbnavy}{upbor}{1}
    \upb@cvlu{47,33}{45mm}{22mm}\upb@cvlf{100,33}{40mm}{22mm}
    \node[anchor=west,inner sep=0pt,text=upbviolet] at (36,108){\upb@spaced{\upb@longlet}};
    \node[anchor=west,inner sep=0pt,text width=140mm,align=left,text=upbnavy] (t) at (36,150)
      {\upb@cvtitle{30}\vspace{3mm}{\color{upbviolet}\upb@cvcodes{16}}\vspace{9mm}%
       \upb@cvsub{18}{\color{upbviolet2}\upb@cvaut{17}}};
    \fill[upbor] ([xshift=-7mm]t.north west) rectangle ([xshift=-4mm]t.south west);
    \draw[upbnavy,line width=.5pt] (25,252)--(185,252);
    \node[anchor=north west,inner sep=0pt,text width=110mm,align=left,text=upbnavy] at (25,256){\upb@cvfoot{11}};
  \end{tikzpicture}}
% 3 -- Bandeau marine en haut, courbes dans le bandeau
\newcommand{\upb@cv@iii}{%
  \begin{tikzpicture}[pgmm]
    \fill[upbnavy] (0,0) rectangle (210,150);
    \begin{scope}\clip (0,0) rectangle (210,150);
      \upb@waves[shift={(21,-15)}]{white}{upbor}{3}\end{scope}
    \draw[upbor,line width=2pt] (0,150)--(210,150);
    \upb@cvlu[upbcard]{35,30}{40mm}{18mm}\upb@cvlf[upbcard]{175,30}{40mm}{18mm}
    \node[inner sep=0pt,text=upbor] at (105,66){\upb@spaced{\upb@longlet}};
    \node[inner sep=0pt,text width=160mm,align=center,text=white] at (105,103)
      {\upb@cvtitle{30}\vspace{3mm}{\color{white!85!upbnavy}\upb@cvcodes{15}}};
    \node[anchor=north,inner sep=0pt,text width=150mm,align=center,text=upbnavy] at (105,172)
      {\upb@cvsub{18}{\color{upbviolet2}\upb@cvaut{17}}};
    \node[inner sep=0pt,text width=150mm,align=center,text=upbnavy] at (105,266){\upb@cvfoot{12}};
  \end{tikzpicture}}
% 4 -- Page entière marine, courbes claires
\newcommand{\upb@cv@iv}{%
  \begin{tikzpicture}[pgmm]
    \fill[upbnavy] (0,0) rectangle (210,297);
    \upb@waves[shift={(21,-29.7)},scale=1.15]{white}{upbor}{3}
    \upb@waves[shift={(0,0)},xscale=-1,yscale=-1,scale=.7]{white}{upbor}{2}
    \upb@cvlu[upbcard]{35,32}{40mm}{18mm}\upb@cvlf[upbcard]{175,32}{40mm}{18mm}
    \node[inner sep=0pt,text=upbor] at (105,84){\upb@spaced{\upb@longlet}};
    \draw[upbor,line width=1pt] (88,91)--(122,91);
    \node[inner sep=0pt,text width=160mm,align=center,text=white] at (105,128)
      {\upb@cvtitle{32}\vspace{3mm}{\color{white!85!upbnavy}\upb@cvcodes{16}}};
    \node[anchor=north,inner sep=0pt,text width=150mm,align=center,text=white] at (105,166)
      {{\color{upbor}\upb@cvsub{18}}\upb@cvaut{17}};
    \node[inner sep=0pt,text width=150mm,align=center,text=white] at (105,266){\upb@cvfoot{12}};
  \end{tikzpicture}}
% 5 -- Colonne latérale marine (logos, établissement), contenu à droite
\newcommand{\upb@cv@v}{%
  \begin{tikzpicture}[pgmm]
    \begin{scope}\clip (62,0) rectangle (210,297);
      \upb@waves[shift={(21,-29.7)}]{upbnavy}{upbor}{1}\end{scope}
    \fill[upbnavy] (0,0) rectangle (62,297);
    \draw[upbor,line width=1.6pt] (62,0)--(62,297);
    \upb@cvlu[upbcard]{31,42}{42mm}{24mm}\upb@cvlf[upbcard]{31,86}{42mm}{24mm}
    \node[inner sep=0pt,text width=50mm,align=center,text=white] at (31,245){\upb@cvfoot{10}};
    \node[anchor=west,inner sep=0pt,text=upbviolet] at (80,72){\upb@spaced{\upb@longlet}};
    \draw[upbor,line width=1pt] (80,79)--(112,79);
    \node[anchor=north west,inner sep=0pt,text width=115mm,align=left,text=upbnavy] at (80,100)
      {\upb@cvtitle{28}\vspace{3mm}{\color{upbviolet}\upb@cvcodes{15}}\vspace{12mm}%
       \upb@cvsub{17}{\color{upbviolet2}\upb@cvaut{16}}};
  \end{tikzpicture}}
% 6 -- Double cadre, courbes bas-gauche, séparateur à losange
\newcommand{\upb@cv@vi}{%
  \begin{tikzpicture}[pgmm]
    \begin{scope}\clip (13,13) rectangle (197,284);
      \upb@waves[shift={(0,-29.7)},xscale=-1]{upbnavy}{upbor}{1}\end{scope}
    \draw[upbnavy,line width=.9mm] (9,9) rectangle (201,288);
    \draw[upbor,line width=.3mm] (13,13) rectangle (197,284);
    \upb@cvlu{50,40}{42mm}{20mm}\upb@cvlf{160,40}{42mm}{20mm}
    \node[inner sep=0pt,text=upbviolet] at (105,78){\upb@spaced{\upb@longlet}};
    \draw[upbor,line width=.8pt] (78,88)--(98,88) (112,88)--(132,88);
    \node[rectangle,rotate=45,draw=upbor,line width=.8pt,fill=white,inner sep=1.4mm] at (105,88){};
    \node[inner sep=0pt,text width=150mm,align=center,text=upbnavy] at (105,130)
      {\upb@cvtitle{30}\vspace{3mm}{\color{upbviolet}\upb@cvcodes{16}}};
    \node[anchor=north,inner sep=0pt,text width=140mm,align=center,text=upbnavy] at (105,172)
      {\upb@cvsub{18}{\color{upbviolet2}\upb@cvaut{17}}};
    \node[inner sep=0pt,text width=140mm,align=center,text=upbnavy] at (105,264){\upb@cvfoot{12}};
  \end{tikzpicture}}
% 7 -- Aligné à droite, barre marine à droite, courbes bas-gauche
\newcommand{\upb@cv@vii}{%
  \begin{tikzpicture}[pgmm]
    \upb@waves[shift={(0,-29.7)},xscale=-1]{upbnavy}{upbor}{1}
    \fill[upbnavy] (198,0) rectangle (210,297);
    \fill[upbor] (198,0) rectangle (210,30);
    \upb@cvlu{112,36}{42mm}{22mm}\upb@cvlf{163,36}{40mm}{22mm}
    \node[anchor=east,inner sep=0pt,text=upbviolet] at (185,82){\upb@spaced{\upb@longlet}};
    \draw[upbor,line width=1pt] (153,89)--(185,89);
    \node[anchor=north east,inner sep=0pt,text width=150mm,align=right,text=upbnavy] at (185,104)
      {\upb@cvtitle{30}\vspace{3mm}{\color{upbviolet}\upb@cvcodes{16}}\vspace{9mm}%
       \upb@cvsub{18}{\color{upbviolet2}\upb@cvaut{17}}};
    \node[anchor=south east,inner sep=0pt,text width=110mm,align=right,text=upbnavy] at (185,278){\upb@cvfoot{11}};
  \end{tikzpicture}}
% 8 -- Diagonale : zone marine découpée en biais
\newcommand{\upb@cv@viii}{%
  \begin{tikzpicture}[pgmm]
    \fill[upbnavy] (0,0)--(210,0)--(210,95)--(0,185)--cycle;
    \begin{scope}\clip (0,0)--(210,0)--(210,95)--(0,185)--cycle;
      \upb@waves[shift={(21,-9.5)}]{white}{upbor}{3}\end{scope}
    \draw[upbor,line width=1.6pt] (0,185)--(210,95);
    \draw[upbnavy,line width=.4pt] (0,191)--(210,101);
    \upb@cvlu[upbcard]{38,28}{38mm}{16mm}\upb@cvlf[upbcard]{172,28}{38mm}{16mm}
    \node[anchor=west,inner sep=0pt,text=upbor] at (25,62){\upb@spaced{\upb@longlet}};
    \node[anchor=north west,inner sep=0pt,text width=135mm,align=left,text=white] at (25,70)
      {\upb@cvtitle{28}\vspace{3mm}{\color{white!85!upbnavy}\upb@cvcodes{15}}};
    \node[anchor=north west,inner sep=0pt,text width=150mm,align=left,text=upbnavy] at (25,206)
      {\upb@cvsub{18}{\color{upbviolet2}\upb@cvaut{17}}};
    \node[anchor=south west,inner sep=0pt,text width=130mm,align=left,text=upbnavy] at (25,280){\upb@cvfoot{11}};
  \end{tikzpicture}}
% 9 -- Typographique : grand titre, courbes discrètes, trois colonnes en pied
\newcommand{\upb@cv@ix}{%
  \begin{tikzpicture}[pgmm]
    \upb@waves[shift={(21,-29.7)},scale=1.3]{upbnavy}{upbor}{.8}
    \upb@cvlu{45,30}{40mm}{18mm}\upb@cvlf{95,30}{40mm}{18mm}
    \draw[upbnavy,line width=.6pt] (25,48)--(185,48);
    \node[anchor=west,inner sep=0pt,text=upbviolet] at (25,76){\upb@spaced{\upb@longlet}};
    \node[anchor=north west,inner sep=0pt,text width=160mm,align=left,text=upbnavy] at (25,86)
      {\upb@cvtitle{40}\vspace{5mm}{\color{upbviolet}\upb@cvcodes{17}}\vspace{5mm}\upb@cvsub{18}};
    \draw[upbnavy,line width=.6pt] (25,240)--(185,240);
    \draw[upbnavy!40,line width=.4pt] (79,245)--(79,276) (133,245)--(133,276);
    \node[anchor=north west,inner sep=0pt,text width=48mm,align=left,text=upbviolet2] at (25,246){\upb@cvaut{12}};
    \node[anchor=north west,inner sep=0pt,text width=48mm,align=left,text=upbnavy] at (85,246){\cnfont\bfseries\fontsize{10.5}{14}\selectfont\upb@cvinst};
    \node[anchor=north west,inner sep=0pt,text width=48mm,align=left,text=upbnavy] at (139,246){\cnfont\bfseries\fontsize{10.5}{14}\selectfont\upb@cvdates};
  \end{tikzpicture}}
% 10 -- Symétrique : courbes des deux coins du bas, composition centrée
\newcommand{\upb@cv@x}{%
  \begin{tikzpicture}[pgmm]
    \upb@waves[shift={(21,-29.7)},scale=.95]{upbnavy}{upbor}{1}
    \upb@waves[shift={(0,-29.7)},xscale=-1,scale=.95]{upbnavy}{upbor}{1}
    \upb@cvlu{50,34}{42mm}{22mm}\upb@cvlf{160,34}{42mm}{22mm}
    \node[inner sep=0pt,text=upbviolet] at (105,76){\upb@spaced{\upb@longlet}};
    \foreach \i in {-3,...,3}{\fill[upbor] ({105+9*\i},86) circle (0.9mm);}
    \node[inner sep=0pt,text width=160mm,align=center,text=upbnavy] at (105,126)
      {\upb@cvtitle{30}\vspace{3mm}{\color{upbviolet}\upb@cvcodes{16}}};
    \node[anchor=north,inner sep=0pt,text width=150mm,align=center,text=upbnavy] at (105,166)
      {\upb@cvsub{18}{\color{upbviolet2}\upb@cvaut{17}}};
    \node[inner sep=0pt,text width=150mm,align=center,text=upbnavy] at (105,266){\upb@cvfoot{12}};
  \end{tikzpicture}}

% 11 -- Page de garde simple : université et école en en-tête, logos de part et d'autre
% bloc « libellé en petites capitales espacées + valeur en gras très espacée » (année, mise à jour)
\newcommand{\upb@cvdatebloc}[2]{\ifdefempty{#2}{}{%
  {\cnfont\fontsize{10}{13}\selectfont\spaceskip=.9em\relax\textls[140]{\MakeUppercase{#1}}\par}\vspace{1.5mm}%
  {\cnfont\bfseries\fontsize{14}{17}\selectfont\spaceskip=.9em\relax\textls[220]{#2}\par}}}
\newcommand{\upb@cv@xi}{%
  \begingroup\let\cnfont\normalfont % police du document (pas de police de titres dédiée)
  \begin{tikzpicture}[pgmm]
    % logos : mêmes dimensions, de part et d'autre, sur le même axe horizontal que le texte
    \upb@cvlu{39,40}{28mm}{28mm}\upb@cvlf{171,40}{28mm}{28mm}
    % texte centré sur la page, en majuscules ; le sigle s'écrit sur sa propre ligne : etablissement={Université ...\\\textbf{(UNSTIM)}}
    \node[inner sep=0pt,text width=100mm,align=center,text=black] at (105,40)
      {\hyphenpenalty=10000\exhyphenpenalty=10000\emergencystretch=3em
       {\cnfont\fontsize{12}{15}\selectfont\MakeUppercase{\upb@etab}\par}\vspace{2.5mm}%
       {\cnfont\fontsize{12}{15}\selectfont\MakeUppercase{\upb@fac}\par}};
    \draw[upbnavy,line width=.6pt] (25,70)--(185,70);
    \node[inner sep=0pt,text=upbviolet] at (105,108){{\cnfont\bfseries\fontsize{20}{24}\selectfont\MakeUppercase{\upb@longlet}}};
    \node[inner sep=0pt,text width=160mm,align=center,text=upbnavy] at (105,155)
      {\upb@cvtitle{32}\vspace{4mm}{\color{upbviolet}\upb@cvcodes{17}}};
    \node[anchor=north,inner sep=0pt,text width=150mm,align=center,text=upbnavy] at (105,195)
      {\upb@cvsub{18}\vspace{1mm}{\color{upbviolet2}\upb@cvaut{18}}};
    % année et mise à jour sur la même ligne (une seule colonne centrée si l'un des deux est vide)
    \ifdefempty{\upb@dmaj}%
      {\node[anchor=south,inner sep=0pt,text width=100mm,align=center,text=upbnavy] at (105,278){\upb@cvdatebloc{\upb@lannee}{\upb@annee}};}%
      {\ifdefempty{\upb@annee}%
        {\node[anchor=south,inner sep=0pt,text width=100mm,align=center,text=upbnavy] at (105,278){\upb@cvdatebloc{\upb@lmaj}{\upb@dmaj}};}%
        {\node[anchor=south,inner sep=0pt,text width=76mm,align=center,text=upbnavy] at (65,278){\upb@cvdatebloc{\upb@lannee}{\upb@annee}};
         \node[anchor=south,inner sep=0pt,text width=76mm,align=center,text=upbnavy] at (145,278){\upb@cvdatebloc{\upb@lmaj}{\upb@dmaj}};}}%
  \end{tikzpicture}\endgroup}

\newcommand{\pagedegarde}{%
  \clearpage\thispagestyle{empty}
  \ifcase\upb@gardestyle\upb@cv@o\or\upb@cv@i\or\upb@cv@ii\or\upb@cv@iii\or\upb@cv@iv\or\upb@cv@v\or
  \upb@cv@vi\or\upb@cv@vii\or\upb@cv@viii\or\upb@cv@ix\or\upb@cv@x\or\upb@cv@xi\else\upb@cv@o\fi
  \clearpage}
\renewcommand{\maketitle}{\pagedegarde}

% Droits d'utilisation + contacts
\newcommand{\pagedroits}{%
  \clearpage\thispagestyle{upb}
  \upb@bigtitle{\upb@tdroits}\vspace{3mm}
  \upb@xdroits
  \vfill
  \begin{flushright}\small
    \textbf{\upb@lcontacts}\\[2pt]
    \ifdefempty{\upb@tel}{}{\upb@ltel{} : \upb@tel\\}%
    \ifdefempty{\upb@mail}{}{\upb@lmail{} : \upb@mail\\}%
    \ifdefempty{\upb@web}{}{\upb@lweb{} : \upb@lwwwpref\upb@web}%
  \end{flushright}
  \vspace{.1\textheight}}

% Remerciements :  \begin{remerciements} \personne{Nom, rôle} ... \end{remerciements}
\newenvironment{remerciements}{%
  \clearpage\thispagestyle{upb}
  \upb@bigtitle{\upb@tremerc}\vspace{3mm}
  \upb@xremerc\par\vspace{4mm}
  \begin{itemize}[label=\textcolor{upbviolet}{\large\textbullet},
    leftmargin=*, labelsep=1.2em, itemsep=8pt, topsep=4pt,
    parsep=0pt, partopsep=0pt]}{%
  \end{itemize}}
\newcommand{\personne}[1]{\item \strut #1}

%% =====================================================================
%%  Table des matières (\tableofcontents standard, aussi appelée \tabledesmatieres)
%% =====================================================================
\renewcommand*\l@chapter[2]{%
  \addpenalty{-\@highpenalty}\vskip 1.3em plus 1pt
  \begingroup
    \parindent\z@ \rightskip\@pnumwidth \parfillskip-\@pnumwidth
    \leavevmode\cnfont\bfseries\large
    \def\numberline##1{\upb@typechap\space ##1\hspace{.7em}\textperiodcentered\hspace{.7em}}%
    #1\nobreak\hfil\nobreak\hb@xt@\@pnumwidth{\hss #2}\par
  \endgroup
  \nobreak\vskip 1pt\hrule height .4pt\vskip .5em\nobreak}
\renewcommand*\l@section{\@dottedtocline{1}{8mm}{10mm}}
\renewcommand*\l@subsection{\@dottedtocline{2}{18mm}{12mm}}
\renewcommand*\@pnumwidth{1.4em}
\renewcommand*\@tocrmarg{2.5em}
\def\@dotsep{1.6}
\renewcommand{\tableofcontents}{%
  \if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{plain}\global\@topnum\z@
  \phantomsection\pdfbookmark[0]{\upb@ttdm}{upb-toc}%
  \markboth{\upb@ttdm}{\upb@ttdm}%
  \@makeschapterhead{\upb@ttdm}\@afterheading
  \@starttoc{toc}\clearpage}
\newcommand{\tabledesmatieres}{\tableofcontents}

%% =====================================================================
%%  Annexes : fiches de travaux pratiques (TP) et dirigés (TD)
%% =====================================================================
\newcommand{\tpcase}[1][2.75\baselineskip]{%
  \par\vspace{1mm}\noindent\hspace{6mm}\fbox{\parbox[c][#1][c]{.86\linewidth}{\strut}}\par\vspace{2mm}}
\newcommand{\tpitem}[2]{\par\vspace{2mm}\noindent\hspace{3mm}\textbf{\small #1}\par #2}

% champs d'une fiche : \fichetp[titre=...,duree=...]{1}   (champ non renseigné = case vide)
\pgfkeys{/upbfiche/.cd,
  titre/.store in=\upb@tp@titre,       objectif/.store in=\upb@tp@objectif,
  duree/.store in=\upb@tp@duree,       equipe/.store in=\upb@tp@equipe,
  individuel/.store in=\upb@tp@indiv,  materiel/.store in=\upb@tp@materiel,
  consignes/.store in=\upb@tp@consignes, restitution/.store in=\upb@tp@restit,
  role/.store in=\upb@tp@role,         evaluation/.store in=\upb@tp@eval,
  reponses/.store in=\upb@tp@reponses,
}
\newcommand{\upb@tpreset}{%
  \def\upb@tp@titre{}\def\upb@tp@objectif{}\def\upb@tp@duree{}\def\upb@tp@equipe{}%
  \def\upb@tp@indiv{}\def\upb@tp@materiel{}\def\upb@tp@consignes{}\def\upb@tp@restit{}%
  \def\upb@tp@role{}\def\upb@tp@eval{}\def\upb@tp@reponses{}}
% case : vide (hauteur fixe) ou remplie (peut se couper sur deux pages)
\newcommand{\upb@tpbox}[1]{% #1 = valeur
  \ifdefempty{#1}{\tpcase}{%
    \par\vspace{1mm}%
    \begin{list}{}{\setlength{\leftmargin}{6mm}\setlength{\rightmargin}{\dimexpr.14\linewidth-6mm\relax}%
        \setlength{\topsep}{0pt}\setlength{\parsep}{0pt}\setlength{\itemsep}{0pt}\setlength{\partopsep}{0pt}}
    \item[]
    \begin{tcolorbox}[breakable,enhanced,colback=white,colframe=black,boxrule=.4pt,arc=0pt,
        left=3pt,right=3pt,top=3pt,bottom=3pt,before skip=0pt,after skip=0pt]
      #1
    \end{tcolorbox}
    \end{list}\vspace{2mm}}}
\newcommand{\upb@fiche}[3]{% #1 = type, #2 = numéro, #3 = champs
  \upb@tpreset\pgfkeys{/upbfiche/.cd,#3}%
  \Needspace{12\baselineskip}\par\vspace{4mm}
  {\sffamily\upb@fh{13}{16}\color{upbfiche}\upb@F@fiche{} #1 N°#2\par}\vspace{2mm}
  {\bfseries A. \underline{\upb@F@enonce}}\par\vspace{2mm}
  \begingroup
  \hspace{4mm}\textbf{1. \upb@F@titre}
    \ifdefempty{\upb@tp@titre}{\rule[-.5ex]{.8\linewidth}{.4pt}}{\upb@tp@titre}\par\vspace{5mm}
  \hspace{4mm}\textbf{2. \upb@F@objectif}\upb@tpbox{\upb@tp@objectif}
  \hspace{4mm}\textbf{3. \upb@F@duree} \ifdefempty{\upb@tp@duree}{\dotfill}{\upb@tp@duree}\par\vspace{2mm}
  \hspace{4mm}\textbf{4. \upb@F@orga}\par
  \hspace{14mm}a)\ \upb@F@equipe\upb@tpbox{\upb@tp@equipe}
  \hspace{14mm}b)\ \upb@F@indiv\upb@tpbox{\upb@tp@indiv}
  \hspace{4mm}\textbf{5. \upb@F@materiel}\upb@tpbox{\upb@tp@materiel}
  \hspace{4mm}\textbf{6. \upb@F@consignes}\upb@tpbox{\upb@tp@consignes}
  \hspace{4mm}\textbf{7. \upb@F@restit}\upb@tpbox{\upb@tp@restit}
  \hspace{4mm}\textbf{8. \upb@F@role}\upb@tpbox{\upb@tp@role}
  \hspace{4mm}\textbf{9. \upb@F@eval}\upb@tpbox{\upb@tp@eval}
  \endgroup
  {\bfseries B. \underline{\upb@F@reponses}}\par
  \ifdefempty{\upb@tp@reponses}{}{\upb@tpbox{\upb@tp@reponses}}}
\newcommand{\fichetp}[2][]{\upb@fiche{\upb@F@tp}{#2}{#1}}
\newcommand{\fichetd}[2][]{\upb@fiche{\upb@F@td}{#2}{#1}}

%% =====================================================================
%%  Syllabus du cours (canevas de syllabus UPB)
%%  Renseigner chaque rubrique avec  \sylset{champ}{valeur}  puis  \syllabusupb
%%  Champs : formation grade domaine annee semestre mention specialite ue
%%   codeec intituleec masse ct tptd tpe credits effectifs enseignants contacts
%%   prerequis descriptif objectifgeneral objectifsspecifiques contenu
%%   methodes lieu materiel references evalinter evalfinale pcinter pcfinal
%%  (evalinter / evalfinale : toute valeur non vide coche la case)
%% =====================================================================
\newcommand{\sylset}[2]{\expandafter\gdef\csname syl@#1\endcsname{#2}}
\newcommand{\syl@get}[2]{%
  \ifcsname syl@#1\endcsname
    \expandafter\ifx\csname syl@#1\endcsname\@empty\textcolor{gray}{#2}%
    \else\csname syl@#1\endcsname\fi
  \else\textcolor{gray}{#2}\fi}
\newcommand{\syl@check}[1]{%
  \ifcsname syl@#1\endcsname\expandafter\ifx\csname syl@#1\endcsname\@empty$\square$\else$\boxtimes$\fi
  \else$\square$\fi}
%% -- Mise en page : modèle du canevas (fond vert, étiquettes en italique, champs dans des cadres
%%    blancs arrondis, gros filet noir). Toutes les largeurs sont des fractions de la largeur
%%    utile : \syl@w{N} = N / 160 de \linewidth (160 = largeur de texte du canevas A4).
\newcommand{\syl@w}[1]{\dimexpr\fpeval{#1/160}\linewidth\relax}
% étiquette : largeur (dimension), texte
\newcommand{\syl@lab}[2]{\parbox[c]{\dimexpr#1-\syl@w{1.25}\relax}{\raggedright\itshape #2}\hspace{\syl@w{1.25}}}
% champ encadré : largeur totale (cadre compris), contenu
\newcommand{\syl@tb}[2]{%
  \tcbox[on line,colback=white,colframe=black,boxrule=.4pt,arc=.9mm,boxsep=0pt,
         left=1.5mm,right=1.5mm,top=.7mm,bottom=.7mm]%
    {\parbox[c]{\dimexpr#1-3mm-.8pt\relax}{\raggedright\rule[-.42em]{0pt}{1.6em}#2}}}
\newcommand{\syl@cb}[2]{\syl@tb{#1}{\centering #2}}
\newcommand{\syl@sq}[1]{\syl@tb{\syl@w{6.5}}{\centering\syl@check{#1}}}
\newcommand{\syl@gap}{\par\vspace{3mm}\noindent}
% rubrique : titre, champ, texte par défaut
\newcommand{\syl@block}[3]{%
  \Needspace{5\baselineskip}\par\vspace{3mm}\noindent
  {\raggedright\itshape #1\par}\vspace{1mm}
  \begin{tcolorbox}[breakable,enhanced,colback=white,colframe=black,boxrule=.4pt,arc=.9mm,
      boxsep=1.5pt,left=2pt,right=2pt,top=1.5pt,bottom=1.5pt,before skip=0pt,after skip=0pt]
    \syl@get{#2}{#3}%
  \end{tcolorbox}}
% logo du bandeau du syllabus (rien si le champ est vide)
\newlength{\syl@lgw}\newlength{\syl@lgh}   % taille des logos, calculée hors des boîtes (\linewidth y est celui du texte)
\newcommand{\syl@logo}[1]{\ifdefempty{#1}{}{\includegraphics[height=\syl@lgh,width=\syl@lgw,keepaspectratio]{#1}}}
\newlength{\syl@half}
\newcommand{\syllabusupb}{%
  \pagecolor{upbfondsyl}%
  \begingroup
  \fontfamily{\upb@fsyl}\selectfont%
  \setlength{\parskip}{0pt}\setlength{\parindent}{0pt}\setlength{\syl@half}{\dimexpr(\linewidth-\syl@w{3.75})/2\relax}%
  \setlength{\syl@lgw}{\syl@w{21}}\setlength{\syl@lgh}{\syl@w{20}}%
  \begin{tcolorbox}[colback=upbbandeau,colframe=upbbandeau,boxrule=0pt,arc=0pt,
      left=2mm,right=2mm,top=2mm,bottom=2mm,before skip=0pt,after skip=0pt]
    \noindent\begin{minipage}[c]{\syl@w{21}}\centering\syl@logo{\upb@logouniv}\end{minipage}\hfill
    \begin{minipage}[c]{\dimexpr\linewidth-\syl@w{44.5}-4mm\relax}\centering
      {\bfseries\fontsize{13}{16}\selectfont\color{black}\upb@etab\par}\vspace{1mm}
      {\bfseries\fontsize{11}{13}\selectfont\color{black}\upb@fac\par}
    \end{minipage}\hfill
    \begin{minipage}[c]{\syl@w{21}}\centering\syl@logo{\upb@logoufr}\end{minipage}
  \end{tcolorbox}
  \par\vspace{5mm}\noindent
  % -- identification
  \syl@lab{\syl@w{34}}{\upb@L@formation}\syl@tb{\dimexpr\linewidth-\syl@w{34}\relax}{\syl@get{formation}{\upb@L@formation}}\syl@gap
  \syl@lab{\syl@w{26}}{\upb@L@grade}\syl@tb{\dimexpr\syl@half-\syl@w{26}\relax}{\syl@get{grade}{\upb@L@grade}}\hfill
  \syl@lab{\syl@w{26}}{\upb@L@domaine}\syl@tb{\dimexpr\syl@half-\syl@w{26}\relax}{\syl@get{domaine}{\upb@L@domaine}}\syl@gap
  \syl@lab{\syl@w{26}}{\upb@L@annee}\syl@tb{\dimexpr\syl@half-\syl@w{26}\relax}{\syl@get{annee}{\upb@L@annee}}\hfill
  \syl@lab{\syl@w{26}}{\upb@L@semestre}\syl@tb{\dimexpr\syl@half-\syl@w{26}\relax}{\syl@get{semestre}{?}}\syl@gap
  \syl@lab{\syl@w{26}}{\upb@L@mention}\syl@tb{\dimexpr\syl@half-\syl@w{26}\relax}{\syl@get{mention}{\upb@L@mention}}\hfill
  \syl@lab{\syl@w{26}}{\upb@L@specialite}\syl@tb{\dimexpr\syl@half-\syl@w{26}\relax}{\syl@get{specialite}{\upb@L@specialite}}\par\vspace{5mm}\noindent
  \syl@lab{\syl@w{34}}{\upb@L@ue}\syl@tb{\dimexpr\linewidth-\syl@w{34}\relax}{\syl@get{ue}{\upb@L@ue}}\syl@gap
  \syl@lab{\syl@w{26}}{\upb@L@codeec}\syl@tb{\syl@w{34}}{\syl@get{codeec}{Code}}\hfill
  \syl@lab{\syl@w{26}}{\upb@L@intituleec}\syl@tb{\dimexpr\linewidth-\syl@w{26}-\syl@w{34}-\syl@w{26}-\syl@w{4}\relax}{\syl@get{intituleec}{\upb@L@intituleec}}\par\vspace{5mm}\noindent
  % -- volumes horaires
  \syl@lab{\syl@w{22}}{\upb@L@masse}\syl@cb{\syl@w{12}}{\syl@get{masse}{?}}\hfill
  \syl@lab{\syl@w{8}}{\upb@L@ct}\syl@cb{\syl@w{12}}{\syl@get{ct}{?}}\hfill
  \syl@lab{\syl@w{13}}{\upb@L@tptd}\syl@cb{\syl@w{12}}{\syl@get{tptd}{?}}\hfill
  \syl@lab{\syl@w{9}}{\upb@L@tpe}\syl@cb{\syl@w{12}}{\syl@get{tpe}{?}}\hfill
  \syl@lab{\syl@w{24}}{\upb@L@credits}\syl@cb{\syl@w{12}}{\syl@get{credits}{?}}\syl@gap
  \syl@lab{\syl@w{34}}{\upb@L@effectifs}\syl@cb{\syl@w{18}}{\syl@get{effectifs}{?}}\par\vspace{5mm}\noindent
  % -- enseignants et contacts
  \parbox[t]{\syl@half}{\syl@lab{\syl@half}{\upb@L@enseignants}\par\vspace{1mm}\syl@tb{\syl@half}{\syl@get{enseignants}{\upb@L@enseignants}}}\hfill
  \parbox[t]{\syl@half}{\syl@lab{\syl@half}{\upb@L@contacts}\par\vspace{1mm}\syl@tb{\syl@half}{\syl@get{contacts}{\upb@L@contacts}}}
  \par\vspace{4mm}\noindent\rule{\linewidth}{1mm}\par
  % -- rubriques
  \syl@block{\upb@L@prerequis}{prerequis}{\upb@L@prerequis}
  \syl@block{\upb@L@descriptif}{descriptif}{\upb@L@descriptif}
  \syl@block{\upb@L@objgen}{objectifgeneral}{\upb@L@objgen}
  \syl@block{\upb@L@objspe}{objectifsspecifiques}{\upb@L@objspe}
  \syl@block{\upb@L@contenu}{contenu}{\upb@L@contenu}
  \syl@block{\upb@L@methodes}{methodes}{\upb@L@methodes}
  \syl@block{\upb@L@lieu}{lieu}{\upb@L@lieu}
  \syl@block{\upb@L@materiel}{materiel}{\upb@L@materiel}
  \syl@block{\upb@L@refs}{references}{\upb@L@refs}
  % -- évaluation
  \Needspace{8\baselineskip}\par\vspace{5mm}\noindent
  \syl@lab{\syl@w{30}}{\upb@L@modalites}\syl@sq{evalinter}\hspace{2mm}\syl@lab{\syl@w{42}}{\upb@L@evint}\hfill
  \syl@sq{evalfinale}\hspace{2mm}\syl@lab{\syl@w{32}}{\upb@L@evfin}\syl@gap
  \syl@lab{\syl@w{40}}{\upb@L@pcint}\syl@cb{\syl@w{18}}{\syl@get{pcinter}{?}}\hfill
  \syl@lab{\syl@w{34}}{\upb@L@pcfin}\syl@cb{\syl@w{18}}{\syl@get{pcfinal}{?}}\par
  \endgroup
  \clearpage\nopagecolor}

%% =====================================================================
%%  Mathématiques : notations, théorèmes, définitions, exemples, preuves
%% =====================================================================
\providecommand{\R}{\mathbb{R}}\providecommand{\N}{\mathbb{N}}
\providecommand{\Z}{\mathbb{Z}}\providecommand{\Q}{\mathbb{Q}}
\providecommand{\C}{\mathbb{C}}
\DeclarePairedDelimiter{\abs}{\lvert}{\rvert}
\DeclarePairedDelimiter{\norm}{\lVert}{\rVert}

% compteur commun à tous les énoncés, remis à zéro à chaque chapitre : « Théorème 2.3 »
\newcounter{upbthm}[chapter]
\renewcommand{\theupbthm}{\thechapter.\arabic{upbthm}}
% \upb@newthm{environnement}{nom}{couleur}{police du texte}
\newcommand{\upb@newthm}[4]{%
  \newtcolorbox[use counter*=upbthm]{#1}[1][]{%
    enhanced,breakable,sharp corners,frame hidden,colback=#3!5,
    left=2mm,right=2mm,top=1.5mm,bottom=1.5mm,
    before skip=.8\baselineskip plus 2pt,after skip=.8\baselineskip plus 2pt,
    fontupper=#4,
    before upper={\protected@edef\@currentlabel{\thetcbcounter}\noindent{\cnfont\bfseries\color{#3}#2~\thetcbcounter\ifstrempty{##1}{}{\ (##1)}.}\ \ignorespaces}}}
% énoncé non numéroté
\newcommand{\upb@newunnum}[4]{%
  \newtcolorbox{#1}[1][]{%
    enhanced,breakable,sharp corners,frame hidden,colback=#3!5,
    left=2mm,right=2mm,top=1.5mm,bottom=1.5mm,
    before skip=.8\baselineskip plus 2pt,after skip=.8\baselineskip plus 2pt,
    fontupper=#4,
    before upper={\noindent{\cnfont\bfseries\color{#3}#2\ifstrempty{##1}{}{\ (##1)}.}\ \ignorespaces}}}
\upb@newthm{theoreme}{\upb@nthm}{upbtheo}{\itshape}
\upb@newthm{proposition}{\upb@nprop}{upbtheo}{\itshape}
\upb@newthm{lemme}{\upb@nlem}{upbtheo}{\itshape}
\upb@newthm{corollaire}{\upb@ncor}{upbtheo}{\itshape}
\upb@newthm{definition}{\upb@ndef}{upbdefn}{\upshape}
\upb@newthm{exemple}{\upb@nex}{upbexem}{\upshape}
\upb@newthm{exercice}{\upb@nexo}{upbexem}{\upshape}
\upb@newunnum{remarque}{\upb@nrem}{upbrem}{\upshape}
\renewcommand{\qedsymbol}{\rule{.55em}{.55em}}
\newenvironment{preuve}[1][\upb@nproof]{\begin{proof}[#1]}{\end{proof}}

%% =====================================================================
%%  Légendes, code
%% =====================================================================
\captionsetup{font=small,labelfont={bf,color=upbnavy},labelsep=period,
  justification=raggedright,singlelinecheck=false,skip=6pt}
\lstset{basicstyle=\ttfamily\small,columns=fullflexible,keepspaces=true,breaklines=true,
  frame=l,framerule=1.6pt,rulecolor=\color{upbviolet},xleftmargin=4mm,framexleftmargin=3mm,
  backgroundcolor=\color{upbbandeau},commentstyle=\itshape\color{black!60},
  keywordstyle=\bfseries\color{upbnavy},showstringspaces=false,aboveskip=.8\baselineskip,
  belowskip=.8\baselineskip}

\endinput
