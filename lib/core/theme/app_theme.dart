import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String _headlineFont = 'Manrope';
  static const String _bodyFont = 'Manrope'; 

  static final ThemeData darkTheme = _buildTheme(Brightness.dark);
  static final ThemeData lightTheme = _buildTheme(Brightness.light); // Placeholder

  static ColorScheme _colorScheme(Brightness brightness) {
    if (brightness == Brightness.light) {
      // Very basic light theme placeholder, though the app is dark-first
      return ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      );
    }
    
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiary,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onSurface,
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Colors.white,
      onInverseSurface: Colors.black,
      inversePrimary: AppColors.primaryDim,
      surfaceTint: Colors.transparent,
      surfaceBright: AppColors.surfaceBright,
      surfaceDim: AppColors.surfaceDim,
      surfaceContainerLowest: AppColors.surfaceContainerLowest,
      surfaceContainerLow: AppColors.surfaceContainerLow,
      surfaceContainer: AppColors.surfaceContainer,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
      surfaceContainerHighest: AppColors.surfaceContainerHighest,
    );
  }

  static TextTheme _textTheme(ColorScheme scheme) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: _headlineFont,
        fontSize: 120,
        fontWeight: FontWeight.w800,
        letterSpacing: -120 * 0.02,
        color: scheme.onSurface,
        height: 1.0,
      ),
      headlineLarge: TextStyle(
        fontFamily: _headlineFont,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: -32 * 0.015,
        color: scheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontFamily: _headlineFont,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: 18 * 0.15,
        color: scheme.onSurfaceVariant,
      ),
      titleMedium: TextStyle(
        fontFamily: _bodyFont,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontFamily: _bodyFont,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: scheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontFamily: _bodyFont,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.6,
        color: scheme.onSurface,
      ),
      labelLarge: TextStyle(
        fontFamily: _bodyFont,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
      labelSmall: TextStyle(
        fontFamily: _bodyFont,
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.0,
        color: scheme.onSurfaceVariant,
      ),
    );
  }

  static ThemeData _buildTheme(Brightness brightness) {
    final scheme = _colorScheme(brightness);
    final textTheme = _textTheme(scheme);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.headlineMedium?.copyWith(
          fontSize: 14,
          color: AppColors.onSurfaceVariant,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: scheme.surface.withValues(alpha: 0.8),
        selectedItemColor: scheme.onSurface,
        unselectedItemColor: scheme.onSurfaceVariant,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: scheme.primary.withValues(alpha: 0.2),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: scheme.onSurfaceVariant.withValues(alpha: 0.4),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          textStyle: textTheme.headlineMedium?.copyWith(
            fontSize: 18,
            letterSpacing: 0,
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primary;
          }
          return scheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return scheme.primaryContainer;
          }
          return scheme.surfaceContainerHighest;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
    );
  }
}
