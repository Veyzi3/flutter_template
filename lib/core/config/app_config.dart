enum AppFlavor { development, staging, production }

final class AppConfig {
  const AppConfig({
    required this.apiBaseUrl,
    required this.flavor,
    required this.enableNetworkLogs,
  });

  factory AppConfig.fromEnvironment() {
    const apiBaseUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.example.com',
    );
    const flavorValue = String.fromEnvironment(
      'APP_FLAVOR',
      defaultValue: 'development',
    );
    const enableNetworkLogs = bool.fromEnvironment(
      'ENABLE_NETWORK_LOGS',
      defaultValue: false,
    );

    return AppConfig(
      apiBaseUrl: Uri.parse(apiBaseUrl),
      flavor: AppFlavor.values.firstWhere(
        (flavor) => flavor.name == flavorValue,
        orElse: () => throw ArgumentError.value(
          flavorValue,
          'APP_FLAVOR',
          'Use development, staging, or production.',
        ),
      ),
      enableNetworkLogs: enableNetworkLogs,
    )..validate();
  }

  final Uri apiBaseUrl;
  final AppFlavor flavor;
  final bool enableNetworkLogs;

  void validate() {
    if (!apiBaseUrl.hasScheme || !apiBaseUrl.hasAuthority) {
      throw ArgumentError.value(
        apiBaseUrl,
        'API_BASE_URL',
        'Must be an absolute URL.',
      );
    }
    if (flavor == AppFlavor.production &&
        apiBaseUrl.host == 'api.example.com') {
      throw StateError(
        'API_BASE_URL must be configured for production builds.',
      );
    }
  }
}
