import 'package:flowery_driver/core/utils/error_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:flowery_driver/config/base_response/base_response.dart';
import 'package:flowery_driver/modules/auth/domain/entities/apply_body_entity.dart';
import 'package:flowery_driver/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:flowery_driver/modules/auth/domain/repositories/send_application_contract.dart';
import 'package:flowery_driver/modules/auth/data/models/apply_body.dart';
import 'package:flowery_driver/modules/auth/data/datasources/apply_data_source.dart';

@LazySingleton(as: SendApplicationContract)
class SendApplicationImpl implements SendApplicationContract {
  final ApplyDataSource dataSource;

  SendApplicationImpl({required this.dataSource});

  @override
  Future<Result<ApplyResponseEntity>> sendApplication(
    ApplyBodyEntity body,
  ) async {
    try {
      final applyBody = ApplyBody.fromEntity(body);
      final result = await dataSource.apply(
        firstName: applyBody.firstName,
        lastName: applyBody.lastName,
        email: applyBody.email,
        phone: applyBody.phone,
        password: applyBody.password,
        gender: applyBody.gender,
        rePassword: applyBody.repassword,
        country: applyBody.country,
        vehicleType: applyBody.vehicleType,
        vehicleNumber: applyBody.vehicleNumber,
        vehicleLicense: await applyBody.toLicenseFile(),
        nid: applyBody.nid,
        nidImg: await applyBody.toNidImgFile(),
      );
      if (result.token.isNotEmpty) {
        return Success<ApplyResponseEntity>(data: result.toEntity());
      } else {
        return Error<ApplyResponseEntity>(exception: ServerException(result.message));
      }
    } catch (e) {
      return Error<ApplyResponseEntity>(exception: ErrorHandler.handle(e));
    }
  }
}
