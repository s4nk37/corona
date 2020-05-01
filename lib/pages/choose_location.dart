import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List list = [
    "Flutter",
    "Angular",
    "Node js",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(

          color: const Color(0xFF4B4A50),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GFSearchBar(
              searchBoxInputDecoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: new OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                  ),
                ),
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 23.0,),
                hasFloatingPlaceholder: false,

              ),
              searchList: list,
              searchQueryBuilder: (query, list) {
                return list
                    .where((item) =>
                    item.toLowerCase().contains(query.toLowerCase()))
                    .toList();
              },
              overlaySearchListItemBuilder: (item) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
              onItemSelected: (item) {
                setState(() {
                  print('$item');
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0,vertical: 10,),
            child: Text('Current Location',style: TextStyle(color: Color(0xFFADB9CA),),),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 0.0),
            elevation: 1.0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45,vertical:15,),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'icons/flags/png/it.png',
                    package: 'country_icons',
                    height: 30,
                    width: 35,
                  ),
                  SizedBox(width:15,),
                  Expanded(child: Text('Italy')),
                  Icon(
                    Icons.check,
                    color: const Color(0xFFFA5252),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45.0,vertical: 10),
            child: Text('A',style: TextStyle(color: Color(0xFFADB9CA),),),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 0.0),
            elevation: 1.0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45,vertical:15,),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'icons/flags/png/af.png',
                    package: 'country_icons',
                    height: 30,
                    width: 35,
                  ),
                  SizedBox(width:15,),
                  Expanded(child: Text('Afghanistan')),
                ],
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 0.0),
            elevation: 1.0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45,vertical:15,),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'icons/flags/png/ar.png',
                    package: 'country_icons',
                    height: 30,
                    width: 35,
                  ),
                  SizedBox(width:15,),
                  Expanded(child: Text('Argentina')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


