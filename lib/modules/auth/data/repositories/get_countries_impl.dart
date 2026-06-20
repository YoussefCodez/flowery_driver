import 'package:flowery_driver/config/base_response/base_response.dart';
import 'package:flowery_driver/core/utils/error_handler.dart';
import 'package:flowery_driver/modules/auth/data/datasources/country_data_source.dart';
import 'package:flowery_driver/modules/auth/data/models/country_model.dart';
import 'package:flowery_driver/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery_driver/modules/auth/domain/repositories/get_countries_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: GetCountriesContract)
class GetCountriesImpl implements GetCountriesContract {
  final CountryDataSource countryDataSource;

  GetCountriesImpl({required this.countryDataSource});

  @override
  Future<Result<List<CountryEntity>>> getCountries() async {
    try {
      final List<CountryModel> countries = await countryDataSource.getCountries();
      return Success(
        data: countries.map((country) => country.toEntity()).toList(),
      );
    } catch (e) {
      return Error(exception: ErrorHandler.handle(e));
    }
  }
}