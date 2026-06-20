import 'package:flowery_driver/config/base_response/base_response.dart';
import 'package:flowery_driver/core/utils/error_handler.dart';
import 'package:flowery_driver/modules/auth/domain/entities/apply_body_entity.dart';
import 'package:flowery_driver/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:flowery_driver/modules/auth/domain/repositories/send_application_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplyUseCase {
  final SendApplicationContract contract;

  ApplyUseCase({required this.contract});

  Future<Result<ApplyResponseEntity>> apply(ApplyBodyEntity body) async {
    try {
      return await contract.sendApplication(body);
    } catch (e) {
      return Error<ApplyResponseEntity>(exception: ErrorHandler.handle(e));
    }
  }
}