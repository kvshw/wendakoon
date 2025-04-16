import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
      primary: Colors.indigo,
      secondary: Colors.indigoAccent,
      surface: Colors.grey.shade900,
      background: Colors.black,
    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade900,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.indigo,
      secondary: Colors.indigoAccent,
      surface: Colors.grey.shade100,
      background: Colors.white,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
