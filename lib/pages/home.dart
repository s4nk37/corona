import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:corona/pages/loading.dart';


Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://corona.lmao.ninja/v2/all');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

class Album {
  final String cases;
  final String deaths;
  final String recovered;
  final String active;
  final String critical;
  final String todayCases;

  Album({this.cases, this.deaths, this.recovered, this.active, this.critical, this.todayCases});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      cases: json['cases'].toString(),
      deaths: json['deaths'].toString(),
      recovered: json['recovered'].toString(),
      active: json['active'].toString(),
      critical: json['critical'].toString(),
      todayCases: json['todayCases'].toString(),
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String formattedDate = DateFormat.yMMMMd().add_jm().format(DateTime.now());
class _HomeState extends State<Home> {

  Future<Album> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // navigation bar color
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: FutureBuilder<Album>(
         future: futureAlbum,
          builder: (context, snapshot) {
           if (snapshot.hasData) {
              return Column(
          children: <Widget>[
            Container(
              color: const Color(0xFFFA5252),
              height: 316,
              width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(36, 118, 36, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
//                        'May 22, 2020, 12:48 GMT',
                          formattedDate,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 11.5,
                        ),
                        Text(
                          'Corona Virus Cases',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                          ),
                        ),
                        SizedBox(
                          height: 13.5,
                        ),
                        Text(
                          '316,067',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        icon: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.add_location),
                          // AssetImage(
                          //     // 'icons/flags/png/in.png', package: 'country_icons',
                          // ),
                        ),
                        padding: EdgeInsets.only(top:0.0),
                        alignment: Alignment.topCenter,
                        tooltip: "Select Country",
                        color: Colors.yellow,
                        iconSize: 25,
                        splashColor: const Color(0xFFF2F6F8),
                        onPressed: (){
                          Navigator.pushNamed(context,'/location');
                        }
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Transform.translate(
                  offset: Offset(0.0, -50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'DEATHS',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                     snapshot.data.deaths,
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: const Color(0xFFFA5252),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'RECOVERED',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data.recovered,
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: const Color(0xFF34C360),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                              child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'ACTIVE CASES',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.active,
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: const Color(0xFFF000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.arrow_downward,color: Color(0xFF34c360),size: 15,),
                                      SizedBox(height:20,),
                                      Icon(Icons.arrow_upward,color: Color(0xFFfa5252),size: 15,),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '55%',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        'Mild Condition',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: const Color(0xFFFAFB8BE),
                                        ),
                                      ),
                                      SizedBox(height:10,),
                                      Text(
                                        '45%',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        'Critical Condition',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: const Color(0xFFFAFB8BE),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'SERIOUS / CRITICAL',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                       snapshot.data.critical,
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: const Color(0xFFF000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 45,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'NEW CASES',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.todayCases,
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: const Color(0xFFF000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'WORLDWIDE CASES',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                  snapshot.data.cases,
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: const Color(0xFFF000000),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
          }else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              // return Center(child: CircularProgressIndicator());
              return Loading();
       }, 
      ),
    );
  }
}
