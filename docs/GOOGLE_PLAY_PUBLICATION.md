# Google Play Publication Guide

## 1. Create A Google Play Console Account

1. Go to Google Play Console.
2. Create or sign in with a Google account.
3. Complete developer identity verification.
4. Pay the registration fee if requested.
5. Accept the Developer Distribution Agreement.

## 2. Create The App

1. Open Play Console.
2. Select **Create app**.
3. App name: `Flapy Quest`.
4. Type: Game.
5. Price: Free, unless you decide otherwise before first release.
6. Add the required contact email.
7. Accept Play App Signing terms.

## 3. Upload The App Bundle

Use this file:

```text
build/app/outputs/bundle/release/app-release.aab
```

Recommended first track:

```text
Testing > Internal testing
```

After validation:

```text
Testing > Closed testing
Production
```

## 4. Store Listing

Required:

- App name: `Flapy Quest`
- Short description, 80 characters max.
- Full description, 4000 characters max.
- App icon: 512x512 PNG with alpha, max 1024 KB.
- Feature graphic: 1024x500 JPG or 24-bit PNG without alpha.
- At least 2 screenshots.
- Category: Game > Arcade.
- Contact email.

Suggested short description:

```text
Tap, fly, dodge pipes, and wear your country flag in a fast arcade game.
```

Suggested full description:

```text
Flapy Quest is a fast arcade flying game inspired by classic tap-to-fly gameplay.
Choose your country, see its flag directly on your bird, dodge obstacles, unlock skins,
switch day and night mode, and chase your best local score.

Features:
- Simple one-tap flying controls
- Country selection with visible flag skin
- Progressive difficulty
- Local high score
- Day and night mode
- Unlockable bird skins
- Sound effects and background music
```

## 5. App Content

Complete:

- Data Safety
- Privacy Policy
- Ads declaration: No, if no ads are added.
- App access: all features are available without login.
- Content rating questionnaire.
- Target audience and content.
- News apps declaration: No.
- Government apps declaration: No.

## 6. Data Safety Recommendation For Current App

Current implementation:

- No network calls.
- No analytics.
- No ads.
- No account creation.
- No personal data collection.
- Local-only game preferences through SharedPreferences.

Suggested Data Safety direction:

- Data collected: No.
- Data shared: No.
- Security practices: no data transmitted.

You remain responsible for matching the Play Console form to the actual app behavior.

## 7. Release Notes

Use:

```text
Initial release of Flapy Quest:
- Tap-to-fly arcade gameplay
- Country selection with flag skin on the bird
- Progressive obstacles and score
- Local high score
- Day/night mode
- Unlockable skins
```

## 8. Production Release

1. Upload `app-release.aab`.
2. Let Play Console run pre-review checks.
3. Fix any reported issue.
4. Roll out to internal testing.
5. Install from the Play testing link.
6. Promote to closed testing or production when validated.

## Important

Keep these files backed up:

```text
android/app/upload-keystore.p12
android/key.properties
```

Losing the upload keystore can block future updates unless Play App Signing key reset is available for your account.
