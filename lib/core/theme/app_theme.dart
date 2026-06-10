import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFAFAF8),
      fontFamily: 'Inter',
      
      // Menggunakan aturan pewarnaan dasar ThemeData yang benar
      primaryColor: const Color(0xFF0D2F24),
      
      // Konfigurasi TextTheme yang aman tanpa bentrok parameter
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'AppleNewYork',
          fontWeight: FontWeight.w400,
          color: Color(0xFF0D2F24),
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Inter',
          color: Color(0xFF0D2F24),
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Inter',
          color: Color(0xFF626262),
        ),
      ),
    );
  }
}