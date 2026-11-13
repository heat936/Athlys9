# Athlys9 — compilation Android

Ce dépôt héberge uniquement le workflow public de compilation. Le code source Athlys reste dans le dépôt privé `heat936/Athlys2`.

## Configuration requise

Dans **Settings → Secrets and variables → Actions → New repository secret**, créer :

- **Name** : `ATHLYS_READ_TOKEN`
- **Secret** : un Personal Access Token fine-grained appartenant à `heat936`, limité au dépôt privé `heat936/Athlys2`, avec la permission **Contents: Read-only**.

Ne jamais placer le token dans un fichier, un commit ou les logs.

## Lancer une compilation vérifiable

Le lancement est manuel : **Actions → Build Athlys Mobile Android APK → Run workflow**. Une modification de ce relais ne déclenche pas de compilation.

Renseigner :

- `source_sha` : le SHA complet, sur 40 caractères hexadécimaux minuscules, du commit privé à compiler. La valeur par défaut désigne un candidat fondé sur la version Android existante ; elle ne garantit pas que ce candidat possède les preuves scientifiques requises. Un contrôle refusé ne produit aucun nouvel APK.
- `scientific_manifest` : le chemin relatif du manifeste conservé dans ce même checkout privé, par défaut `scientific-model-manifest.json`.

Le relais vérifie le commit réellement extrait puis lance, avant toute génération d'assets :

```sh
PYTHONPATH=ml python -m athlys_intelligence.scientific_validation \
  --manifest "$ATHLYS_SCIENTIFIC_MANIFEST" \
  --source-sha "$ATHLYS_SOURCE_SHA" \
  --platform android
```

Le module et les preuves restent dans le dépôt privé. Une commande absente, un manifeste absent, une preuve incomplète ou un contrôle refusé bloque la construction et l'export de l'APK. Le contrôle est répété avant l'empaquetage Android pour détecter une modification des artefacts enregistrés pendant la génération des assets. Aucun paramètre ne permet de contourner ce contrôle. Les registres doivent couvrir tous les modèles attendus ; une liste vide ne constitue pas une validation.

Le SHA du checkout permet d'auditer la version exécutée. Le manifeste conserve séparément la révision évaluée et les empreintes des artefacts et preuves. Le contrôle vérifie l'éligibilité des preuves selon son contrat ; il ne confère aucune validation médicale et ne qualifie pas automatiquement un modèle de « scientifiquement validé ».

## Sorties et confidentialité

L'APK destiné aux utilisateurs est l'unique artefact exporté, sous le nom `athlys9-android-apk`, pendant 30 jours. Les modèles candidats, jeux de données, sources serveur, rapports et journaux privés ne doivent pas être inclus dans les assets de l'application ni dans les artefacts publics.

Les contrôles et commandes de construction privés n'affichent qu'un résultat générique dans les logs publics. Leurs sorties détaillées sont temporaires et supprimées. Le rapport du contrôle n'est pas exporté. Les jetons de checkout ne sont pas conservés dans la configuration Git, et le checkout privé est supprimé en fin de job.

Ce dépôt ne contient que le relais générique. Aucun code source privé, modèle, donnée d'athlète, rapport scientifique privé ou secret ne doit y être copié. Pour diagnostiquer un échec détaillé, exécuter les contrôles dans l'environnement privé autorisé.
