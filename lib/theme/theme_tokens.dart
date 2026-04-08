import 'package:flutter/material.dart';

class AppSpacing {
  static const double xs = 8;
  static const double sm = 16;
  static const double md = 24;
  static const double lg = 32;
}

@immutable
class AppThemeTokens extends ThemeExtension<AppThemeTokens> {
  const AppThemeTokens({
    required this.surface,
    required this.surfaceVariant,
    required this.primary,
    required this.secondary,
    required this.onSurface,
    required this.onSurfaceMuted,
    required this.success,
  });

  final Color surface;
  final Color surfaceVariant;
  final Color primary;
  final Color secondary;
  final Color onSurface;
  final Color onSurfaceMuted;
  final Color success;

  @override
  ThemeExtension<AppThemeTokens> copyWith({
    Color? surface,
    Color? surfaceVariant,
    Color? primary,
    Color? secondary,
    Color? onSurface,
    Color? onSurfaceMuted,
    Color? success,
  }) {
    return AppThemeTokens(
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceMuted: onSurfaceMuted ?? this.onSurfaceMuted,
      success: success ?? this.success,
    );
  }

  @override
  ThemeExtension<AppThemeTokens> lerp(
    covariant ThemeExtension<AppThemeTokens>? other,
    double t,
  ) {
    if (other is! AppThemeTokens) return this;
    return AppThemeTokens(
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t) ?? surfaceVariant,
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      onSurface: Color.lerp(onSurface, other.onSurface, t) ?? onSurface,
      onSurfaceMuted: Color.lerp(onSurfaceMuted, other.onSurfaceMuted, t) ?? onSurfaceMuted,
      success: Color.lerp(success, other.success, t) ?? success,
    );
  }
}
