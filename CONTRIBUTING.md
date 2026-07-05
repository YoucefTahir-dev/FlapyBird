# Contributing

## Branching Rules

Never commit directly to `main`.

Use these branch types:

- `feature/<scope>-<description>` for new features.
- `fix/<scope>-<description>` for bug fixes.
- `hotfix/<scope>-<description>` for urgent production fixes.
- `release/<version>` for release preparation.

Examples:

```text
feature/country-selection
feature/bird-flag-skin
fix/game-collision
hotfix/release-signing
release/v1.1.0
```

## Pull Request Flow

1. Branch from `develop`.
2. Keep the change focused.
3. Run local checks before opening a PR.
4. Open a PR into `develop`.
5. Merge to `main` only from a release or hotfix PR after validation.

## Local Checks

```powershell
flutter pub get
flutter analyze
flutter test
flutter build apk --release
```

## Conventional Commits

Use this format:

```text
type(scope): short description
```

Allowed types:

- `feat`: new feature
- `fix`: bug fix
- `refactor`: structural improvement
- `docs`: documentation
- `test`: tests
- `chore`: maintenance
- `perf`: performance optimization
- `security`: security fix

Examples:

```text
feat(country): add country selection
feat(bird): add flag skin rendering
fix(game): resolve collision bug
security(storage): protect local score data
```

## Release Checklist

- `pubspec.yaml` version updated.
- `CHANGELOG.md` updated.
- `flutter analyze` passes.
- `flutter test` passes.
- Android release build passes.
- Release tag created.
