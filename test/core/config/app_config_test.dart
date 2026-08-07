import 'package:flutter_template/core/config/app_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('accepts an absolute API URL', () {
    final config = AppConfig(
      apiBaseUrl: Uri.parse('https://api.test.dev'),
      flavor: AppFlavor.staging,
      enableNetworkLogs: true,
    );

    expect(config.validate, returnsNormally);
  });

  test('rejects a relative API URL', () {
    final config = AppConfig(
      apiBaseUrl: Uri.parse('/api'),
      flavor: AppFlavor.development,
      enableNetworkLogs: false,
    );

    expect(config.validate, throwsArgumentError);
  });

  test('rejects the placeholder URL in production', () {
    final config = AppConfig(
      apiBaseUrl: Uri.parse('https://api.example.com'),
      flavor: AppFlavor.production,
      enableNetworkLogs: false,
    );

    expect(config.validate, throwsStateError);
  });
}
