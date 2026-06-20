import 'package:flowery_driver/config/base_response/base_response.dart';
import 'package:flowery_driver/modules/auth/domain/entities/country_entity.dart';

abstract interface class GetCountriesContract {
  Future<Result<List<CountryEntity>>> getCountries();
}