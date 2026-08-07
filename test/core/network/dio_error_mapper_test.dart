import 'package:dio/dio.dart';
import 'package:flutter_template/core/network/dio_error_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps timeout errors to a user-facing failure', () {
    final exception = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionTimeout,
    );

    expect(mapDioException(exception).message, '请求超时，请稍后重试');
  });

  test('maps unauthorized responses', () {
    final options = RequestOptions();
    final exception = DioException.badResponse(
      statusCode: 401,
      requestOptions: options,
      response: Response<void>(requestOptions: options, statusCode: 401),
    );

    expect(mapDioException(exception).message, '登录状态已失效');
  });
}
