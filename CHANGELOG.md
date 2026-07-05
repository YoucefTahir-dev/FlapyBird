# Changelog

All notable changes to this project will be documented in this file.

This project follows Semantic Versioning: `MAJOR.MINOR.PATCH`.

## [1.0.0] - 2026-07-05

### Added

- Initial Flutter and Flame Android game.
- Bird tap controls with gravity and collision.
- Procedural obstacles, progressive score, and increasing difficulty.
- Main menu, HUD, Game Over, and Restart overlays.
- Local high score storage with integrity signature.
- Audio effects and background music.
- Day/night mode.
- Unlockable bird skins.
- Country selection with searchable list.
- Visible flag motif rendered directly on the bird.
- GitHub Actions Android CI workflow.
- Professional repository documentation and Git workflow.
- Production test report, release checklist, Google Play guide, and privacy policy draft.
- Smooth score-based difficulty configuration in `lib/game/difficulty_config.dart`.
- Full ISO country selection powered by `country_picker`.
- Official Unicode flag rendering on the bird and in the country selector.

### Fixed

- Moved Android `MainActivity` into the production package `com.flapyquest.game`.
- Removed debug signing fallback from release builds.

### Changed

- Replaced the manually maintained 9-country list with a package-backed country list.
- Simplified flag rendering to reduce per-row painting work in the selector.
