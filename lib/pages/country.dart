import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountryWiseData extends StatefulWidget {
  @override
  _CountryWiseDataState createState() => _CountryWiseDataState();
}

class _CountryWiseDataState extends State<CountryWiseData> {
  Map data;
  String formattedDate = DateFormat.yMMMMd().add_jm().format(DateTime.now());
  String calc(int a, int b) {
    String c = ((a / b) * 100).round().toInt().toString();
    return ('$c%');
  }
//  print(data);
  @override
  Widget build(BuildContext context) {
//    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    data = ModalRoute.of(context).settings.arguments;
    print(data);
    return Scaffold(
      body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: const Color(0xFFFA5252),
//                    height: 316,
                    height: MediaQuery.of(context).size.height/2.5,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(36, 118, 20, 36),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Text(
                                      'Corona Virus Cases in ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
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
                                          child: Text(
                                            data['country'],
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 17,
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
                                  data['cases'].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(

                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Image.network(data['flag'],height: 50, width:60),),
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
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'DEATHS',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            data['deaths'],
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
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'RECOVERED',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            data['recovered'],
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
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'ACTIVE CASES',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            data['active'].toString(),
                                            style: TextStyle(
                                              fontSize: 35,
                                              color:
                                              const Color(0xFFF000000),
                                            ),
                                          ),
                                        ],
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
                                          calc( data['active'] - data['critical'], data['active']),
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
                                          calc(data['critical'], data['active']),
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
                                            data['critical'].toString(),
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
                                            data['todayCases'],
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
                            ),
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    25, 15, 25, 15),
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
                                          'NO OF TESTS',
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          data['tests'].toString(),
                                          style: TextStyle(
                                            fontSize: 35,
                                            color: const Color(0xFFF000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'CASES PER MILLION',
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          data['casesPerOneMillion'],
                                          style: TextStyle(
                                            fontSize: 35,
                                            color: const Color(0xFFF000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ), //Serious New Card
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
