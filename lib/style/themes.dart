import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'colors.dart';

ThemeData darkTheme =ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  appBarTheme:   AppBarTheme(
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: HexColor('333739'),

    ),
    backgroundColor: HexColor('333739'),
    titleTextStyle:  const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),

    elevation: 0.0,
    iconTheme:   const IconThemeData(
      color: Colors.white,

    ),

  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
    unselectedItemColor: Colors.grey,

    backgroundColor: HexColor('333739'),

  ),
  textTheme:   const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.white,

    ),

  ),
  fontFamily: 'Jannah',



);

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,

  scaffoldBackgroundColor: Colors.white,
  appBarTheme:   const AppBarTheme(
    titleSpacing: 20.0,

    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,

    ),
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),

    elevation: 0.0,
    iconTheme:  IconThemeData(
      color: Colors.black,

    ),

  ),
  bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,

    selectedLabelStyle: TextStyle(

    ),

  ),
  textTheme:  const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black,
    ),

  ),
  fontFamily: 'Jannah',


);