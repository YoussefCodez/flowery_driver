import 'package:flowery_driver/config/base_response/base_response.dart';
import 'package:flowery_driver/modules/auth/domain/entities/apply_body_entity.dart';
import 'package:flowery_driver/modules/auth/domain/entities/apply_response_entity.dart';

abstract interface class SendApplicationContract {
  Future<Result<ApplyResponseEntity>> sendApplication(ApplyBodyEntity body);
}
