import 'package:flutter/material.dart';

import 'app_semantic_colors.dart';
import 'app_spacing.dart';

abstract final class AppTheme {
  static const _seed = Color(0xFF0B6B5D);

  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final base = ColorScheme.fromSeed(seedColor: _seed, brightness: brightness);
    final colors = base.copyWith(
      secondary: isDark ? const Color(0xFFFFB59F) : const Color(0xFF9A452E),
      tertiary: isDark ? const Color(0xFFB8C8FF) : const Color(0xFF415A9B),
      surface: isDark ? const Color(0xFF111817) : const Color(0xFFF7FAF8),
    );
    final semantic = AppSemanticColors(
      success: isDark ? const Color(0xFF75D7A5) : const Color(0xFF16794B),
      onSuccess: isDark ? const Color(0xFF003922) : Colors.white,
      warning: isDark ? const Color(0xFFFFCA6A) : const Color(0xFF8A5700),
      onWarning: isDark ? const Color(0xFF452B00) : Colors.white,
      info: isDark ? const Color(0xFFADC6FF) : const Color(0xFF345A9C),
      onInfo: isDark ? const Color(0xFF002E69) : Colors.white,
      border: isDark ? const Color(0xFF3D4946) : const Color(0xFFD8E1DE),
    );

    final textTheme = ThemeData(brightness: brightness).textTheme.copyWith(
      headlineSmall: const TextStyle(fontWeight: FontWeight.w700),
      titleLarge: const TextStyle(fontWeight: FontWeight.w700),
      titleMedium: const TextStyle(fontWeight: FontWeight.w600),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colors,
      textTheme: textTheme,
      scaffoldBackgroundColor: colors.surface,
      extensions: [semantic, const AppSpacing()],
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: colors.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: semantic.border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surfaceContainerLowest,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: semantic.border),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        elevation: 0,
        backgroundColor: colors.surfaceContainerLow,
        indicatorColor: colors.secondaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colors.surfaceContainerLow,
        indicatorColor: colors.secondaryContainer,
        useIndicator: true,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      dividerTheme: DividerThemeData(color: semantic.border, thickness: 1),
    );
  }
}
