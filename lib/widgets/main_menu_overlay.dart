import 'package:flutter/material.dart';

import '../game/flappy_quest_game.dart';

class MainMenuOverlay extends StatelessWidget {
  const MainMenuOverlay({super.key, required this.game});

  static const id = 'mainMenu';

  final FlappyQuestGame game;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'Flapy Quest',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 46,
                fontWeight: FontWeight.w900,
                shadows: [Shadow(blurRadius: 10, offset: Offset(0, 4))],
              ),
            ),
            const SizedBox(height: 10),
            ValueListenableBuilder<int>(
              valueListenable: game.highScoreNotifier,
              builder: (context, value, _) {
                return Text(
                  'Meilleur score : $value',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder(
              valueListenable: game.selectedCountryNotifier,
              builder: (context, country, _) {
                return TextButton.icon(
                  onPressed: game.showCountrySelection,
                  icon: const Icon(Icons.flag),
                  label: Text(
                    country == null ? 'Choose country' : country.name,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: game.startGame,
              style: FilledButton.styleFrom(
                minimumSize: const Size(210, 54),
                backgroundColor: const Color(0xFFEF476F),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'PLAY',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 24),
            _SkinSelector(game: game),
            const SizedBox(height: 18),
            ValueListenableBuilder<bool>(
              valueListenable: game.nightModeNotifier,
              builder: (context, night, _) {
                return SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(
                      value: false,
                      icon: Icon(Icons.wb_sunny),
                      label: Text('Jour'),
                    ),
                    ButtonSegment(
                      value: true,
                      icon: Icon(Icons.nightlight),
                      label: Text('Nuit'),
                    ),
                  ],
                  selected: {night},
                  onSelectionChanged: (_) => game.toggleNightMode(),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.white.withValues(alpha: 0.9),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            const Text(
              'Tape l ecran pour voler. Evite les tuyaux.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkinSelector extends StatelessWidget {
  const _SkinSelector({required this.game});

  final FlappyQuestGame game;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: game.skinNotifier,
      builder: (context, selected, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            final unlocked = game.isSkinUnlocked(index);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Tooltip(
                message: unlocked ? 'Skin ${index + 1}' : _unlockText(index),
                child: IconButton.filled(
                  onPressed: unlocked ? () => game.selectSkin(index) : null,
                  style: IconButton.styleFrom(
                    backgroundColor: selected == index
                        ? const Color(0xFFFFD166)
                        : Colors.white.withValues(alpha: 0.88),
                    disabledBackgroundColor: Colors.black.withValues(
                      alpha: 0.22,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: Icon(
                    unlocked ? Icons.flutter_dash : Icons.lock,
                    color: unlocked ? _skinColor(index) : Colors.white70,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Color _skinColor(int index) {
    return switch (index) {
      1 => const Color(0xFF2F80ED),
      2 => const Color(0xFFEF476F),
      _ => const Color(0xFFFFA62B),
    };
  }

  String _unlockText(int index) {
    return switch (index) {
      1 => 'Debloque a 5 points',
      2 => 'Debloque a 12 points',
      _ => 'Disponible',
    };
  }
}
