import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopapp/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.black12,
    unselectedItemColor: Colors.white,
    selectedItemColor: Colors.deepOrange,
    elevation: 20.0,),
  scaffoldBackgroundColor: Colors.blueGrey,

  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.blueGrey,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.blueGrey,
    elevation: 0.0,
  ),
  textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.w600),),
);

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.w600),),
  primarySwatch: defaultColor,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    elevation: 20.0,),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,

    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
);
