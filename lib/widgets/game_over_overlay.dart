import 'package:flutter/material.dart';

import '../game/flappy_quest_game.dart';

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay({super.key, required this.game});

  static const id = 'gameOver';

  final FlappyQuestGame game;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xFF101820).withValues(alpha: 0.82),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Game Over',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Score : ${game.score}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ValueListenableBuilder<int>(
                    valueListenable: game.highScoreNotifier,
                    builder: (context, value, _) {
                      return Text(
                        'Meilleur : $value',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 22),
                  FilledButton.icon(
                    onPressed: game.startGame,
                    icon: const Icon(Icons.replay),
                    label: const Text('RESTART'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(190, 50),
                      backgroundColor: const Color(0xFF06D6A0),
                      foregroundColor: const Color(0xFF101820),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton.icon(
                    onPressed: game.showCountrySelection,
                    icon: const Icon(Icons.flag),
                    label: const Text('Change country'),
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
