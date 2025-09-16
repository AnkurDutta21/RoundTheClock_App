import 'package:flutter/material.dart';

/// Design tokens for consistent spacing, typography, and colors throughout the app
class DesignTokens {
  // Spacing tokens
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // Border radius tokens
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusXxl = 24.0;

  // Typography scale
  static const double fontSizeXs = 12.0;
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 16.0;
  static const double fontSizeLg = 18.0;
  static const double fontSizeXl = 20.0;
  static const double fontSizeXxl = 24.0;
  static const double fontSizeXxxl = 28.0;
  static const double fontSizeHuge = 32.0;

  // Font weights
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;

  // Animation durations
  static const Duration animationDurationFast = Duration(milliseconds: 150);
  static const Duration animationDurationNormal = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);

  // Elevation values
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;
  static const double elevationXl = 16.0;

  // Opacity values
  static const double opacityLow = 0.1;
  static const double opacityMedium = 0.2;
  static const double opacityHigh = 0.3;
  static const double opacityOverlay = 0.7;

  // Gradient definitions
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF6B35), // Orange
      Color(0xFFFF8A65), // Light orange
    ],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF8B0000), // Dark red
      Color(0xFFB71C1C), // Red
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white, Color(0xFFF8F9FA)],
  );

  // Shadow definitions
  static const BoxShadow shadowSm = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 4,
    offset: Offset(0, 2),
  );

  static const BoxShadow shadowMd = BoxShadow(
    color: Color(0x1F000000),
    blurRadius: 8,
    offset: Offset(0, 4),
  );

  static const BoxShadow shadowLg = BoxShadow(
    color: Color(0x29000000),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  // Accessibility constants
  static const double minTouchTarget = 44.0; // Minimum touch target size
  static const double focusBorderWidth = 2.0;

  // Color contrast helpers
  static Color getAccessibleTextColor(Color backgroundColor) {
    // Simple luminance calculation for contrast
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  // High contrast color palette for accessibility
  static const Color highContrastText = Color(0xFF000000); // Pure black
  static const Color highContrastBackground = Color(0xFFFFFFFF); // Pure white
  static const Color highContrastPrimary = Color(
    0xFF0000FF,
  ); // Blue for links/buttons
  static const Color highContrastSecondary = Color(
    0xFF008000,
  ); // Green for accents

  // Ensure minimum contrast ratios (WCAG AA standard: 4.5:1 for normal text, 3:1 for large text)
  static bool hasMinimumContrast(Color foreground, Color background) {
    final luminance1 = foreground.computeLuminance();
    final luminance2 = background.computeLuminance();
    final contrast = (luminance1 > luminance2)
        ? (luminance1 + 0.05) / (luminance2 + 0.05)
        : (luminance2 + 0.05) / (luminance1 + 0.05);
    return contrast >= 4.5; // WCAG AA standard
  }

  // Get accessible color combinations
  static Color getAccessibleForeground(Color background) {
    final whiteContrast = _calculateContrast(Colors.white, background);
    final blackContrast = _calculateContrast(Colors.black, background);

    if (whiteContrast >= 4.5) return Colors.white;
    if (blackContrast >= 4.5) return Colors.black;

    // If neither has sufficient contrast, return the better one
    return whiteContrast > blackContrast ? Colors.white : Colors.black;
  }

  static double _calculateContrast(Color color1, Color color2) {
    final luminance1 = color1.computeLuminance();
    final luminance2 = color2.computeLuminance();
    final brighter = luminance1 > luminance2 ? luminance1 : luminance2;
    final darker = luminance1 > luminance2 ? luminance2 : luminance1;
    return (brighter + 0.05) / (darker + 0.05);
  }

  // Typography styles using tokens
  static TextStyle get headlineLarge => TextStyle(
    fontSize: fontSizeHuge,
    fontWeight: fontWeightBold,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle get headlineMedium => TextStyle(
    fontSize: fontSizeXxxl,
    fontWeight: fontWeightSemiBold,
    letterSpacing: -0.25,
    height: 1.3,
  );

  static TextStyle get titleLarge => TextStyle(
    fontSize: fontSizeXl,
    fontWeight: fontWeightMedium,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle get bodyLarge => TextStyle(
    fontSize: fontSizeMd,
    fontWeight: fontWeightRegular,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: fontSizeSm,
    fontWeight: fontWeightRegular,
    letterSpacing: 0.25,
    height: 1.4,
  );

  static TextStyle get labelLarge => TextStyle(
    fontSize: fontSizeSm,
    fontWeight: fontWeightMedium,
    letterSpacing: 0.1,
    height: 1.4,
  );
}
