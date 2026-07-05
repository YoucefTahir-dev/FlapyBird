import 'package:flutter_test/flutter_test.dart';
import 'package:flapy_bird/models/country.dart';
import 'package:flapy_bird/services/game_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('project smoke test', () {
    expect('Flapy Quest'.contains('Quest'), isTrue);
  });

  test('required countries are available for selection', () {
    expect(
      countries.map((country) => country.code),
      containsAll(['dz', 'fr', 'ma', 'tn', 'es', 'it', 'de', 'gb', 'us']),
    );
  });

  test('unknown country code falls back to Algeria', () {
    expect(countryByCode('unknown').code, 'dz');
  });

  test(
    'high score tampering without signature is rejected after signing',
    () async {
      SharedPreferences.setMockInitialValues({});
      final storage = await GameStorage.load();

      await storage.saveHighScore(12);
      expect(storage.highScore, 12);

      final preferences = await SharedPreferences.getInstance();
      await preferences.setInt('high_score', 9999);

      expect(storage.highScore, 0);
    },
  );

  test('selected country is persisted locally', () async {
    SharedPreferences.setMockInitialValues({});
    final storage = await GameStorage.load();

    await storage.saveSelectedCountry('fr');

    expect(storage.selectedCountryCode, 'fr');
  });
}
