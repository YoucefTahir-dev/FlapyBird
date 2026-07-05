# Google Play Data Safety

Last updated: 2026-07-05

Use the following answers in Google Play Console for the current version of
Flapy Quest.

## Data Collection

- Data collected: No.
- Data shared with third parties: No.
- Data encrypted in transit: Not applicable, because the app does not send user
  data over the network.
- Account creation: Not supported.
- Users can request data deletion: Not applicable, because no data is collected
  by the developer.

## Local Data

The app stores these values only on the user's device with SharedPreferences:

- selected country ISO code
- selected visual preferences
- local high score

These values are not transmitted to the developer or to third parties.

## Permissions

The current Android manifest declares no dangerous runtime permission.

## Recommended Play Console Disclosure

Privacy policy: Required only if Google Play asks for it based on the listing
or future SDK changes, but publishing one is recommended. Use
`docs/PRIVACY_POLICY.md` as the source text and host it at a public HTTPS URL.
