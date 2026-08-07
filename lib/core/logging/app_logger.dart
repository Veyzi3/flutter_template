import 'dart:developer' as developer;

abstract interface class AppLogger {
  void debug(String message, {String name = 'app'});

  void error(
    String message, {
    String name = 'app',
    Object? error,
    StackTrace? stackTrace,
  });
}

final class DeveloperAppLogger implements AppLogger {
  const DeveloperAppLogger();

  @override
  void debug(String message, {String name = 'app'}) {
    developer.log(message, name: name);
  }

  @override
  void error(
    String message, {
    String name = 'app',
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
