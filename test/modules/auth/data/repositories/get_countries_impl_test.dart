import 'package:flowery_driver/config/base_response/base_response.dart';
import 'package:flowery_driver/modules/auth/data/datasources/country_data_source.dart';
import 'package:flowery_driver/modules/auth/data/models/country_model.dart';
import 'package:flowery_driver/modules/auth/data/repositories/get_countries_impl.dart';
import 'package:flowery_driver/modules/auth/domain/entities/country_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_countries_impl_test.mocks.dart';

@GenerateMocks([CountryDataSource])
void main() {
  late GetCountriesImpl repository;
  late MockCountryDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCountryDataSource();
    repository = GetCountriesImpl(countryDataSource: mockDataSource);
  });

  final List<CountryModel> tCountryModelList = [
    const CountryModel(
      name: 'Egypt',
      phoneCode: '20',
      isoCode: 'EG',
      flag: '🇪🇬',
      currency: 'EGP',
      latitude: '26',
      longitude: '30',
      timezones: [],
    ),
  ];
  
  final tCountryEntityList = tCountryModelList.map((e) => e.toEntity()).toList();

  group('getCountries', () {
    test('should return Success with List<CountryEntity> when call is successful', () async {
      // arrange
      when(mockDataSource.getCountries())
          .thenAnswer((_) async => tCountryModelList);
      // act
      final result = await repository.getCountries();
      // assert
      verify(mockDataSource.getCountries());
      expect(result, isA<Success<List<CountryEntity>>>());
      expect((result as Success<List<CountryEntity>>).data, tCountryEntityList);
    });

    test('should return Error when call throws an exception', () async {
      // arrange
      when(mockDataSource.getCountries())
          .thenThrow(Exception('Failed'));
      // act
      final result = await repository.getCountries();
      // assert
      verify(mockDataSource.getCountries());
      expect(result, isA<Error<List<CountryEntity>>>());
    });
  });
}
