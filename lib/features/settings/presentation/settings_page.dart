import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_semantic_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/page_layout.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeControllerProvider);
    final selectedMode = themeState.value ?? ThemeMode.system;

    return PageLayout(
      title: '外观设置',
      subtitle: '主题选择会持久化，重启应用后仍然生效。',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(context.spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('主题模式', style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: context.spacing.sm),
                  const Text(
                    'ColorScheme 负责 Material 角色色，业务状态色由 ThemeExtension 提供。',
                  ),
                  SizedBox(height: context.spacing.md),
                  SegmentedButton<ThemeMode>(
                    segments: const [
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: Icon(Icons.brightness_auto),
                        label: Text('跟随系统'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: Icon(Icons.light_mode),
                        label: Text('亮色'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: Icon(Icons.dark_mode),
                        label: Text('暗色'),
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
          Text('语义颜色', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: context.spacing.md),
          Wrap(
            spacing: context.spacing.md,
            runSpacing: context.spacing.md,
            children: [
              _ColorSample(
                label: '成功',
                color: context.semanticColors.success,
                foreground: context.semanticColors.onSuccess,
              ),
              _ColorSample(
                label: '警告',
                color: context.semanticColors.warning,
                foreground: context.semanticColors.onWarning,
              ),
              _ColorSample(
                label: '信息',
                color: context.semanticColors.info,
                foreground: context.semanticColors.onInfo,
              ),
              _ColorSample(
                label: '错误',
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
