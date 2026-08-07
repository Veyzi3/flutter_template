import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/locale_controller.dart';
import '../../../core/theme/app_semantic_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/page_layout.dart';
import '../../../l10n/l10n.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeControllerProvider);
    final selectedMode = themeState.value ?? ThemeMode.system;
    final localeState = ref.watch(localeControllerProvider);
    final selectedLanguage = localeState.value?.languageCode ?? 'system';

    return PageLayout(
      title: context.l10n.settingsTitle,
      subtitle: context.l10n.settingsSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(context.spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.themeMode,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: context.spacing.sm),
                  Text(context.l10n.themeSectionDescription),
                  SizedBox(height: context.spacing.md),
                  SegmentedButton<ThemeMode>(
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: const Icon(Icons.brightness_auto),
                        label: Text(context.l10n.systemTheme),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: const Icon(Icons.light_mode),
                        label: Text(context.l10n.lightTheme),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: const Icon(Icons.dark_mode),
                        label: Text(context.l10n.darkTheme),
                      ),
                    ],
                    selected: {selectedMode},
                    onSelectionChanged: themeState.isLoading
                        ? null
                        : (selection) => ref
                              .read(themeControllerProvider.notifier)
                              .setThemeMode(selection.first),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.spacing.lg),
          Card(
            child: Padding(
              padding: EdgeInsets.all(context.spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.language,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: context.spacing.sm),
                  Text(context.l10n.languageDescription),
                  SizedBox(height: context.spacing.md),
                  SegmentedButton<String>(
                    segments: [
                      ButtonSegment(
                        value: 'system',
                        icon: const Icon(Icons.language),
                        label: Text(context.l10n.systemLanguage),
                      ),
                      ButtonSegment(
                        value: 'zh',
                        label: Text(context.l10n.chinese),
                      ),
                      ButtonSegment(
                        value: 'en',
                        label: Text(context.l10n.english),
                      ),
                    ],
                    selected: {selectedLanguage},
                    onSelectionChanged: localeState.isLoading
                        ? null
                        : (selection) async {
                            final languageCode = selection.first;
                            await ref
                                .read(localeControllerProvider.notifier)
                                .setLocale(
                                  languageCode == 'system'
                                      ? null
                                      : Locale(languageCode),
                                );
                          },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.spacing.lg),
          Text(
            context.l10n.semanticColors,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: context.spacing.md),
          Wrap(
            spacing: context.spacing.md,
            runSpacing: context.spacing.md,
            children: [
              _ColorSample(
                label: context.l10n.success,
                color: context.semanticColors.success,
                foreground: context.semanticColors.onSuccess,
              ),
              _ColorSample(
                label: context.l10n.warning,
                color: context.semanticColors.warning,
                foreground: context.semanticColors.onWarning,
              ),
              _ColorSample(
                label: context.l10n.info,
                color: context.semanticColors.info,
                foreground: context.semanticColors.onInfo,
              ),
              _ColorSample(
                label: context.l10n.error,
                color: Theme.of(context).colorScheme.error,
                foreground: Theme.of(context).colorScheme.onError,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorSample extends StatelessWidget {
  const _ColorSample({
    required this.label,
    required this.color,
    required this.foreground,
  });

  final String label;
  final Color color;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 132,
      height: 72,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(color: foreground),
      ),
    );
  }
}
