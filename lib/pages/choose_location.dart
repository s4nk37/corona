import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:corona/pages/loading.dart';

class ChooseLocation extends StatefulWidget {
  final List receivedData;

  ChooseLocation(this.receivedData);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List list = [""];
  List alphabets = [];
  String selectedCountry = "myCountry111";

  void initState() {
    super.initState();
  }

  void demoFun(String countryName) {
    print(countryName + " Clicked!");
  }

  List<Widget> contentWidgets = [
    new Container(
      alignment: Alignment.center,
      color: const Color(0xFFf2f6f8),
//         backgroundColor: const Color(0xFFf2f6f8),
      child: Center(
        child: SpinKitDoubleBounce(
          color: const Color(0xFFFA5252),
          size: 100.0,
        ),
      ),
    ),
  ];

//  List _createDynamicList() {
  void _createDynamicList() {
    //TODO: Turn on loading bar here

//    setState(() {
    List countriesData = widget.receivedData;
    int totalCountries = countriesData.length;
    print("total data:::" + countriesData.length.toString());
    list = [];
    for (int i = 0; i < totalCountries; i++) {
      list.add(countriesData[i]['Country']);

      // find set of letter groups available with us from API data
      String alpha;
      alpha = countriesData[i]['Country'].toString()[0];
      if (alphabets.indexOf(alpha) == -1) {
        alphabets.add(alpha);
      }
    }

    print("alphabets:::" + alphabets.toString());
//    });

    List<Widget> myWidgets = [];

    //Add search bar widget
    myWidgets.add(new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: new GFSearchBar(
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
          contentPadding: EdgeInsets.symmetric(
            vertical: 23.0,
          ),
          hasFloatingPlaceholder: false,
        ),
        searchList: list,
        searchQueryBuilder: (query, list) {
          return list
              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
              .toList();
        },
        overlaySearchListItemBuilder: (item) {
          return new Container(
            padding: const EdgeInsets.all(8),
            child: new Text(
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
    ));

    // Show (if only selected)the currently selected country
    // TODO: Add if condition
    myWidgets.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10),
      child: Text(
        'Current Location',
        style: TextStyle(
          color: Color(0xFFADB9CA),
        ),
      ),
    ));
    myWidgets.add(new Card(
      margin: EdgeInsets.symmetric(vertical: 0.0),
      elevation: 1.0,
      color: Colors.white,
      child: new Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 45,
          vertical: 15,
        ),
        child: new Row(
          children: <Widget>[
            Image.asset(
              'icons/flags/png/in.png',
              package: 'country_icons',
              height: 30,
              width: 35,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(child: new Text('India')),
          ],
        ),
      ),
    ));

    for (int i = 0; i < alphabets.length; i++) {
      myWidgets.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10),
        child: Text(
          alphabets[i].toString(),
          style: TextStyle(
            color: Color(0xFFADB9CA),
          ),
        ),
      ));

      for (int j = 0; j < widget.receivedData.length; j++) {
        if (widget.receivedData[j]['Country'].toString()[0] == alphabets[i]) {
          String iconPath = 'icons/flags/png/' +
              widget.receivedData[j]['CountryCode'].toString().toLowerCase() +
              '.png';
          myWidgets.add(new FlatButton(
              onPressed: () {
                demoFun(widget.receivedData[j]['Country'].toString());
                Navigator.pop(context, widget.receivedData[j]['Country'].toString());
              },
              child: new Card(
                margin: EdgeInsets.symmetric(vertical: 0.0),
                elevation: 1.0,
                color: Colors.white,
                child: new Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 45,
                    vertical: 15,
                  ),
                  child: new FlatButton(
                      onPressed: null,
                      child: new Row(
                        children: <Widget>[
                          Image.asset(
                            iconPath,
                            package: 'country_icons',
                            height: 30,
                            width: 35,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: new Text(widget.receivedData[j]['Country']
                                  .toString())),
                        ],
                      )),
                ),
              )));
        }
      }
    }

    setState(() {
      contentWidgets = myWidgets;
    });

    //TODO: Turn off the loading bar
//    return myWidgets;
  }

  @override
  Widget build(BuildContext context) {
    _createDynamicList();
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: const Color(0xFF4B4A50),
        ),
      ),
      body: new SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
//        children: _createDynamicList(),
        children: contentWidgets,
//        children: <Widget>[
//          new Container(
//            color: const Color(0xFFf2f6f8),
//            // backgroundColor: const Color(0xFFf2f6f8),
//            child: Center(
//              child: SpinKitDoubleBounce(
//                color: const Color(0xFFFA5252),
//                size: 100.0,
//              ),
//            ),
//          )
//        ],

//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10),
//            child: Text(
//              'A',
//              style: TextStyle(
//                color: Color(0xFFADB9CA),
//              ),
//            ),
//          ),
//          Card(
//            margin: EdgeInsets.symmetric(vertical: 0.0),
//            elevation: 1.0,
//            color: Colors.white,
//            child: Padding(
//              padding: const EdgeInsets.symmetric(
//                horizontal: 45,
//                vertical: 15,
//              ),
//              child: Row(
//                children: <Widget>[
//                  Image.asset(
//                    'icons/flags/png/af.png',
//                    package: 'country_icons',
//                    height: 30,
//                    width: 35,
//                  ),
//                  SizedBox(
//                    width: 15,
//                  ),
//                  Expanded(child: Text('Afghanistan')),
//                ],
//              ),
//            ),
//          ),
//        ],
      )),
    );
  }
}
