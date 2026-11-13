# Athlys9 — compilation Android

Ce dépôt héberge uniquement le workflow public de compilation. Le code source Athlys reste dans le dépôt privé `heat936/Athlys2`.

## Configuration requise

Dans **Settings → Secrets and variables → Actions → New repository secret**, créer :

- **Name** : `ATHLYS_READ_TOKEN`
- **Secret** : un Personal Access Token fine-grained appartenant à `heat936`, limité au dépôt privé `heat936/Athlys2`, avec la permission **Contents: Read-only**.

Ne jamais placer le token dans un fichier, un commit ou les logs.

## Lancer la compilation

Après avoir configuré le secret : **Actions → Build Athlys Mobile Android APK → Run workflow**.

L'APK sera disponible dans les artefacts du run sous le nom `athlys9-android-apk` pendant 30 jours. Le workflow compile la branche `feat/athlys-interface-refresh-v2` du dépôt privé Athlys2.

Aucun code source privé ni identifiant n'est publié dans ce dépôt.
