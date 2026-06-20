import 'package:flowery_driver/config/base_response/base_response.dart';
import 'package:flowery_driver/modules/auth/domain/entities/country_entity.dart';
import 'package:flowery_driver/modules/auth/domain/repositories/get_countries_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCountriesUseCase {
  final GetCountriesContract repository;

  GetCountriesUseCase(this.repository);
  Future<Result<List<CountryEntity>>> getCountries() async {
    return await repository.getCountries();
  }
}