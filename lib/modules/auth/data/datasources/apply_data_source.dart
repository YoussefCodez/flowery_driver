import 'package:dio/dio.dart';
import 'package:flowery_driver/config/api/app_endpoints.dart';
import 'package:flowery_driver/modules/auth/data/models/apply_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'apply_data_source.g.dart';

@LazySingleton()
@RestApi(baseUrl: AppEndPoints.baseUrl)
abstract class ApplyDataSource {
  @factoryMethod
  factory ApplyDataSource(Dio dio) = _ApplyDataSource;

  @POST(AppEndPoints.apply)
  @MultiPart()
  Future<ApplyResponse> apply({
    @Part(name: 'firstName') required String firstName,
    @Part(name: 'lastName') required String lastName,
    @Part(name: 'email') required String email,
    @Part(name: 'phone') required String phone,
    @Part(name: 'password') required String password,
    @Part(name: 'gender') required String gender,
    @Part(name: 'country') required String country,
    @Part(name: 'vehicleType') required String vehicleType,
    @Part(name: 'vehicleNumber') required String vehicleNumber,
    @Part(name: 'vehicleLicense') required MultipartFile vehicleLicense,
    @Part(name: 'NID') required String nid,
    @Part(name: 'NIDImg') required MultipartFile nidImg,
    @Part(name: 'rePassword') required String rePassword,
  });
}