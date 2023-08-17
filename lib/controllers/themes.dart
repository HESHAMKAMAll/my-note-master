import 'package:flutter/material.dart';
import 'package:my_notes/widgets/AppColors.dart';

class Themes {
  static ThemeData customDarkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(color: Colors.pink),
    // scaffoldBackgroundColor: Colors.teal,
    cardColor: Colors.black26,
    dialogBackgroundColor: Colors.pink,
  );

  static ThemeData customLightTheme = ThemeData.light().copyWith(

    appBarTheme: AppBarTheme(color: Color(0xFFFF6B6B)),
    scaffoldBackgroundColor: Color(0xFFFF6B6B),
    cardColor: Colors.grey[200],
    dialogBackgroundColor: Color(0xFFFF6B6B),
  );

}

