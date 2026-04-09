import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF210000);
  static const Color primaryVariant = Color(0xFF4A0404);
  static const Color background = Color(0xFFFCF9F3);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF1C1C18);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF5F5E5E);
  static const Color surfaceContainerLow = Color(0xFFF6F3ED);

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        surface: background,
        onSurface: onBackground,
        onPrimary: onPrimary,
        secondary: secondary,
      ),
      scaffoldBackgroundColor: background,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.notoSerif(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: onBackground,
        ),
        displayMedium: GoogleFonts.notoSerif(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: onBackground,
        ),
        headlineMedium: GoogleFonts.notoSerif(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: onBackground,
        ),
        titleLarge: GoogleFonts.manrope(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: onBackground,
        ),
        bodyLarge: GoogleFonts.manrope(
          fontSize: 16,
          color: onBackground,
        ),
        bodyMedium: GoogleFonts.manrope(
          fontSize: 14,
          color: secondary,
        ),
        labelLarge: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: secondary,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: onBackground),
      ),
    );
  }

  static BoxDecoration get burgundyGradient => const BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, primaryVariant],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
}
