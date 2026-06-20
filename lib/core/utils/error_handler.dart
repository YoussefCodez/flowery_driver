import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class ErrorHandler {
  static Exception handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is Exception) {
      return error;
    } else {
      return ServerException(
        'An unexpected error occurred: ${error.toString()}',
      );
    }
  }

  static Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerException('Connection timeout. Please try again later.');
      case DioExceptionType.badResponse:
        final response = error.response;
        final statusCode = response?.statusCode;
        String errorMessage =
            'Received invalid response from server ($statusCode).';
        if (response?.data != null && response?.data is Map) {
          final data = response!.data as Map;
          errorMessage = data['message'] ?? data['error'] ?? errorMessage;
        }
        return ServerException(errorMessage, statusCode: statusCode);
      case DioExceptionType.cancel:
        return ServerException('Request to server was cancelled.');
      case DioExceptionType.connectionError:
        return ServerException(
          'No internet connection. Please check your network status.',
        );
      case DioExceptionType.badCertificate:
        return ServerException('SSL Certificate validation failed.');
      case DioExceptionType.unknown:
        return ServerException('An unexpected network error occurred.');
    }
  }
}
