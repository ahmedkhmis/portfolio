import 'package:flutter/material.dart';
import 'package:app/core/theme/app_colors.dart';

/// Provides `ThemeData` instances for dark and light modes.
class AppTheme {
  AppTheme._();

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Ubuntu',
      scaffoldBackgroundColor: AppColors.darkPrimary,
      primaryColor: AppColors.accent,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.accentLight,
        surface: AppColors.darkSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.darkTextPrimary,
      ),
      cardColor: AppColors.darkCard,
      dividerColor: AppColors.darkDivider,
      iconTheme: const IconThemeData(color: AppColors.darkTextSecondary),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 48.0,
          fontWeight: FontWeight.w800,
          color: AppColors.darkTextPrimary,
          letterSpacing: 2.0,
        ),
        displayMedium: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.w700,
          color: AppColors.darkTextPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
          letterSpacing: 1.2,
        ),
        titleLarge: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextSecondary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          color: AppColors.darkTextSecondary,
          height: 1.7,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          color: AppColors.darkTextMuted,
          height: 1.6,
        ),
        labelLarge: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: AppColors.accent,
          letterSpacing: 1.1,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Ubuntu',
      scaffoldBackgroundColor: AppColors.lightPrimary,
      primaryColor: AppColors.accent,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        secondary: AppColors.accentLight,
        surface: AppColors.lightSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightTextPrimary,
      ),
      cardColor: AppColors.lightCard,
      dividerColor: AppColors.lightDivider,
      iconTheme: const IconThemeData(color: AppColors.lightTextSecondary),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 48.0,
          fontWeight: FontWeight.w800,
          color: AppColors.lightTextPrimary,
          letterSpacing: 2.0,
        ),
        displayMedium: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.w700,
          color: AppColors.lightTextPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextPrimary,
          letterSpacing: 1.2,
        ),
        titleLarge: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: AppColors.lightTextSecondary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          color: AppColors.lightTextSecondary,
          height: 1.7,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          color: AppColors.lightTextMuted,
          height: 1.6,
        ),
        labelLarge: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          color: AppColors.accent,
          letterSpacing: 1.1,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
