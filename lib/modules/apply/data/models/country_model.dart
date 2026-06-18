import 'package:flowery_driver/modules/apply/domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  const CountryModel({
    required super.isoCode,
    required super.name,
    required super.phoneCode,
    required super.flag,
    required super.currency,
    required super.latitude,
    required super.longitude,
    required List<TimezoneModel> super.timezones,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      isoCode: json['isoCode'] ?? '',
      name: json['name'] ?? '',
      phoneCode: json['phoneCode'] ?? '',
      flag: json['flag'] ?? '',
      currency: json['currency'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      timezones: (json['timezones'] as List<dynamic>?)
              ?.map((x) => TimezoneModel.fromJson(x as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isoCode': isoCode,
      'name': name,
      'phoneCode': phoneCode,
      'flag': flag,
      'currency': currency,
      'latitude': latitude,
      'longitude': longitude,
      'timezones': timezones
          .map((x) => (x as TimezoneModel).toJson())
          .toList(),
    };
  }
}

class TimezoneModel extends TimezoneEntity {
  const TimezoneModel({
    required super.zoneName,
    required super.gmtOffset,
    required super.gmtOffsetName,
    required super.abbreviation,
    required super.tzName,
  });

  factory TimezoneModel.fromJson(Map<String, dynamic> json) {
    return TimezoneModel(
      zoneName: json['zoneName'] ?? '',
      gmtOffset: (json['gmtOffset'] as num?)?.toInt() ?? 0,
      gmtOffsetName: json['gmtOffsetName'] ?? '',
      abbreviation: json['abbreviation'] ?? '',
      tzName: json['tzName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'zoneName': zoneName,
      'gmtOffset': gmtOffset,
      'gmtOffsetName': gmtOffsetName,
      'abbreviation': abbreviation,
      'tzName': tzName,
    };
  }
}
