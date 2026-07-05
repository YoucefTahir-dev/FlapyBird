# Final Google Play Audit

Date: 2026-07-05

## Verdict

Flapy Quest is technically ready for an internal Google Play test release.

The release APK and AAB build successfully, the APK is signed, the app targets
Android SDK 36, and no dangerous runtime permission is declared in the release
manifest.

## Commands Validated

```powershell
C:\src\flutter\bin\flutter.bat doctor -v
C:\src\flutter\bin\flutter.bat pub get
C:\src\flutter\bin\flutter.bat pub outdated
C:\src\flutter\bin\dart.bat format lib test
C:\src\flutter\bin\flutter.bat analyze
C:\src\flutter\bin\flutter.bat test
C:\src\flutter\bin\flutter.bat test --coverage
C:\src\flutter\bin\flutter.bat build apk --release --obfuscate --split-debug-info=build\debug-info
C:\src\flutter\bin\flutter.bat build appbundle --release --obfuscate --split-debug-info=build\debug-info
```

## Build Artifacts

- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab`
- Debug symbols: `build/debug-info`

## Android Release Configuration

- Application ID: `com.flapyquest.game`
- App name: `Flapy Quest`
- Version name: `1.0.0`
- Version code: `1`
- Min SDK: 24
- Target SDK: 36
- Compile SDK: 36
- Release signing: configured through ignored `android/key.properties`
- Minification: enabled
- Resource shrinking: enabled
- ProGuard: explicit `android/app/proguard-rules.pro`
- Dart obfuscation: enabled by release build commands

## Security Findings

| Severity | Finding | Status |
| --- | --- | --- |
| Critical | Hardcoded signing secrets | Passed: none found in tracked files. |
| Critical | Dangerous release permissions | Passed: none declared. |
| High | Unsiged release APK | Passed: APK Signature Scheme v2 verified. |
| Medium | High score tampering | Mitigated: signed local score test passes. |
| Medium | Reverse engineering | Mitigated: R8, shrinkResources, and Dart obfuscation enabled. |
| Low | Sideload warning | Expected: Android warns for apps installed outside Google Play. |

## Store Assets

- Play icon: `assets/store/play_store_icon_512.png`, 512x512, 32 KB
- Feature graphic: `assets/store/feature_graphic_1024x500.png`, 1024x500, 63 KB
- Phone screenshots:
  - `assets/store/screenshots/phone_1_country.png`
  - `assets/store/screenshots/phone_2_menu.png`
  - `assets/store/screenshots/phone_3_gameplay.png`

## Privacy And Data Safety

Current app behavior:

- no account
- no ads
- no analytics SDK
- no network calls
- local-only SharedPreferences for country, visual preferences, and high score

Documents:

- Privacy Policy: `docs/PRIVACY_POLICY.md`
- Data Safety: `docs/DATA_SAFETY.md`
- Terms of Use: `docs/TERMS_OF_USE.md`

Before production review, host the privacy policy at a public HTTPS URL and use
that URL in Play Console.

## Scores

- Code quality: 8.5/10
- Security: 8.5/10
- Performance: 8/10
- Google Play readiness: 8.5/10

## Remaining Non-Critical Recommendations

- Capture final screenshots from a real phone or emulator for the production
  marketing listing.
- Add integration tests for live tap, collision, restart, and skin rendering.
- Add a short privacy policy web page and link it in Play Console.
- Back up `android/app/upload-keystore.p12` and `android/key.properties` in a
  private password manager or secure vault.
