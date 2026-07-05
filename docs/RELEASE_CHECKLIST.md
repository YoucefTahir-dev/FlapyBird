# Release Checklist

## Build Status

- [x] Flutter doctor passes.
- [x] Dependencies resolved.
- [x] Static analysis passes.
- [x] Unit tests pass.
- [x] Coverage generated.
- [x] Debug APK builds.
- [x] Release APK builds.
- [x] Release AAB builds.
- [x] APK signature verified.

## Android Configuration

- [x] Application ID: `com.flapyquest.game`
- [x] App name: `Flapy Quest`
- [x] MainActivity package: `com.flapyquest.game`
- [x] Release signing configured through `android/key.properties`
- [x] Release minification enabled.
- [x] Resource shrinking enabled.
- [x] Dart obfuscation enabled for release commands.
- [x] Portrait orientation enforced in Flutter.
- [x] No release INTERNET permission declared in main manifest.
- [x] Release APK installs on emulator.
- [x] Release app launches with package `com.flapyquest.game`.
- [x] APK signature verified with `apksigner`.

## Versioning

- [x] Current version: `1.0.0+1`
- [x] Git tag exists: `v1.0.0`
- [x] Changelog exists.

For every update:

1. Increment `version` in `pubspec.yaml`.
2. Update `CHANGELOG.md`.
3. Create a tag such as `v1.0.1`.

## Google Play Store Assets

- [ ] Replace default launcher icon with final brand icon.
- [ ] Create Play Store icon: 512x512 PNG with alpha, max 1024 KB.
- [ ] Create feature graphic: 1024x500 JPG or 24-bit PNG without alpha.
- [ ] Prepare at least 2 phone screenshots.
- [ ] Recommended for games: at least 3 portrait screenshots at 1080x1920 or 3 landscape screenshots at 1920x1080.
- [ ] Prepare optional preview video as public or unlisted YouTube video.

## Privacy And Safety

- [x] No network calls in the app.
- [x] No account creation.
- [x] No personal data collection.
- [x] No ads.
- [x] No analytics SDK.
- [x] Local preferences only: country, skin, night mode, high score.
- [x] Draft privacy policy created in `docs/PRIVACY_POLICY.md`.
- [ ] Publish privacy policy at a public URL before Play Store review.
- [ ] Complete Data Safety form in Play Console.

## Release Artifacts

APK:

```text
build/app/outputs/flutter-apk/app-release.apk
```

Google Play AAB:

```text
build/app/outputs/bundle/release/app-release.aab
```

Debug symbols:

```text
build/debug-info
```

Keystore:

```text
android/app/upload-keystore.p12
android/key.properties
```

Do not commit or delete the keystore files. Back them up securely.
