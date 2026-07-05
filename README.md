# Flapy Quest

Flapy Quest is a Flutter and Flame Android arcade game inspired by Flappy Bird. The game includes country selection, flag rendering on the bird, progressive difficulty, local high score persistence, audio, day/night mode, unlockable skins, and Android release preparation.

## Tech Stack

- Flutter 3.x
- Dart 3.x
- Flame
- Flame Audio
- SharedPreferences
- GitHub Actions for Android CI

## Getting Started

```powershell
flutter pub get
flutter analyze
flutter test
flutter run
```

Run on a specific emulator:

```powershell
flutter devices
flutter run -d emulator-5554
```

## Android Builds

Debug APK:

```powershell
flutter build apk --debug
```

Release APK:

```powershell
flutter build apk --release
```

Google Play App Bundle:

```powershell
flutter build appbundle --release --obfuscate --split-debug-info=build/debug-info
```

Release artifact:

```text
build/app/outputs/bundle/release/app-release.aab
```

Keep `build/debug-info` for crash symbolication when using obfuscation.

## Git Workflow

Protected branches:

- `main`: stable production branch.
- `develop`: integration branch.

Short-lived branches:

- `feature/<scope>-<description>`
- `fix/<scope>-<description>`
- `hotfix/<scope>-<description>`
- `release/<version>`

All development must start from `develop` and merge back through a Pull Request.

## Commit Convention

This project follows Conventional Commits:

```text
feat(country): add country selection
feat(bird): add flag skin rendering
fix(game): resolve collision bug
security(storage): protect local score data
```

Allowed types:

- `feat`
- `fix`
- `refactor`
- `docs`
- `test`
- `chore`
- `perf`
- `security`

## Project Structure

```text
lib/
  game/           Flame game loop and components
  models/         Country and flag domain models
  services/       Storage and audio services
  widgets/        Flutter overlays and UI
assets/
  audio/          Local audio assets
android/          Android platform project
test/             Automated tests
```

## Release Process

1. Create a release branch from `develop`.
2. Update `version` in `pubspec.yaml`.
3. Update `CHANGELOG.md`.
4. Run analyze, tests, and release build.
5. Merge `release/*` into `main`.
6. Tag the release, for example `v1.0.0`.
7. Merge `main` back into `develop`.

See [docs/GIT_WORKFLOW.md](docs/GIT_WORKFLOW.md) for the full workflow.
