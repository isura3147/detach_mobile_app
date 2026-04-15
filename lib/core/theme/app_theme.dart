import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String _fontFamily = 'Manrope';
  static const double _radius = 4;

  static final ThemeData darkTheme = _buildTheme(Brightness.dark);
  static final ThemeData lightTheme = _buildTheme(Brightness.light);

  // —— Color ——————————————————————————————————————————————————————
  static ColorScheme _colorScheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final background =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final onSurface =
        isDark ? AppColors.darkPrimaryText : AppColors.lightPrimaryText;
    final primary =
        isDark ? AppColors.primaryButtonDark : AppColors.primaryButtonLight;
    final onPrimary =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;

    return ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: brightness,
    ).copyWith(
      surfaceTint: Colors.transparent,
      surfaceDim: isDark ? background : surface,
      surfaceBright: isDark ? surface : background,
      surfaceContainerLowest: background,
      surfaceContainerLow: background,
      surface: surface,
      surfaceContainer: surface,
      surfaceContainerHigh: surface,
      surfaceContainerHighest: surface,
      primary: primary,
      onPrimary: onPrimary,
      error: AppColors.alert,
      onError: const Color(0xFFFFFFFF),
      onSurface: onSurface,
      onSurfaceVariant: isDark
          ? AppColors.darkSecondaryText
          : AppColors.lightSecondaryText,
    );
  }

  // —— Typography (tracking = % of font size, per spec) ——————————————

  static double _trackingPx(double fontSize, double percent) =>
      fontSize * percent / 100;

  static TextStyle _type({
    required double size,
    required FontWeight weight,
    double trackingPercent = 0,
    Color? color,
    double? height,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: _trackingPx(size, trackingPercent),
      color: color,
    );
  }

  /// Maps design roles to Material 3 [TextTheme] slots (Manrope + spec sizes/weights).
  static TextTheme _textTheme(ColorScheme scheme) {
    final onSurface = scheme.onSurface;
    final onVariant = scheme.onSurfaceVariant;

    final material = Typography.material2021(colorScheme: scheme);
    final base = scheme.brightness == Brightness.light
        ? material.black
        : material.white;

    return base.apply(fontFamily: _fontFamily).copyWith(
          // Hero Timer → displayLarge
          displayLarge: _type(
            size: 120,
            weight: FontWeight.w800,
            trackingPercent: -2,
            color: onSurface,
            height: 1.05,
          ),
          // Screen Headlines → headlineLarge
          headlineLarge: _type(
            size: 32,
            weight: FontWeight.w700,
            trackingPercent: -1.5,
            color: onSurface,
            height: 1.2,
          ),
          // Section Headers (UPPERCASE in UI) → titleSmall
          titleSmall: _type(
            size: 12,
            weight: FontWeight.w800,
            trackingPercent: 5,
            color: onSurface,
            height: 1.2,
          ),
          // List Item Title → titleMedium
          titleMedium: _type(
            size: 18,
            weight: FontWeight.w600,
            trackingPercent: -1,
            color: onSurface,
            height: 1.25,
          ),
          // Body / Labels → bodyMedium
          bodyMedium: _type(
            size: 14,
            weight: FontWeight.w500,
            color: onSurface,
            height: 1.4,
          ),
          // Caption / Small → bodySmall
          bodySmall: _type(
            size: 12,
            weight: FontWeight.w500,
            color: onVariant,
            height: 1.35,
          ),
          // Nav Labels (UPPERCASE in bar theme) → labelSmall
          labelSmall: _type(
            size: 10,
            weight: FontWeight.w600,
            trackingPercent: 5,
            color: onVariant,
            height: 1.2,
          ),
        );
  }

  // —— Shape ————————————————————————————————————————————————————————

  static RoundedRectangleBorder get _roundedRectShape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius));

  // —— Full theme ————————————————————————————————————————————————————

  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = _colorScheme(brightness);
    final textTheme = _textTheme(colorScheme);
    final isDark = brightness == Brightness.dark;
    final borderColor =
        isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final scaffoldBackground = colorScheme.surfaceContainerLowest;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      fontFamily: _fontFamily,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      dividerTheme: DividerThemeData(
        color: borderColor,
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainer,
        elevation: 0,
        shape: _roundedRectShape,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleMedium,
      ),
      navigationBarTheme: _navigationBarTheme(colorScheme, textTheme, isDark),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(shape: _roundedRectShape),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colorScheme.primary),
          shape: _roundedRectShape,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surfaceContainerHigh,
        elevation: 0,
        shape: _roundedRectShape,
        titleTextStyle: textTheme.headlineSmall,
        contentTextStyle: textTheme.bodyMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surfaceContainerHigh,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(_radius)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: colorScheme.secondary, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_radius),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
    );
  }

  static NavigationBarThemeData _navigationBarTheme(
    ColorScheme scheme,
    TextTheme textTheme,
    bool isDark,
  ) {
    final inactiveColor = isDark ? AppColors.darkTertiary : AppColors.lightTertiary;
    final navLabel = textTheme.labelSmall!.copyWith(
      color: scheme.onSurface,
      letterSpacing: _trackingPx(10, 5),
    );

    return NavigationBarThemeData(
      height: 64,
      elevation: 0,
      backgroundColor: scheme.surface,
      indicatorColor: AppColors.accent.withValues(alpha: 0.24),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return navLabel;
        }
        return navLabel.copyWith(color: inactiveColor);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: scheme.onSurface, size: 24);
        }
        return IconThemeData(color: inactiveColor, size: 24);
      }),
    );
  }
}
