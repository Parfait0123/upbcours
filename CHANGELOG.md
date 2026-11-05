# Historique des versions

## 3.1 (2026-11-05)
- Passage à **pdfLaTeX** : la classe ne dépend plus de fontspec, unicode-math ni polyglossia (remplacés par inputenc, fontenc T1, babel et polices Type 1).
- Les polices se règlent par nom de famille LaTeX (`phv`, `ppl`…) ; `policemaths` accepte `lm`, `palatino`, `times`, `aucune`.
- Police Carlito si le paquet est installé, sinon Helvetica.
- Bagel Fat One (numéros de chapitre) conservée : convertie en Type 1 dans `fonts/`.
- Puces des listes conservées malgré babel-french.
- Nettoyage : PDF précompilés, exemple littéraire en double et copie des logos du syllabus supprimés.
- Nouveau README, licence MIT, intégration continue GitHub.

## 3.0
- Mise en forme entièrement réglable par `\upbsetup{clé=valeur}`, version XeLaTeX.
