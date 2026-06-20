import 'package:flowery_driver/config/base_response/base_response.dart';
import 'package:flowery_driver/modules/auth/data/datasources/apply_data_source.dart';
import 'package:flowery_driver/modules/auth/data/models/apply_response.dart';
import 'package:flowery_driver/modules/auth/data/models/driver.dart';
import 'package:flowery_driver/modules/auth/data/repositories/send_application_impl.dart';
import 'package:flowery_driver/modules/auth/domain/entities/apply_body_entity.dart';
import 'package:flowery_driver/modules/auth/domain/entities/apply_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:image_picker/image_picker.dart';

import 'send_application_impl_test.mocks.dart';


@GenerateMocks([ApplyDataSource])
void main() {
  late SendApplicationImpl repository;
  late MockApplyDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockApplyDataSource();
    repository = SendApplicationImpl(dataSource: mockDataSource);
  });

  final tApplyBodyEntity = ApplyBodyEntity(
    firstName: 'John',
    lastName: 'Doe',
    email: 'john@test.com',
    phone: '1234567890',
    password: 'password123',
    repassword: 'password123',
    gender: 'male',
    country: 'EG',
    vehicleType: 'Car',
    vehicleNumber: '123-ABC',
    vehicleLicense: XFile('test/dummy_license.jpg'),
    nid: '12345678901234',
    nidImg: XFile('test/dummy_nid.jpg'),
  );

  final tDriver = Driver(
    country: 'EG',
    firstName: 'John',
    lastName: 'Doe',
    vehicleType: 'Car',
    vehicleNumber: '123-ABC',
    vehicleLicense: 'dummy_url',
    nid: '12345678901234',
    nidImg: 'dummy_url',
    email: 'john@test.com',
    gender: 'male',
    phone: '1234567890',
    photo: 'dummy_url',
    role: 'driver',
    id: '1',
    createdAt: DateTime.now(),
  );

  final tApplyResponseSuccess = ApplyResponse(
    message: 'Success',
    driver: tDriver,
    token: 'dummy_token',
  );

  final tApplyResponseFailure = ApplyResponse(
    message: 'Failed',
    driver: tDriver,
    token: '',
  );

  group('sendApplication', () {
    test('should return Success when the data source returns a valid token', () async {
      when(mockDataSource.apply(
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        email: anyNamed('email'),
        phone: anyNamed('phone'),
        password: anyNamed('password'),
        gender: anyNamed('gender'),
        rePassword: anyNamed('rePassword'),
        country: anyNamed('country'),
        vehicleType: anyNamed('vehicleType'),
        vehicleNumber: anyNamed('vehicleNumber'),
        vehicleLicense: anyNamed('vehicleLicense'),
        nid: anyNamed('nid'),
        nidImg: anyNamed('nidImg'),
      )).thenAnswer((_) async => tApplyResponseSuccess);

      final result = await repository.sendApplication(tApplyBodyEntity);

      expect(result, isA<Success<ApplyResponseEntity>>());
      expect((result as Success<ApplyResponseEntity>).data, tApplyResponseSuccess.toEntity());
    });

    test('should return Error when the data source returns an empty token', () async {
      when(mockDataSource.apply(
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        email: anyNamed('email'),
        phone: anyNamed('phone'),
        password: anyNamed('password'),
        gender: anyNamed('gender'),
        rePassword: anyNamed('rePassword'),
        country: anyNamed('country'),
        vehicleType: anyNamed('vehicleType'),
        vehicleNumber: anyNamed('vehicleNumber'),
        vehicleLicense: anyNamed('vehicleLicense'),
        nid: anyNamed('nid'),
        nidImg: anyNamed('nidImg'),
      )).thenAnswer((_) async => tApplyResponseFailure);

      final result = await repository.sendApplication(tApplyBodyEntity);

      expect(result, isA<Error<ApplyResponseEntity>>());
      expect((result as Error<ApplyResponseEntity>).exception.toString(), contains(tApplyResponseFailure.message));
    });

    test('should return Error when data source throws exception', () async {
      when(mockDataSource.apply(
        firstName: anyNamed('firstName'),
        lastName: anyNamed('lastName'),
        email: anyNamed('email'),
        phone: anyNamed('phone'),
        password: anyNamed('password'),
        gender: anyNamed('gender'),
        rePassword: anyNamed('rePassword'),
        country: anyNamed('country'),
        vehicleType: anyNamed('vehicleType'),
        vehicleNumber: anyNamed('vehicleNumber'),
        vehicleLicense: anyNamed('vehicleLicense'),
        nid: anyNamed('nid'),
        nidImg: anyNamed('nidImg'),
      )).thenThrow(Exception('Server error'));

      final result = await repository.sendApplication(tApplyBodyEntity);

      expect(result, isA<Error<ApplyResponseEntity>>());
    });
  });
}
