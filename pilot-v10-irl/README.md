# Athlys V10 — essai IRL fermé (données fictives uniquement)
**Date : 23 novembre 2026.** Cette version est un laboratoire technique et ergonomique, **pas une publication officielle**.

## Accès
- **Web ordinateur** : https://athlys-v10-irl-staging.vercel.app/app.html
- **Web mobile** : https://athlys-v10-irl-staging.vercel.app/mobile.html
- **Android** : [Télécharger l’APK de recette](https://github.com/heat936/Athlys9/releases/download/athlys-v10-irl-staging-qa-20261123/Athlys-V10-IRL-Staging.apk) et [sa somme SHA-256](https://github.com/heat936/Athlys9/releases/download/athlys-v10-irl-staging-qa-20261123/SHA256SUMS.txt), préversion `athlys-v10-irl-staging-qa-20261123`, package isolé `com.athlys.v10irlqa` (APK debug signé pour recette, installé à côté de V9/V10 Studio). Télécharger uniquement l'asset identifié dans la release et contrôler sa somme SHA-256.
- **Services backend** : Supabase *Athlys2 staging*. Aucun basculement du projet principal Athlys n'a été effectué.

## Public et limites
Les premières séances d'essai sont réservées à des volontaires majeurs et informés, pour vérifier le démarrage, les écrans, les rôles et le dialogue coach/athlète en utilisant **uniquement des valeurs inventées**. Ne pas transmettre de vrais renseignements médicaux, sommeil, douleurs, cycle, fréquence cardiaque, vidéos de sportifs, données de mineurs, ni de données réelles d'entraînement. Ne connecter aucun fournisseur santé pendant cette phase.

Ne jamais poster dans une issue GitHub d'email réel, mot de passe, jeton/JWT, capture d'écran non expurgée, données de santé ou coordonnées.

## Parcours test (dans cet ordre)
1. Installer l'APK Android test, vérifier Trajectoire et l'écran de connexion. Sur PC, ouvrir le Web de recette et contrôler la même interface Athlys.
2. Créer un compte **coach** de test et un compte **athlète** de test avec les vrais emails des volontaires mais des données fictives d'entraînement. Le prénom et le nom du titulaire sont requis dans le formulaire ; la boîte mail de confirmation doit être accessible au volontaire.
3. Note : le fournisseur d'email Supabase intégré est limité à 2 emails/heure pour l'ensemble du projet. Ne pas répéter l'inscription si un HTTP 429 apparaît. Réessayer après la fenêtre normale de service ou utiliser des comptes de test déjà autorisés ; ne pas désactiver les vérifications email.
4. Coach : communiquer un code d'association au compte athlète de test ; contrôler côté athlète que la relation est visible.
5. Programmer une séance fictive (ex. : 5 × 100 m avec récupération indiquée) et la consulter sur l'autre appareil.
6. Athlète : enregistrer un RPE **fictif** ; le coach marque une supervision, la confirme, et effectue un bilan Dual Perception **fictif**.
7. Vérifier qu'un troisième compte sans relation ne voit pas les bilans et que le parcours Web ↔ Android se synchronise ; ne pas réutiliser de vrais comptes de production.
8. Tester le mode avion et le retour réseau, sans supposer qu'une modification hors ligne est sauvegardée tant qu'une confirmation n'apparaît pas.
9. Vérifier déconnexion, reconnexion, messages d'erreur, contrastes et accessibilité.

## STOP immédiat
Arrêter l'essai et signaler par canal privé si un compte peut consulter un autre groupe, si une donnée de santé apparaît sans consentement, si une erreur de synchronisation efface des données, ou si l'application boucle sur l'authentification. Pas de déploiement général avant tests **JWT réels** (coach, athlète, tiers) et RLS négatifs.

## Signaler une anomalie
Utiliser le [modèle de ticket Athlys V10 IRL](https://github.com/heat936/Athlys9/issues/new?template=athlys-v10-irl-bug.md) uniquement pour des problèmes non sensibles. Tout incident de confidentialité doit être remonté par un canal privé.

## Compte-rendu minimal
Pour chaque parcours : appareil et version Android/OS, date, fonctionnalité, attendu/observé, résultat PASS/FAIL, étapes reproduisant l'erreur, **sans information personnelle**.

## Preuves techniques
- Compilation APK staging : https://github.com/heat936/Athlys9/actions/runs/45257657841
- Tests démarrage Android 14 : https://github.com/heat936/Athlys9/actions/runs/45258372184
- Tests HTTPS Web staging : https://github.com/heat936/Athlys9/actions/runs/45258271257
- Tests navigateur : https://github.com/heat936/Athlys9/actions/runs/45258466209
- Vérification prérequis JWT : https://github.com/heat936/Athlys9/actions/runs/45256766546 — **bloqué** par deux secrets de staging absents ; ne pas confondre avec un test JWT réussi.

Le site de staging utilise `robots.txt` Disallow et `X-Robots-Tag: noindex` ; cela empêche l'indexation normale mais **ne restreint pas l'accès par URL**.

**La recette avec données personnelles sensibles ou un déploiement grand public ne sont pas autorisés à ce stade.**

## Test d'authentification réelle : prérequis administrateur
Le pipeline [GoTrue JWT + RLS du pilote](https://github.com/heat936/Athlys9/actions/workflows/athlys-v10-irl-real-jwt-qa.yml) est prêt et a passé syntaxe/tests unitaires sur la source épinglée, mais son [premier run](https://github.com/heat936/Athlys9/actions/runs/45261031897) s'arrête sur **un secret de staging manquant**.

Pour activer ce test automatisé, le responsable technique doit configurer dans les **GitHub Actions Secrets** de ce dépôt `ATHLYS_QA_SERVICE_ROLE_KEY`, en utilisant exclusivement la clé du projet Supabase **Athlys2 staging**. La clé n'est jamais destinée au navigateur, au dépôt ou à cette conversation. Le domaine d'adresses synthétiques `athlys.test` est déjà intégré : aucun autre secret n'est demandé pour ce workflow.

**Le GO Auth/RLS réel n'est pas obtenu tant que ce workflow n'a pas terminé avec succès.** Le PASS d'ouverture de session d'un navigateur ne remplace pas un JWT de test ni un contrôle de synchronisation sur deux appareils.

## Contrôles d'authentification complémentaires (23 novembre 2026)
- [Test réel HTTP Auth + RLS anonyme](https://github.com/heat936/Athlys9/actions/runs/45263105550) : **PASS**. Auth santé HTTP 200 ; mot de passe erroné rejeté HTTP 400 ; les tables `profiles`, `coach_athletes` et `athlys_dual_perception` refusent l'accès sans session HTTP 401.
- [Test JWT coach/athlète/tiers](https://github.com/heat936/Athlys9/actions/runs/45263331278) : **BLOCKED** à l'étape d'administration Supabase staging faute de secret `ATHLYS_QA_SERVICE_ROLE_KEY`. La compilation, le pin de source et les tests unitaires ont réussi.
- Le workflow JWT a été durci : le secret est seulement transmis à l'étape de provisioning contrôlé, jamais à `npm install` ni à `npm test` ; ces étapes n'exécutent pas avec des droits d'administration.
- Le connecteur Supabase accessible ici fournit les clés publiques mais **pas** la clé secrète de service ; le connecteur GitHub n'expose pas d'action pour créer les secrets Actions. Ce garde-fou doit être franchi dans l'interface GitHub autorisée par un administrateur.
- **Action administrateur unique :** ouvrir [secrets Actions de Athlys9](https://github.com/heat936/Athlys9/settings/secrets/actions) et créer la valeur chiffrée `ATHLYS_QA_SERVICE_ROLE_KEY` depuis le projet **Athlys2 staging uniquement**. Ne pas coller cette valeur dans un ticket, un chat, un commit ou une URL. Puis [lancer la validation Auth réelle](https://github.com/heat936/Athlys9/actions/workflows/athlys-v10-irl-real-jwt-qa.yml). Ne pas considérer un test anonyme PASS comme un JWT confirmé.

## Module Excel Intelligence — préversion V10 (23 novembre 2026)
- **Web de recette uniquement :** [Athlys Séances & programmes](https://athlys-v10-irl-staging.vercel.app/app.html). Connecte-toi avec un compte de recette valide ; le module est accessible dans l'espace coach et athlète, avec reconnaissance locale de fichiers `.xlsx` et `.csv`.
- **Méthode :** choisir le fichier, lire l'aperçu, corriger les champs, préciser si la séance a réellement été faite, vérifier l'athlète destinataire (coach), puis importer les lignes dans le journal.
- **Données :** ne jamais verser de vrais dossiers médicaux, fichiers nominatifs d'équipes, informations de mineurs ou données de santé sensibles pendant cette phase de QA.
- **Modèle :** les séances validées alimentent le journal personnel et ses statistiques de charge ; la contribution au dataset commun exige un consentement séparé de l'athlète. Le serveur stocke seulement des candidats numériques minimisés dans un schéma privé, avec révocation purgant la file non entraînée. **Aucun entraînement global ML automatique.**
- **Tests :** [unitaires et build](https://github.com/heat936/Athlys9/actions/runs/45268171513) PASS ; [véritable lecture XLSX sur Chromium mobile/ordinateur](https://github.com/heat936/Athlys9/actions/runs/45266896401) PASS ; [publication HTTP Web staging](https://github.com/heat936/Athlys9/actions/runs/45268306983) PASS.
- **Android Excel :** construction de l'APK de test en cours via [runner public](https://github.com/heat936/Athlys9/actions/workflows/athlys-v10-excel-android-qa.yml). L'APK de recette sans Excel reste disponible tant que le nouvel asset n'est pas vérifié.
- **Revue de code :** [PR privée Athlys2 #141](https://github.com/heat936/Athlys2/pull/141), maintenue en brouillon et non fusionnée sur main.
- **Gate restant :** tests officiels JWT réels coach / athlète / outsider + synchronisation Android↔Web. Le secret staging absent empêche leur exécution ; ce statut ne doit pas être confondu avec un échec des tests unitaires ou une validation de production.

## Édition actuelle : V10 Excel — RPE prévu/ressenti apparié (23 novembre 2026)
- **Télécharger l'APK Android de recette courant** : https://github.com/heat936/Athlys9/releases/download/athlys-v10-excel-paired-rpe-qa-20261123/Athlys-V10-Excel-IRL.apk
- **Empreinte SHA-256 publiée** : https://github.com/heat936/Athlys9/releases/download/athlys-v10-excel-paired-rpe-qa-20261123/SHA256SUMS.txt
- **Version Web de recette** : https://athlys-v10-irl-staging.vercel.app/app.html (projet Supabase2 staging uniquement). Le déploiement correspond à la source privée `e710c7ee15c4927949dd4070461f54a9ce21c13b` pour le module Excel.
- **Important pour Android** : cet APK conserve l'identifiant de recette `com.athlys.v10irlqa` mais est signé avec une nouvelle clé éphémère. Il **n'est pas installable par-dessus l'ancienne APK de recette** ; il faut désinstaller exclusivement cet ancien package QA, pas la V9 ni la version Athlys principale. Ce n'est pas une signature de production.
- **Lecture intelligente** : import local XLSX/CSV, 8 Mo/12 feuilles/200 séances max ; dates, discipline, durée, RPE prévu et ressenti, fréquence cardiaque, volume ; aperçu corrigible et paginé par lots de 30 ; confirmation explicite de séance réalisée et filtrage des doublons.
- **Individualisation réelle, mais prudente** : les séances réalisées comportant un RPE prévu **et** ressenti permettent au moteur Athlys local de calculer une correction exploratoire quand il dispose d'au moins quatre séances comparables ; aucune inférence de prévention de blessure. Un historique sans RPE prévu reste utile pour les statistiques de charge, mais ne constitue pas une paire d'apprentissage.
- **Dataset commun** : contribution **optionnelle de l'athlète seulement**, jamais présumée par un coach. Les exemples restent privés, pseudonymisés (donc encore des données personnelles), sans fichier ni notes libres, sous état `pending_review`. Les colonnes `planned_rpe` et `rpe_delta` ont été ajoutées en base staging et leur mise à jour et suppression après retrait du consentement ont été vérifiées. Aucun réentraînement général automatique de modèle.
- **Preuves** : [tests unitaires/build Web](https://github.com/heat936/Athlys9/actions/runs/45272335052) PASS ; [contrôles du site publié](https://github.com/heat936/Athlys9/actions/runs/45272553883) PASS ; [assemblage/signature APK actuelle](https://github.com/heat936/Athlys9/actions/runs/45272626037) PASS ; [émulateur APK précédent](https://github.com/heat936/Athlys9/actions/runs/45270694850) PASS. [Émulateur APK courant](https://github.com/heat936/Athlys9/actions/runs/45272856643) et [recette navigateur 65 séances](https://github.com/heat936/Athlys9/actions/runs/45272345736) : ne déclarer PASS qu'après conclusion du workflow.
- **Source et historique** : [PR #141 dans Athlys2](https://github.com/heat936/Athlys2/pull/141), brouillon ; ne pas fusionner hors recette.
- **Blocage réglementaire et technique persistant** : manque du secret staging `ATHLYS_QA_SERVICE_ROLE_KEY` pour les trois vrais JWT (coach/athlète/tiers). L'isolement RLS a été vérifié partiellement par rôles simulés et SQL transactionnel, **pas** par ces sessions officielles ; la synchronisation réelle Android↔Web et l'usage de données sensibles restent NO-GO.
