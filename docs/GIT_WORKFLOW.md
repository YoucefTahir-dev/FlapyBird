# Git Workflow

## Branches

### `main`

Production branch. It must always represent a stable, releasable state.

Rules:

- No direct commits.
- Merge only from `release/*` or `hotfix/*`.
- Require Pull Request review.
- Require CI checks to pass.

### `develop`

Integration branch for active development.

Rules:

- Feature and fix branches merge here first.
- CI must pass before merge.
- Release branches start from here.

### `feature/*`

Used for new functionality.

Pattern:

```text
feature/<scope>-<description>
```

Examples:

```text
feature/country-selection
feature/bird-flag-rendering
```

### `fix/*`

Used for regular bug fixes.

Pattern:

```text
fix/<scope>-<description>
```

### `hotfix/*`

Used for urgent production fixes. Branch from `main`, merge back into `main`, then backport to `develop`.

Pattern:

```text
hotfix/<scope>-<description>
```

### `release/*`

Used to prepare a release.

Pattern:

```text
release/v<major>.<minor>.<patch>
```

Example:

```text
release/v1.1.0
```

## Standard Commands

Initialize:

```powershell
git init -b main
git add .
git commit -m "chore(repo): initial professional project setup"
git switch -c develop
git push -u origin main
git push -u origin develop
```

Start a feature:

```powershell
git switch develop
git pull origin develop
git switch -c feature/country-selection
```

Finish a feature:

```powershell
git add .
git commit -m "feat(country): add country selection"
git push -u origin feature/country-selection
```

Release:

```powershell
git switch develop
git pull origin develop
git switch -c release/v1.0.0
flutter analyze
flutter test
flutter build appbundle --release --obfuscate --split-debug-info=build/debug-info
git tag -a v1.0.0 -m "Release v1.0.0"
```

## Branch Protection In GitHub

Configure these in GitHub repository settings:

For `main`:

- Require a pull request before merging.
- Require approvals.
- Require status checks to pass.
- Require branches to be up to date before merging.
- Restrict who can push.
- Include administrators if this is a serious production repo.

For `develop`:

- Require a pull request before merging.
- Require CI checks.
- Require conversation resolution.
