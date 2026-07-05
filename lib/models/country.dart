import 'package:country_picker/country_picker.dart' as picker;

class Country {
  const Country({
    required this.code,
    required this.name,
    required this.flagEmoji,
  });

  final String code;
  final String name;
  final String flagEmoji;

  String get isoCode => code.toUpperCase();

  String get searchableText => '$name $isoCode $flagEmoji'.toLowerCase();
}

final List<Country> countries = _loadCountries();

Country get defaultCountry => countryByCode('DZ');

Country countryByCode(String? code) {
  if (code == null || code.trim().isEmpty) {
    return _countryByCodeOrFirst('DZ');
  }

  final normalizedCode = code.trim().toUpperCase();
  return _countryByCodeOrFirst(normalizedCode);
}

Country _countryByCodeOrFirst(String normalizedCode) {
  return countries.firstWhere(
    (country) => country.isoCode == normalizedCode.toUpperCase(),
    orElse: () => countries.firstWhere(
      (country) => country.isoCode == 'DZ',
      orElse: () => countries.first,
    ),
  );
}

List<Country> _loadCountries() {
  final service = picker.CountryService();
  final mappedCountries =
      service
          .getAll()
          .where(
            (country) =>
                country.countryCode != picker.Country.worldWide.countryCode,
          )
          .map(
            (country) => Country(
              code: country.countryCode.toLowerCase(),
              name: country.displayNameNoCountryCode,
              flagEmoji: country.flagEmoji,
            ),
          )
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name));

  return List.unmodifiable(mappedCountries);
}
