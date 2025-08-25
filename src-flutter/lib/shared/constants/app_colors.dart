import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF3B82F6); // Blue-500
  static const Color primaryContainer = Color(0xFF1E3A8A); // Blue-800
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFFDBEAFE);
  
  // Secondary colors
  static const Color secondary = Color(0xFF8B5CF6); // Purple-500
  static const Color secondaryContainer = Color(0xFF5B21B6); // Purple-800
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFFEDE9FE);
  
  // Surface colors for dark theme
  static const Color surface = Color(0xFF111827); // Gray-900
  static const Color surfaceContainer = Color(0xFF1F2937); // Gray-800
  static const Color surfaceContainerHighest = Color(0xFF374151); // Gray-700
  static const Color onSurface = Color(0xFFF9FAFB); // Gray-50
  static const Color onSurfaceVariant = Color(0xFFD1D5DB); // Gray-300
  
  // Outline colors
  static const Color outline = Color(0xFF6B7280); // Gray-500
  static const Color outlineVariant = Color(0xFF4B5563); // Gray-600
  
  // Error colors
  static const Color error = Color(0xFFEF4444); // Red-500
  static const Color errorContainer = Color(0xFF7F1D1D); // Red-900
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFFFEE2E2);
  
  // Success colors
  static const Color success = Color(0xFF10B981); // Emerald-500
  static const Color successContainer = Color(0xFF064E3B); // Emerald-900
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color onSuccessContainer = Color(0xFFD1FAE5);
  
  // Warning colors
  static const Color warning = Color(0xFFF59E0B); // Amber-500
  static const Color warningContainer = Color(0xFF78350F); // Amber-900
  static const Color onWarning = Color(0xFF000000);
  static const Color onWarningContainer = Color(0xFFFEF3C7);
  
  // Window control colors (macOS style)
  static const Color windowClose = Color(0xFFFF5F56);
  static const Color windowMinimize = Color(0xFFFFBD2E);
  static const Color windowMaximize = Color(0xFF27CA3F);
  
  // Transparent variants
  static Color get surfaceWithOpacity => surface.withValues(alpha: 0.8);
  static Color get primaryWithOpacity => primary.withValues(alpha: 0.8);
  static Color get outlineWithOpacity => outline.withValues(alpha: 0.3);
}