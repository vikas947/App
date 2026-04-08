import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_tokens.dart';

class AppTheme {
  static final ThemeData lightTheme = _baseTheme(Brightness.light);
  static final ThemeData darkTheme = _baseTheme(Brightness.dark);

  static ThemeData _baseTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: isDark ? const Color(0xFF8AB4FF) : const Color(0xFF1D4ED8),
    );

    final tokens = AppThemeTokens(
      surface: isDark ? const Color(0xFF15181C) : const Color(0xFFF7F9FC),
      surfaceVariant: isDark ? const Color(0xFF1E232B) : Colors.white,
      primary: colorScheme.primary,
      secondary: isDark ? const Color(0xFF34D399) : const Color(0xFF059669),
      onSurface: isDark ? const Color(0xFFF3F4F6) : const Color(0xFF0F172A),
      onSurfaceMuted: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF64748B),
      success: isDark ? const Color(0xFF4ADE80) : const Color(0xFF16A34A),
    );

    final textTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: tokens.surface,
      textTheme: textTheme.copyWith(
        headlineMedium: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
        titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        bodyMedium: textTheme.bodyMedium?.copyWith(height: 1.4),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: tokens.surfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: tokens.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.4),
        ),
      ),
      extensions: [tokens],
    );
  }
}
