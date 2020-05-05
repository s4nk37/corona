import 'package:corona/pages/choose_location.dart';
import 'package:corona/pages/country.dart';
import 'package:flutter/material.dart';
import 'package:corona/pages/home.dart';
import 'package:corona/pages/country.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/home',
  theme: ThemeData(
    fontFamily: 'Product Sans',
    primaryColor: const Color(0xFFFA5252),
    brightness: Brightness.light,
  ),
  routes: {
    // '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation(),
    '/countrywise': (context) => CountryWiseData(),
  },

));
