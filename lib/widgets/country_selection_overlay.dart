import 'package:flutter/material.dart';

import '../game/flag_painter.dart';
import '../game/flappy_quest_game.dart';
import '../models/country.dart';

class CountrySelectionOverlay extends StatefulWidget {
  const CountrySelectionOverlay({super.key, required this.game});

  static const id = 'countrySelection';

  final FlappyQuestGame game;

  @override
  State<CountrySelectionOverlay> createState() =>
      _CountrySelectionOverlayState();
}

class _CountrySelectionOverlayState extends State<CountrySelectionOverlay> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredCountries = countries.where((country) {
      final text = '${country.name} ${country.code}'.toLowerCase();
      return text.contains(query.trim().toLowerCase());
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 8),
            const Text(
              'Choose your country',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 31,
                fontWeight: FontWeight.w900,
                shadows: [Shadow(blurRadius: 8, offset: Offset(0, 3))],
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              onChanged: (value) => setState(() => query = value),
              decoration: InputDecoration(
                hintText: 'Search country',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.94),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFF101820).withValues(alpha: 0.48),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.22),
                  ),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: filteredCountries.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                  itemBuilder: (context, index) {
                    final country = filteredCountries[index];
                    return _CountryTile(
                      country: country,
                      selected:
                          widget.game.selectedCountry?.code == country.code,
                      onTap: () => widget.game.selectCountry(country),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CountryTile extends StatelessWidget {
  const _CountryTile({
    required this.country,
    required this.selected,
    required this.onTap,
  });

  final Country country;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CustomPaint(
        size: const Size(46, 30),
        painter: _FlagPreviewPainter(country),
      ),
      title: Text(
        country.name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        country.emoji,
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: selected
          ? const Icon(Icons.check_circle, color: Color(0xFF06D6A0))
          : const Icon(Icons.chevron_right, color: Colors.white70),
    );
  }
}

class _FlagPreviewPainter extends CustomPainter {
  const _FlagPreviewPainter(this.country);

  final Country country;

  @override
  void paint(Canvas canvas, Size size) {
    FlagPainter.paint(canvas, Offset.zero & size, country);
  }

  @override
  bool shouldRepaint(covariant _FlagPreviewPainter oldDelegate) {
    return oldDelegate.country.code != country.code;
  }
}
