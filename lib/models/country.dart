import 'dart:ui';

class Country {
  const Country({
    required this.code,
    required this.name,
    required this.emoji,
    required this.pattern,
  });

  final String code;
  final String name;
  final String emoji;
  final FlagPattern pattern;
}

enum FlagLayout { vertical, horizontal, cross, cantonStripes }

class FlagPattern {
  const FlagPattern({
    required this.layout,
    required this.colors,
    this.crossColor,
    this.cantonColor,
    this.starColor,
  });

  final FlagLayout layout;
  final List<Color> colors;
  final Color? crossColor;
  final Color? cantonColor;
  final Color? starColor;
}

const countries = <Country>[
  Country(
    code: 'dz',
    name: 'Algerie',
    emoji: 'DZ',
    pattern: FlagPattern(
      layout: FlagLayout.vertical,
      colors: [Color(0xFF006633), Color(0xFFFFFFFF)],
      crossColor: Color(0xFFD21034),
    ),
  ),
  Country(
    code: 'fr',
    name: 'France',
    emoji: 'FR',
    pattern: FlagPattern(
      layout: FlagLayout.vertical,
      colors: [Color(0xFF0055A4), Color(0xFFFFFFFF), Color(0xFFEF4135)],
    ),
  ),
  Country(
    code: 'ma',
    name: 'Maroc',
    emoji: 'MA',
    pattern: FlagPattern(
      layout: FlagLayout.horizontal,
      colors: [Color(0xFFC1272D)],
      starColor: Color(0xFF006233),
    ),
  ),
  Country(
    code: 'tn',
    name: 'Tunisie',
    emoji: 'TN',
    pattern: FlagPattern(
      layout: FlagLayout.horizontal,
      colors: [Color(0xFFE70013)],
      starColor: Color(0xFFFFFFFF),
    ),
  ),
  Country(
    code: 'es',
    name: 'Espagne',
    emoji: 'ES',
    pattern: FlagPattern(
      layout: FlagLayout.horizontal,
      colors: [Color(0xFFAA151B), Color(0xFFF1BF00), Color(0xFFAA151B)],
    ),
  ),
  Country(
    code: 'it',
    name: 'Italie',
    emoji: 'IT',
    pattern: FlagPattern(
      layout: FlagLayout.vertical,
      colors: [Color(0xFF009246), Color(0xFFFFFFFF), Color(0xFFCE2B37)],
    ),
  ),
  Country(
    code: 'de',
    name: 'Allemagne',
    emoji: 'DE',
    pattern: FlagPattern(
      layout: FlagLayout.horizontal,
      colors: [Color(0xFF000000), Color(0xFFDD0000), Color(0xFFFFCE00)],
    ),
  ),
  Country(
    code: 'gb',
    name: 'Royaume-Uni',
    emoji: 'UK',
    pattern: FlagPattern(
      layout: FlagLayout.cross,
      colors: [Color(0xFF012169)],
      crossColor: Color(0xFFC8102E),
      starColor: Color(0xFFFFFFFF),
    ),
  ),
  Country(
    code: 'us',
    name: 'Etats-Unis',
    emoji: 'US',
    pattern: FlagPattern(
      layout: FlagLayout.cantonStripes,
      colors: [Color(0xFFB22234), Color(0xFFFFFFFF)],
      cantonColor: Color(0xFF3C3B6E),
      starColor: Color(0xFFFFFFFF),
    ),
  ),
];

Country countryByCode(String? code) {
  return countries.firstWhere(
    (country) => country.code == code,
    orElse: () => countries.first,
  );
}
