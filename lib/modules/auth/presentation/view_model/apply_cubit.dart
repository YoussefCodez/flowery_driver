import 'package:flowery_driver/config/base_state/base_state.dart';
import 'package:flowery_driver/modules/auth/domain/entities/apply_body_entity.dart';
import 'package:flowery_driver/modules/auth/domain/usecases/get_countires_usecase.dart';
import 'package:flowery_driver/modules/auth/domain/usecases/send_application_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyCubit extends Cubit<BaseState> {
  ApplyCubit(this.getCountriesUseCase, this.applyUseCase)
    : super(const BaseState.initial());
  final GetCountriesUseCase getCountriesUseCase;
  final ApplyUseCase applyUseCase;
  Future<void> getCountries() async {
    emit(const BaseState.loading());
    final result = await getCountriesUseCase.getCountries();
    result.when(
      success: (data) {
        emit(BaseState.success(data));
      },
      error: (exception) {
        emit(BaseState.error(exception));
      },
    );
  }

  Future<void> apply(ApplyBodyEntity body) async {
    emit(const BaseState.loading());
    final result = await applyUseCase.apply(body);
    result.when(
      success: (data) {
        emit(BaseState.success(data));
      },
      error: (exception) {
        emit(BaseState.error(exception));
      },
    );
  }
}
