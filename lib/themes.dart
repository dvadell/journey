import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF673AB7),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF673AB7),
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF673AB7),
      unselectedItemColor: Colors.grey,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple,
      titleTextStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 36),
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      unselectedLabelStyle: TextStyle(fontSize: 16),
    ),
  );
}

