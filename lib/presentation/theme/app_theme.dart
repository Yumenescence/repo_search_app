import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF1362F5),
  unselectedWidgetColor: const Color(0xFFBFBFBF),
  secondaryHeaderColor: const Color(0xFFF2F2F2),
  hoverColor: const Color(0xFFE5EDFF),
  highlightColor: const Color(0xFFF9F9F9),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      color: Color(0xFF211814),
      fontSize: 16,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      color: Color(0xFF211814),
      fontSize: 14,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w400,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFFF9F9F9),
    foregroundColor: const Color(0xFF211814),
    elevation: 3,
    shadowColor: Colors.grey[200]!.withOpacity(0.4),
    iconTheme: const IconThemeData(
      size: 24,
      color: Color(0xFF1362F5),
    ),
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Color(0xFF211814),
      fontSize: 16,
      fontFamily: 'Raleway',
      fontWeight: FontWeight.w600,
    ),
  ),
  cardTheme: CardTheme(
    color: const Color(0xFFF2F2F2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    shadowColor: Colors.transparent,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF2F2F2),
    focusColor: const Color(0xFFE5EDFF),
    hoverColor: const Color(0xFFE5EDFF),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent, width: 0),
      borderRadius: BorderRadius.circular(30.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF1362F5), width: 2.0),
      borderRadius: BorderRadius.circular(30.0),
    ),
  ),
);
