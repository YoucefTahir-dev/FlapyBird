import 'package:flutter_test/flutter_test.dart';
import 'package:flapy_bird/game/difficulty_config.dart';
import 'package:flapy_bird/models/country.dart';
import 'package:flapy_bird/services/game_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('project smoke test', () {
    expect('Flapy Quest'.contains('Quest'), isTrue);
  });

  test('required countries are available for selection', () {
    expect(countries.length, greaterThanOrEqualTo(240));
    expect(
      countries.map((country) => country.isoCode),
      containsAll(['DZ', 'FR', 'MA', 'TN', 'ES', 'IT', 'DE', 'GB', 'US']),
    );
  });

  test('countries are sorted alphabetically', () {
    final sortedNames = countries.map((country) => country.name).toList()
      ..sort();
    expect(
      countries.map((country) => country.name),
      orderedEquals(sortedNames),
    );
  });

  test('all countries have ISO code and flag emoji', () {
    for (final country in countries) {
      expect(country.isoCode.length, 2);
      expect(country.flagEmoji, isNotEmpty);
    }
  });

  test('difficulty increases progressively without abrupt spikes', () {
    final samples = [
      0,
      10,
      25,
      50,
      75,
      130,
    ].map(GameDifficultyConfig.forScore).toList();

    expect(
      samples.map((settings) => settings.speed),
      orderedEquals(samples.map((settings) => settings.speed).toList()..sort()),
    );
    expect(
      samples.map((settings) => settings.gravity),
      orderedEquals(
        samples.map((settings) => settings.gravity).toList()..sort(),
      ),
    );
    expect(samples.last.pipeGap, greaterThanOrEqualTo(136));
    expect(samples.last.spawnInterval, greaterThanOrEqualTo(1.02));
  });

  test('difficulty has smooth score-to-score transitions', () {
    for (var score = 0; score < 130; score++) {
      final current = GameDifficultyConfig.forScore(score);
      final next = GameDifficultyConfig.forScore(score + 1);

      expect((next.speed - current.speed).abs(), lessThanOrEqualTo(4.1));
      expect((next.pipeGap - current.pipeGap).abs(), lessThanOrEqualTo(1.7));
      expect(
        (next.spawnInterval - current.spawnInterval).abs(),
        lessThanOrEqualTo(0.014),
      );
      expect((next.gravity - current.gravity).abs(), lessThanOrEqualTo(3.7));
    }
  });

  test('legacy required country codes are available in lowercase too', () {
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
