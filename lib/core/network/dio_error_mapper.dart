import 'package:dio/dio.dart';

import '../errors/app_exception.dart';

NetworkException mapDioException(DioException exception) {
  final message = switch (exception.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => '请求超时，请稍后重试',
    DioExceptionType.connectionError => '网络连接失败，请检查网络设置',
    DioExceptionType.badCertificate => '无法验证服务器安全证书',
    DioExceptionType.cancel => '请求已取消',
    DioExceptionType.badResponse => _responseMessage(exception.response),
    DioExceptionType.unknown => '网络请求失败，请稍后重试',
  };

  return NetworkException(message, cause: exception);
}

String _responseMessage(Response<dynamic>? response) {
  final statusCode = response?.statusCode;
  return switch (statusCode) {
    400 => '请求参数有误',
    401 => '登录状态已失效',
    403 => '没有权限执行此操作',
    404 => '请求的资源不存在',
    429 => '请求过于频繁，请稍后重试',
    != null && >= 500 => '服务器暂时不可用',
    _ => '网络请求失败${statusCode == null ? '' : '（$statusCode）'}',
  };
}
