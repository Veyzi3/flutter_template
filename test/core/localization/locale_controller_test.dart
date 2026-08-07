import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/localization/locale_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads and persists a locale selection', () async {
    final repository = _MemoryLocaleRepository(const Locale('zh'));
    final container = ProviderContainer(
      overrides: [localeRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    expect(
      await container.read(localeControllerProvider.future),
      const Locale('zh'),
    );

    await container
        .read(localeControllerProvider.notifier)
        .setLocale(const Locale('en'));

    expect(container.read(localeControllerProvider).value, const Locale('en'));
    expect(repository.locale, const Locale('en'));
  });

  test('null locale restores system language', () async {
    final repository = _MemoryLocaleRepository(const Locale('en'));
    final container = ProviderContainer(
      overrides: [localeRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    await container.read(localeControllerProvider.future);
    await container.read(localeControllerProvider.notifier).setLocale(null);

    expect(container.read(localeControllerProvider).value, isNull);
    expect(repository.locale, isNull);
  });
}

class _MemoryLocaleRepository implements LocaleRepository {
  _MemoryLocaleRepository(this.locale);

  Locale? locale;

  @override
  Future<Locale?> load() async => locale;

  @override
  Future<void> save(Locale? locale) async {
    this.locale = locale;
  }
}
