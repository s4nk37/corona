import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:corona/services/covid_data.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:corona/pages/loading.dart';

Future<List<Countries>> fetchPhotos(http.Client client) async {
  final response =
  await client.get('https://corona.lmao.ninja/v2/countries/');

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}
// A function that converts a response body into a List<Photo>.
List<Countries> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Countries>((json) => Countries.fromJson(json)).toList();
}

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  var _searchview = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";




  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//      statusBarColor: const Color(0xFFf2f6f8),
      statusBarColor: Colors.grey,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: const Color(0xFF4B4A50),
        ),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(40,0,40,15),
            child: new TextField(
              decoration: InputDecoration(
                hintText: 'Search..',
                  focusColor: Colors.red,
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
              ),

            ),
          ),
          new FutureBuilder<List<Countries>>(
            future: fetchPhotos(http.Client()),
            builder: (context, snapshot) {
            if(snapshot.hasData){
              return PhotosList(photos: snapshot.data);
            }else if(snapshot.hasError){
              return Text("${snapshot.error}");
            }
            return Expanded(child:Loading());
            },
          ),
        ],
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Countries> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new ListView.builder(
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/countrywise', arguments: {
                          'country': photos[index].country.toString(),
                          'flag':  photos[index].countryInfo.flag.toString(),
                          'cases': photos[index].cases,
                          'active': photos[index].active,
                          'critical':  photos[index].critical,
                          'tests': photos[index].tests.toString(),
                          'deaths': photos[index].deaths.toString(),
                          'casesPerOneMillion': photos[index].casesPerOneMillion.toString(),
                          'deathsPerOneMillion': photos[index].deathsPerOneMillion.toString(),
                          'todayDeaths': photos[index].todayDeaths.toString(),
                          'todayCases': photos[index].todayCases.toString(),
                          'recovered': photos[index].recovered.toString(),

                        });

                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 0.0),
                        elevation: 1.0,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 45,
                            vertical: 15,
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                                width:35,
                                child: Image.network(
                                  photos[index].countryInfo.flag,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(child: Text(photos[index].country)),
                              Text(
                                photos[index].cases.toString(),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
  }
}
