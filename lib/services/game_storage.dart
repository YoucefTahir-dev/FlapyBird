import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameStorage {
  GameStorage._(this._preferences);

  final SharedPreferences _preferences;

  static const _highScoreKey = 'high_score';
  static const _highScoreSignatureKey = 'high_score_signature';
  static const _selectedSkinKey = 'selected_skin';
  static const _nightModeKey = 'night_mode';
  static const _selectedCountryKey = 'selected_country';
  static const _scorePepper = 'flapy_quest_local_score_v1';

  static Future<GameStorage> load() async {
    final preferences = await SharedPreferences.getInstance();
    return GameStorage._(preferences);
  }

  int get highScore {
    final value = _preferences.getInt(_highScoreKey) ?? 0;
    final signature = _preferences.getString(_highScoreSignatureKey);
    if (signature == null) {
      return value;
    }
    return signature == _scoreSignature(value) ? value : 0;
  }

  int get selectedSkin => _preferences.getInt(_selectedSkinKey) ?? 0;
  bool get nightMode => _preferences.getBool(_nightModeKey) ?? false;
  String? get selectedCountryCode =>
      _preferences.getString(_selectedCountryKey);

  Future<void> saveHighScore(int value) async {
    final sanitizedValue = value.clamp(0, 999999).toInt();
    await _preferences.setInt(_highScoreKey, sanitizedValue);
    await _preferences.setString(
      _highScoreSignatureKey,
      _scoreSignature(sanitizedValue),
    );
  }

  Future<void> saveSelectedSkin(int value) async {
    await _preferences.setInt(_selectedSkinKey, value);
  }

  Future<void> saveNightMode(bool value) async {
    await _preferences.setBool(_nightModeKey, value);
  }

  Future<void> saveSelectedCountry(String code) async {
    await _preferences.setString(_selectedCountryKey, code);
  }

  String _scoreSignature(int value) {
    return sha256.convert(utf8.encode('$_scorePepper:$value')).toString();
  }
}
