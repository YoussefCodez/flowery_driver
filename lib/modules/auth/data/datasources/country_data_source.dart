import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flowery_driver/modules/auth/data/models/country_model.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CountryDataSource {
  static const String dataSource = 'assets/json/countries.json';

  Future<List<CountryModel>> getCountries() async {
    final String jsonString = await rootBundle.loadString(dataSource);
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;

    return jsonList
        .map((item) => CountryModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
