import 'package:http/http.dart';
import 'dart:convert';

class CovidData {
  String totalConfirmed;
  int totalDeaths;
  int totalRecovered;

  Future<void> getData() async {

    try{
      // make the request
      Response response = await get('https://api.covid19api.com/world/total');
      Map data = jsonDecode(response.body);

      // get properties from json
      totalConfirmed = data['TotalConfirmed'];
      print(totalConfirmed);
    }
    catch (e) {
      print(e);
    }
  }


}



