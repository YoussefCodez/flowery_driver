// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../modules/auth/data/datasources/apply_data_source.dart' as _i144;
import '../../modules/auth/data/datasources/country_data_source.dart' as _i1022;
import '../../modules/auth/data/repositories/get_countries_impl.dart' as _i1009;
import '../../modules/auth/data/repositories/send_application_impl.dart'
    as _i1034;
import '../../modules/auth/domain/repositories/get_countries_contract.dart'
    as _i693;
import '../../modules/auth/domain/repositories/send_application_contract.dart'
    as _i330;
import '../../modules/auth/domain/usecases/get_countires_usecase.dart' as _i158;
import '../../modules/auth/domain/usecases/send_application_usecase.dart'
    as _i675;
import '../../modules/auth/presentation/view_model/apply_cubit.dart' as _i552;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i1022.CountryDataSource>(
      () => _i1022.CountryDataSource(),
    );
    gh.lazySingleton<_i144.ApplyDataSource>(
      () => _i144.ApplyDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i693.GetCountriesContract>(
      () => _i1009.GetCountriesImpl(
        countryDataSource: gh<_i1022.CountryDataSource>(),
      ),
    );
    gh.lazySingleton<_i330.SendApplicationContract>(
      () => _i1034.SendApplicationImpl(dataSource: gh<_i144.ApplyDataSource>()),
    );
    gh.factory<_i158.GetCountriesUseCase>(
      () => _i158.GetCountriesUseCase(gh<_i693.GetCountriesContract>()),
    );
    gh.factory<_i675.ApplyUseCase>(
      () => _i675.ApplyUseCase(contract: gh<_i330.SendApplicationContract>()),
    );
    gh.factory<_i552.ApplyCubit>(
      () => _i552.ApplyCubit(
        gh<_i158.GetCountriesUseCase>(),
        gh<_i675.ApplyUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
