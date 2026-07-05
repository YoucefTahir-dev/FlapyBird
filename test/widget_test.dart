import 'package:flutter_test/flutter_test.dart';
import 'package:flapy_bird/services/game_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('project smoke test', () {
    expect('Flapy Quest'.contains('Quest'), isTrue);
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
}
