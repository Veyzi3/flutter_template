import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class LocaleRepository {
  Future<Locale?> load();
  Future<void> save(Locale? locale);
}

class SharedPreferencesLocaleRepository implements LocaleRepository {
  SharedPreferencesLocaleRepository(this._preferences);

  static const _localeKey = 'app_locale';
  final SharedPreferencesAsync _preferences;

  @override
  Future<Locale?> load() async {
    final languageCode = await _preferences.getString(_localeKey);
    return languageCode == null ? null : Locale(languageCode);
  }

  @override
  Future<void> save(Locale? locale) async {
    if (locale == null) {
      await _preferences.remove(_localeKey);
      return;
    }
    await _preferences.setString(_localeKey, locale.languageCode);
  }
}

final localeRepositoryProvider = Provider<LocaleRepository>((ref) {
  return SharedPreferencesLocaleRepository(SharedPreferencesAsync());
});

final localeControllerProvider =
    AsyncNotifierProvider<LocaleController, Locale?>(LocaleController.new);

class LocaleController extends AsyncNotifier<Locale?> {
  @override
  Future<Locale?> build() {
    return ref.watch(localeRepositoryProvider).load();
  }

  Future<void> setLocale(Locale? locale) async {
    final previous = state;
    state = AsyncData(locale);
    try {
      await ref.read(localeRepositoryProvider).save(locale);
    } catch (error, stackTrace) {
      state = previous;
      Error.throwWithStackTrace(error, stackTrace);
    }
  }
}
