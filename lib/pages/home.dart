import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:corona/pages/loading.dart';
import 'package:auto_size_text/auto_size_text.dart';

Future<Album> fetchAlbum() async {
  final response = await http.get('https://corona.lmao.ninja/v2/all');
  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
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
  final String tests;
  final String affectedCountries;

  Album(
      {this.cases,
      this.deaths,
      this.recovered,
      this.active,
      this.critical,
      this.todayCases,
      this.tests,
      this.affectedCountries});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      cases: json['cases'].toString(),
      deaths: json['deaths'].toString(),
      recovered: json['recovered'].toString(),
      active: json['active'].toString(),
      critical: json['critical'].toString(),
      todayCases: json['todayCases'].toString(),
      tests: json['tests'].toString(),
      affectedCountries: json['affectedCountries'].toString(),
    );
  }
}

String calc(int a, int b) {
  String c = ((a / b) * 100).round().toInt().toString();
  return ('$c%');
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
      statusBarColor: const Color(0xFFFA5252),
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int f = int.parse(snapshot.data.critical);
              int h = int.parse(snapshot.data.active);
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: const Color(0xFFFA5252),
//                    height: 316,
                    height: MediaQuery.of(context).size.height/2.5,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(36, 118, 20, 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 11.5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      AutoSizeText(
                                        'Corona Virus Cases in ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                      GestureDetector(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 2.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: AutoSizeText(
                                              'World',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/location');
                                          }),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 13.5,
                                  ),
                                  Text(
                                    snapshot.data.cases,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 50,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Transform.translate(
                          offset: Offset(0.0, -50.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 47,
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 15, 25, 15),
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                    ),
                                  ),
                                  Expanded(
                                    flex: 53,
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            25, 15, 25, 15),
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                    ),
                                  ),
                                ],
                              ), //Recovered & Deaths Cards
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25, 15, 25, 15),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: FittedBox(
//                                          fit: BoxFit.contain,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  fontSize: 25,
                                                  color:
                                                      const Color(0xFFF000000),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.arrow_downward,
                                            color: Color(0xFF34c360),
                                            size: 15,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Icon(
                                            Icons.arrow_upward,
                                            color: Color(0xFFfa5252),
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            calc(h - f, h),
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            calc(f, h),
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
                              ), // Active & Mild Critical Percentage Card
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25, 15, 25, 15),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                              ), //Serious New Card
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25, 15, 25, 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'No of Tests',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.tests,
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: const Color(0xFFF000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ), //No of Tests Card
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25, 15, 25, 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Affected Countries',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.affectedCountries,
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: const Color(0xFFF000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ), //Affected Countries
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Loading();
          },
        ),
      ),
    );
  }
}
