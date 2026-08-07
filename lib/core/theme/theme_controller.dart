import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ThemeRepository {
  Future<ThemeMode> load();
  Future<void> save(ThemeMode mode);
}

class SharedPreferencesThemeRepository implements ThemeRepository {
  SharedPreferencesThemeRepository(this._preferences);

  static const _themeModeKey = 'theme_mode';
  final SharedPreferencesAsync _preferences;

  @override
  Future<ThemeMode> load() async {
    final value = await _preferences.getString(_themeModeKey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.system,
    );
  }

  @override
  Future<void> save(ThemeMode mode) {
    return _preferences.setString(_themeModeKey, mode.name);
  }
}

final themeRepositoryProvider = Provider<ThemeRepository>((ref) {
  return SharedPreferencesThemeRepository(SharedPreferencesAsync());
});

final themeControllerProvider =
    AsyncNotifierProvider<ThemeController, ThemeMode>(ThemeController.new);

class ThemeController extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() {
    return ref.watch(themeRepositoryProvider).load();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final previous = state;
    state = AsyncData(mode);
    try {
      await ref.read(themeRepositoryProvider).save(mode);
    } catch (error, stackTrace) {
      state = previous;
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
