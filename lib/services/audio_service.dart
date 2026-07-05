import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class GameAudioService {
  bool _ready = false;

  Future<void> load() async {
    try {
      await FlameAudio.audioCache.loadAll([
        'flap.wav',
        'point.wav',
        'crash.wav',
        'music.wav',
      ]);
      _ready = true;
    } catch (error) {
      debugPrint('Audio disabled: $error');
      _ready = false;
    }
  }

  void playFlap() {
    _play('flap.wav', fallback: SystemSoundType.click);
  }

  void playPoint() {
    _play('point.wav', fallback: SystemSoundType.alert);
  }

  void playCrash() {
    _play('crash.wav', fallback: SystemSoundType.alert);
  }

  void startMusic() {
    if (!_ready) {
      return;
    }
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('music.wav', volume: 0.25);
  }

  void stopMusic() {
    if (_ready) {
      FlameAudio.bgm.stop();
    }
  }

  void _play(String file, {required SystemSoundType fallback}) {
    if (!_ready) {
      SystemSound.play(fallback);
      return;
    }
    FlameAudio.play(file, volume: 0.55);
  }
}
