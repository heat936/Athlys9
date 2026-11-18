# Athlys9 — builds et validation Athlys

Ce dépôt **public** héberge des workflows GitHub Actions pour les builds et les tests d'Athlys. Le code applicatif reste dans le dépôt **privé** `heat936/Athlys2`. Ne jamais copier de code privé, de secrets, de données de santé ou de comptes réels dans les artefacts publics.

## Référence active : interfaces officielles V4.3.1 (18 novembre 2026)

Les deux workflows V4 actuellement validés récupèrent la branche source privée `redesign/charter-only-v4-20261118` avec un secret GitHub Actions `ATHLYS_READ_TOKEN` en lecture seule.

| Objet | Workflow | Dernière exécution V4.3.1 validée |
| --- | --- | --- |
| APK Android **debug** + SHA-256 | [Athlys V4 official-charter UI — Android and QA](.github/workflows/athlys-charter-v4.yml) | [Run #44412998077](https://github.com/heat936/Athlys9/actions/runs/44412998077) |
| Tests navigateur + captures | [Athlys V4 — actual browser UI acceptance](.github/workflows/athlys-charter-v4-browser.yml) | [Run #44412033734](https://github.com/heat936/Athlys9/actions/runs/44412033734) |

Ces runs sont marqués **success** par GitHub Actions. Les artefacts, conservés **30 jours** conformément aux workflows, se récupèrent dans la section *Artifacts* des runs (connexion GitHub éventuellement nécessaire). Le nom de l'artefact APK est `athlys-charter-only-v4-android-debug` ; il contient `app-debug.apk`, `athlys-charter-v4.sha256`, `athlys-build-provenance.json` et `athlys-build-provenance.sha256`. Le build du run #44412998077 est issu du commit privé `447d8eca3de360502c2ab47b710a32276d11d84e`. Le pipeline navigateur a ensuite été étendu pour archiver `test-evidence/browser-provenance.json` : comparer les deux valeurs `source_commit` avant de considérer les captures comme la preuve du même build.

**Attention :** `app-debug.apk` n'est **ni signé pour la production, ni validé sur téléphone physique, ni une publication officielle**. La réussite des tests avec des identités ou services simulés ne prouve pas l'application des politiques RLS Supabase avec de vrais comptes.

## Vérifications obligatoires avant publication

1. Télécharger l'artefact APK et comparer le SHA-256 de `app-debug.apk` avec le fichier `athlys-charter-v4.sha256` associé au même run. Vérifier également le SHA-256 du manifeste de provenance et l'égalité du commit source dans les résultats navigateur et Android.
2. Installer sur un **appareil Android physique** compatible, puis vérifier les écrans Coach, Athlète et Club, les contrastes et la navigation tactile, ainsi que le comportement des zones sûres et le mode sombre.
3. Avec des **comptes de test dédiés et des données fictives**, valider connexion, déconnexion, réouverture de l'application, changement de rôle et absence de fuite de données entre deux comptes.
4. Sur une infrastructure Supabase de test correctement isolée, vérifier l'application des politiques **RLS côté serveur** pour les conversations, équipes et dossiers Coach/Athlète, y compris les accès refusés et les réponses réseau retardées.
5. Vérifier les accès Health Connect, l'absence de données ou de secrets sensibles dans les journaux, les régressions et la signature release avant toute distribution en production.

En cas d'échec d'un seul contrôle de sécurité ou d'isolation des données, **ne pas publier** : corriger le problème, relancer les tests, et produire une nouvelle version vérifiée.

## Sécurité des workflows

Configurer `ATHLYS_READ_TOKEN` dans **Settings → Secrets and variables → Actions** du dépôt public. Il doit être limité au dépôt privé `heat936/Athlys2`, permission **Contents: Read-only**, sans droits d'écriture. Ne jamais placer le token dans un commit, un artefact ou des logs.

Les workflows V4 référencent une **branche mobile** du dépôt privé ; leurs résultats ne sont pas automatiquement reproductibles si cette branche évolue. Pour chaque candidate de release, conserver le SHA exact du commit source privé et celui du workflow public, puis reconstruire depuis ces références figées. Le simple numéro de version ne constitue pas une preuve de provenance.

## Workflows historiques

D'autres workflows Android et Windows demeurent présents pour compatibilité et travaux antérieurs. Ne pas confondre leurs artefacts avec la candidate **V4.3.1**. Pour celle-ci, utiliser exclusivement les deux workflows V4 référencés ci-dessus.
