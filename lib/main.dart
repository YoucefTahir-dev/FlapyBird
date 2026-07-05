import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game/flappy_quest_game.dart';
import 'services/audio_service.dart';
import 'services/game_storage.dart';
import 'widgets/country_selection_overlay.dart';
import 'widgets/game_over_overlay.dart';
import 'widgets/hud_overlay.dart';
import 'widgets/main_menu_overlay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Flame.device.fullScreen();
  await Flame.device.setPortrait();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final storage = await GameStorage.load();
  final audio = GameAudioService();
  final game = FlappyQuestGame(storage: storage, audio: audio);

  runApp(FlappyQuestApp(game: game));
}

class FlappyQuestApp extends StatelessWidget {
  const FlappyQuestApp({super.key, required this.game});

  final FlappyQuestGame game;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flapy Quest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF16A085)),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: Scaffold(
        body: GameWidget<FlappyQuestGame>(
          game: game,
          overlayBuilderMap: {
            HudOverlay.id: (_, game) => HudOverlay(game: game),
            MainMenuOverlay.id: (_, game) => MainMenuOverlay(game: game),
            CountrySelectionOverlay.id: (_, game) =>
                CountrySelectionOverlay(game: game),
            GameOverOverlay.id: (_, game) => GameOverOverlay(game: game),
          },
          initialActiveOverlays: game.selectedCountry == null
              ? const [CountrySelectionOverlay.id]
              : const [MainMenuOverlay.id],
        ),
      ),
    );
  }
}
