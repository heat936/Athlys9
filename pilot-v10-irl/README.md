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
