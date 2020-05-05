import 'package:corona/pages/choose_location.dart';
import 'package:flutter/material.dart';
import 'package:corona/pages/loading.dart';
import 'package:corona/pages/home.dart';
import 'package:corona/services/covid_data.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute: '/home',
  theme: ThemeData(
    fontFamily: 'Product Sans',
    primaryColor: const Color(0xFFFA5252),
  ),
  routes: {
     '/': (context) => Loading(),
    '/home': (context) => Home(),
//    '/location': (context) => ChooseLocation(),
  },

));
