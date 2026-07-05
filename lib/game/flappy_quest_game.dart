import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

import '../models/country.dart';
import '../services/audio_service.dart';
import '../services/game_storage.dart';
import '../widgets/country_selection_overlay.dart';
import '../widgets/game_over_overlay.dart';
import '../widgets/hud_overlay.dart';
import '../widgets/main_menu_overlay.dart';
import 'components/background.dart';
import 'components/bird.dart';
import 'components/ground.dart';
import 'components/pipe_pair.dart';
import 'components/spark_particle.dart';

enum GamePhase { menu, playing, gameOver }

class FlappyQuestGame extends FlameGame
    with HasCollisionDetection, TapCallbacks {
  FlappyQuestGame({required this.storage, required this.audio}) {
    highScoreNotifier.value = storage.highScore;
    skinNotifier.value = storage.selectedSkin;
    nightModeNotifier.value = storage.nightMode;
    final savedCountryCode = storage.selectedCountryCode;
    if (savedCountryCode != null) {
      selectedCountryNotifier.value = countryByCode(savedCountryCode);
    }
  }

  final GameStorage storage;
  final GameAudioService audio;
  final Random _random = Random();

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> highScoreNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> skinNotifier = ValueNotifier<int>(0);
  final ValueNotifier<bool> nightModeNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<Country?> selectedCountryNotifier =
      ValueNotifier<Country?>(null);

  late Bird bird;
  late Ground ground;
  GamePhase phase = GamePhase.menu;

  double obstacleTimer = 0;
  double obstacleInterval = 1.55;
  double worldSpeed = 185;

  int get score => scoreNotifier.value;
  int get highScore => highScoreNotifier.value;
  int get selectedSkin => skinNotifier.value;
  bool get isNightMode => nightModeNotifier.value;
  Country? get selectedCountry => selectedCountryNotifier.value;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await audio.load();
    _buildScene();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (isLoaded) {
      _buildScene();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (phase != GamePhase.playing || size.x <= 0 || size.y <= 0) {
      return;
    }

    obstacleTimer += dt;
    worldSpeed = min(330, 185 + score * 5.5);
    obstacleInterval = max(1.0, 1.55 - score * 0.012);

    if (obstacleTimer >= obstacleInterval) {
      obstacleTimer = 0;
      add(_createPipePair());
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (phase == GamePhase.playing) {
      bird.flap();
      audio.playFlap();
    }
  }

  void startGame() {
    if (selectedCountry == null) {
      showCountrySelection();
      return;
    }

    overlays.remove(CountrySelectionOverlay.id);
    overlays.remove(MainMenuOverlay.id);
    overlays.remove(GameOverOverlay.id);
    overlays.add(HudOverlay.id);

    removeAll(children.whereType<PipePair>().toList());
    removeAll(children.whereType<SparkParticle>().toList());

    scoreNotifier.value = 0;
    obstacleTimer = obstacleInterval;
    worldSpeed = 185;
    phase = GamePhase.playing;

    bird.reset(
      position: Vector2(size.x * 0.28, size.y * 0.42),
      skinIndex: selectedSkin,
      country: selectedCountry,
    );
    audio.startMusic();
  }

  Future<void> endGame() async {
    if (phase != GamePhase.playing) {
      return;
    }

    phase = GamePhase.gameOver;
    audio.stopMusic();
    audio.playCrash();
    _burstAt(bird.position + bird.size / 2);

    if (score > highScore) {
      highScoreNotifier.value = score;
      await storage.saveHighScore(score);
    }

    overlays.remove(HudOverlay.id);
    overlays.add(GameOverOverlay.id);
  }

  Future<void> toggleNightMode() async {
    nightModeNotifier.value = !nightModeNotifier.value;
    await storage.saveNightMode(nightModeNotifier.value);
    _buildScene();
  }

  Future<void> selectSkin(int index) async {
    if (!isSkinUnlocked(index)) {
      return;
    }
    skinNotifier.value = index;
    await storage.saveSelectedSkin(index);
    bird.skinIndex = index;
  }

  Future<void> selectCountry(Country country) async {
    selectedCountryNotifier.value = country;
    await storage.saveSelectedCountry(country.code);
    bird.country = country;
    overlays.remove(CountrySelectionOverlay.id);
    if (phase != GamePhase.playing) {
      phase = GamePhase.menu;
      overlays.add(MainMenuOverlay.id);
    }
  }

  void showCountrySelection() {
    if (phase == GamePhase.playing) {
      return;
    }
    overlays.remove(MainMenuOverlay.id);
    overlays.remove(GameOverOverlay.id);
    overlays.remove(HudOverlay.id);
    overlays.add(CountrySelectionOverlay.id);
  }

  bool isSkinUnlocked(int index) {
    return switch (index) {
      0 => true,
      1 => highScore >= 5,
      2 => highScore >= 12,
      _ => false,
    };
  }

  void addPoint() {
    if (phase != GamePhase.playing) {
      return;
    }
    scoreNotifier.value += 1;
    audio.playPoint();
  }

  double groundTop() => size.y - max(78, size.y * 0.12);

  PipePair _createPipePair() {
    final groundY = groundTop();
    final gap = max(145.0, 185 - score * 1.6);
    final minCenter = 118.0 + gap / 2;
    final maxCenter = groundY - 92.0 - gap / 2;
    final centerY =
        minCenter + _random.nextDouble() * max(1, maxCenter - minCenter);

    return PipePair(
      x: size.x + 70,
      gapCenterY: centerY,
      gapHeight: gap,
      pipeWidth: max(58, size.x * 0.15),
    );
  }

  void _buildScene() {
    removeAll(children.whereType<Background>().toList());
    removeAll(children.whereType<Ground>().toList());

    add(Background(nightMode: isNightMode));
    ground = Ground(topY: groundTop());
    add(ground);

    if (!children.whereType<Bird>().isNotEmpty) {
      bird = Bird(
        startPosition: Vector2(
          size.x > 0 ? size.x * 0.28 : 120,
          size.y > 0 ? size.y * 0.42 : 260,
        ),
        skinIndex: selectedSkin,
        country: selectedCountry,
      );
      add(bird);
    }
  }

  void _burstAt(Vector2 origin) {
    for (var i = 0; i < 22; i++) {
      add(
        SparkParticle(
          origin: origin.clone(),
          velocity: Vector2(
            -80 + _random.nextDouble() * 160,
            -210 + _random.nextDouble() * 190,
          ),
          color: Color.lerp(
            const Color(0xFFFFD166),
            const Color(0xFFEF476F),
            _random.nextDouble(),
          )!,
        ),
      );
    }
  }
}
