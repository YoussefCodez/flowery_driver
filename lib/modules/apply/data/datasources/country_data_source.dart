import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flowery_driver/modules/apply/data/models/country_model.dart';

abstract class CountryRemoteDataSource {
  Future<List<CountryModel>> getCountries();
}

class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  final String _assetPath;

  CountryRemoteDataSourceImpl({String assetPath = 'assets/json/countries.json'})
      : _assetPath = assetPath;

  @override
  Future<List<CountryModel>> getCountries() async {
    try {
      final String jsonString = await rootBundle.loadString(_assetPath);
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;

      return jsonList
          .map((item) => CountryModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load countries: $e');
    }
  }
}
