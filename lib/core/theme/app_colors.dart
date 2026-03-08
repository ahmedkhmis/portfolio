import 'package:flutter/material.dart';

/// Centralized color palette for the portfolio.
/// Uses the existing dark palette as baseline and adds a complementary light palette.
class AppColors {
  AppColors._();

  // ─── Brand / Accent ───────────────────────────────────────────────
  static const Color accent = Color(0xFF6C63FF); // Vibrant purple-blue
  static const Color accentLight = Color(0xFF8B83FF);
  static const Color accentDark = Color(0xFF4F46E5);

  // ─── Dark Theme ───────────────────────────────────────────────────
  static const Color darkPrimary = Color(0xFF0F0F1A);
  static const Color darkSurface = Color(0xFF1A1A2E);
  static const Color darkCard = Color(0xFF222240);
  static const Color darkDivider = Color(0xFF2E2E4A);
  static const Color darkTextPrimary = Color(0xFFF0F0F5);
  static const Color darkTextSecondary = Color(0xFFB0B0C8);
  static const Color darkTextMuted = Color(0xFF6E6E8A);

  // ─── Light Theme ──────────────────────────────────────────────────
  static const Color lightPrimary = Color(0xFFF5F5FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF0EFF5);
  static const Color lightDivider = Color(0xFFE0E0EA);
  static const Color lightTextPrimary = Color(0xFF1A1A2E);
  static const Color lightTextSecondary = Color(0xFF4A4A6A);
  static const Color lightTextMuted = Color(0xFF8A8AAA);

  // ─── Gradients ────────────────────────────────────────────────────
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, Color(0xFF9D4EDD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [darkPrimary, darkSurface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [
      Color(0xFF2A2A4A),
      Color(0xFF3A3A5A),
      Color(0xFF2A2A4A),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient shimmerGradientLight = LinearGradient(
    colors: [
      Color(0xFFE8E8F0),
      Color(0xFFF0F0F8),
      Color(0xFFE8E8F0),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
