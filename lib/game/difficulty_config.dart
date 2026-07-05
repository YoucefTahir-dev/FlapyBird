import 'dart:math';

class DifficultySettings {
  const DifficultySettings({
    required this.speed,
    required this.pipeGap,
    required this.spawnInterval,
    required this.gravity,
  });

  final double speed;
  final double pipeGap;
  final double spawnInterval;
  final double gravity;
}

class GameDifficultyConfig {
  const GameDifficultyConfig._();

  static const DifficultySettings start = DifficultySettings(
    speed: 185,
    pipeGap: 185,
    spawnInterval: 1.55,
    gravity: 930,
  );

  static const DifficultySettings mid = DifficultySettings(
    speed: 225,
    pipeGap: 170,
    spawnInterval: 1.42,
    gravity: 930,
  );

  static const DifficultySettings hard = DifficultySettings(
    speed: 275,
    pipeGap: 154,
    spawnInterval: 1.25,
    gravity: 985,
  );

  static const DifficultySettings expertBase = DifficultySettings(
    speed: 305,
    pipeGap: 145,
    spawnInterval: 1.12,
    gravity: 1025,
  );

  static const DifficultySettings ceiling = DifficultySettings(
    speed: 350,
    pipeGap: 136,
    spawnInterval: 1.02,
    gravity: 1065,
  );

  static DifficultySettings forScore(int score) {
    final safeScore = max(0, score);

    if (safeScore <= 10) {
      return _lerp(start, mid, safeScore / 10);
    }
    if (safeScore <= 25) {
      return _lerp(mid, hard, (safeScore - 10) / 15);
    }
    if (safeScore <= 50) {
      return _lerp(hard, expertBase, (safeScore - 25) / 25);
    }

    final longRunProgress = min(1.0, (safeScore - 50) / 80);
    return _lerp(expertBase, ceiling, longRunProgress);
  }

  static DifficultySettings _lerp(
    DifficultySettings from,
    DifficultySettings to,
    double progress,
  ) {
    final t = progress.clamp(0.0, 1.0);
    return DifficultySettings(
      speed: _value(from.speed, to.speed, t),
      pipeGap: _value(from.pipeGap, to.pipeGap, t),
      spawnInterval: _value(from.spawnInterval, to.spawnInterval, t),
      gravity: _value(from.gravity, to.gravity, t),
    );
  }

  static double _value(double from, double to, double progress) {
    return from + (to - from) * progress;
  }
}
