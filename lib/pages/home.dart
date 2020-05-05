import 'dart:convert';
import 'package:corona/pages/choose_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:corona/pages/loading.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String formattedDate = DateFormat.yMMMMd().add_jm().format(DateTime.now());

class _HomeState extends State<Home> {
  var globalData = ["0", "0", "0", "0", "0", "0", "0"];
  var globalDataKeys = [
    "Date",
    "NewConfirmed",
    "TotalConfirmed",
    "NewDeaths",
    "TotalDeaths",
    "NewRecovered",
    "TotalRecovered"
  ];

  void showToastMsg(String toastMsg, int toastDuration, Color txtColor) {
    Fluttertoast.showToast(
        msg: toastMsg,
        toastLength:
            toastDuration == 1 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: txtColor,
        fontSize: 16.0);
  }

  var countriesData;

  Future<String> getData() async {
//    var response = await http.get(
//        Uri.encodeFull("https://api.covid19api.com/summary"),
//        headers: {"Accept": "application/json"});

//    print("Service Response:::" + response.body);

    setState(() {
//      var convertDataToJson = json.decode('{"Global": {"NewConfirmed": 86819,"TotalConfirmed": 3340989,"NewDeaths": 5268,"TotalDeaths": 238569,"NewRecovered": 38569,"TotalRecovered": 1052510},"Countries": [{"Country": "ALA Aland Islands","CountryCode": "AX","Slug": "Rala-aland-islands","NewConfirmed": 0,"TotalConfirmed": 0,"NewDeaths": 0,"TotalDeaths": 0,"NewRecovered": 0,"TotalRecovered": 0,"Date": "2020-05-02T18:46:23Z"},{"Country": "TAfghanistan","CountryCode": "AF","Slug": "afghanistan","NewConfirmed": 164,"TotalConfirmed": 2335,"NewDeaths": 4,"TotalDeaths": 68,"NewRecovered": 50,"TotalRecovered": 310,"Date": "2020-05-02T18:46:23Z"},{"Country": "vAlbania","CountryCode": "AL","Slug": "albania","NewConfirmed": 9,"TotalConfirmed": 782,"NewDeaths": 0,"TotalDeaths": 31,"NewRecovered": 18,"TotalRecovered": 488,"Date": "2020-05-02T18:46:23Z"},{"Country": "Algeria","CountryCode": "DZ","Slug": "algeria","NewConfirmed": 148,"TotalConfirmed": 4154,"NewDeaths": 3,"TotalDeaths": 453,"NewRecovered": 42,"TotalRecovered": 1821,"Date": "2020-05-02T18:46:23Z"},{"Country": "American Samoa","CountryCode": "AS","Slug": "american-samoa","NewConfirmed": 0,"TotalConfirmed": 0,"NewDeaths": 0,"TotalDeaths": 0,"NewRecovered": 0,"TotalRecovered": 0,"Date": "2020-05-02T18:46:23Z"},{"Country": "Andorra","CountryCode": "AD","Slug": "andorra","NewConfirmed": 0,"TotalConfirmed": 745,"NewDeaths": 1,"TotalDeaths": 43,"NewRecovered": 0,"TotalRecovered": 468,"Date": "2020-05-02T18:46:23Z"},{"Country": "Angola","CountryCode": "AO","Slug": "angola","NewConfirmed": 3,"TotalConfirmed": 30,"NewDeaths": 0,"TotalDeaths": 2,"NewRecovered": 4,"TotalRecovered": 11,"Date": "2020-05-02T18:46:23Z"},{"Country": "Anguilla","CountryCode": "AI","Slug": "anguilla","NewConfirmed": 0,"TotalConfirmed": 0,"NewDeaths": 0,"TotalDeaths": 0,"NewRecovered": 0,"TotalRecovered": 0,"Date": "2020-05-02T18:46:23Z"},{"Country": "Antarctica","CountryCode": "AQ","Slug": "antarctica","NewConfirmed": 0,"TotalConfirmed": 0,"NewDeaths": 0,"TotalDeaths": 0,"NewRecovered": 0,"TotalRecovered": 0,"Date": "2020-05-02T18:46:23Z"},{"Country": "Antigua and Barbuda","CountryCode": "AG","Slug": "antigua-and-barbuda","NewConfirmed": 1,"TotalConfirmed": 25,"NewDeaths": 0,"TotalDeaths": 3,"NewRecovered": 4,"TotalRecovered": 15,"Date": "2020-05-02T18:46:23Z"},{"Country": "Argentina","CountryCode": "AR","Slug": "argentina","NewConfirmed": 104,"TotalConfirmed": 4532,"NewDeaths": 7,"TotalDeaths": 225,"NewRecovered": 36,"TotalRecovered": 1292,"Date": "2020-05-02T18:46:23Z"},{"Country": "Armenia","CountryCode": "AM","Slug": "armenia","NewConfirmed": 82,"TotalConfirmed": 2148,"NewDeaths": 1,"TotalDeaths": 33,"NewRecovered": 48,"TotalRecovered": 977,"Date": "2020-05-02T18:46:23Z"},{"Country": "Aruba","CountryCode": "AW","Slug": "aruba","NewConfirmed": 0,"TotalConfirmed": 0,"NewDeaths": 0,"TotalDeaths": 0,"NewRecovered": 0,"TotalRecovered": 0,"Date": "2020-05-02T18:46:23Z"},{"Country": "Australia","CountryCode": "AU","Slug": "australia","NewConfirmed": 12,"TotalConfirmed": 6778,"NewDeaths": 0,"TotalDeaths": 93,"NewRecovered": 33,"TotalRecovered": 5775,"Date": "2020-05-02T18:46:23Z"},{"Country": "Austria","CountryCode": "AT","Slug": "austria","NewConfirmed": 79,"TotalConfirmed": 15531,"NewDeaths": 5,"TotalDeaths": 589,"NewRecovered": 203,"TotalRecovered": 13110,"Date": "2020-05-02T18:46:23Z"},{"Country": "Azerbaijan","CountryCode": "AZ","Slug": "azerbaijan","NewConfirmed": 50,"TotalConfirmed": 1854,"NewDeaths": 1,"TotalDeaths": 25,"NewRecovered": 40,"TotalRecovered": 1365,"Date": "2020-05-02T18:46:23Z"}]}');
      var convertDataToJson = json.decode(
          '{"Global":{"NewConfirmed":86819,"TotalConfirmed":3340989,"NewDeaths":5268,"TotalDeaths":238569,"NewRecovered":38569,"TotalRecovered":1052510},"Countries":[{"Country":"ALA Aland Islands","CountryCode":"AX","Slug":"ala-aland-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Afghanistan","CountryCode":"AF","Slug":"afghanistan","NewConfirmed":164,"TotalConfirmed":2335,"NewDeaths":4,"TotalDeaths":68,"NewRecovered":50,"TotalRecovered":310,"Date":"2020-05-02T18:46:23Z"},{"Country":"Albania","CountryCode":"AL","Slug":"albania","NewConfirmed":9,"TotalConfirmed":782,"NewDeaths":0,"TotalDeaths":31,"NewRecovered":18,"TotalRecovered":488,"Date":"2020-05-02T18:46:23Z"},{"Country":"Algeria","CountryCode":"DZ","Slug":"algeria","NewConfirmed":148,"TotalConfirmed":4154,"NewDeaths":3,"TotalDeaths":453,"NewRecovered":42,"TotalRecovered":1821,"Date":"2020-05-02T18:46:23Z"},{"Country":"American Samoa","CountryCode":"AS","Slug":"american-samoa","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Andorra","CountryCode":"AD","Slug":"andorra","NewConfirmed":0,"TotalConfirmed":745,"NewDeaths":1,"TotalDeaths":43,"NewRecovered":0,"TotalRecovered":468,"Date":"2020-05-02T18:46:23Z"},{"Country":"Angola","CountryCode":"AO","Slug":"angola","NewConfirmed":3,"TotalConfirmed":30,"NewDeaths":0,"TotalDeaths":2,"NewRecovered":4,"TotalRecovered":11,"Date":"2020-05-02T18:46:23Z"},{"Country":"Anguilla","CountryCode":"AI","Slug":"anguilla","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Antarctica","CountryCode":"AQ","Slug":"antarctica","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Antigua and Barbuda","CountryCode":"AG","Slug":"antigua-and-barbuda","NewConfirmed":1,"TotalConfirmed":25,"NewDeaths":0,"TotalDeaths":3,"NewRecovered":4,"TotalRecovered":15,"Date":"2020-05-02T18:46:23Z"},{"Country":"Argentina","CountryCode":"AR","Slug":"argentina","NewConfirmed":104,"TotalConfirmed":4532,"NewDeaths":7,"TotalDeaths":225,"NewRecovered":36,"TotalRecovered":1292,"Date":"2020-05-02T18:46:23Z"},{"Country":"Armenia","CountryCode":"AM","Slug":"armenia","NewConfirmed":82,"TotalConfirmed":2148,"NewDeaths":1,"TotalDeaths":33,"NewRecovered":48,"TotalRecovered":977,"Date":"2020-05-02T18:46:23Z"},{"Country":"Aruba","CountryCode":"AW","Slug":"aruba","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Australia","CountryCode":"AU","Slug":"australia","NewConfirmed":12,"TotalConfirmed":6778,"NewDeaths":0,"TotalDeaths":93,"NewRecovered":33,"TotalRecovered":5775,"Date":"2020-05-02T18:46:23Z"},{"Country":"Austria","CountryCode":"AT","Slug":"austria","NewConfirmed":79,"TotalConfirmed":15531,"NewDeaths":5,"TotalDeaths":589,"NewRecovered":203,"TotalRecovered":13110,"Date":"2020-05-02T18:46:23Z"},{"Country":"Azerbaijan","CountryCode":"AZ","Slug":"azerbaijan","NewConfirmed":50,"TotalConfirmed":1854,"NewDeaths":1,"TotalDeaths":25,"NewRecovered":40,"TotalRecovered":1365,"Date":"2020-05-02T18:46:23Z"},{"Country":"Bahrain","CountryCode":"BH","Slug":"bahrain","NewConfirmed":130,"TotalConfirmed":3170,"NewDeaths":0,"TotalDeaths":8,"NewRecovered":55,"TotalRecovered":1555,"Date":"2020-05-02T18:46:23Z"},{"Country":"Bangladesh","CountryCode":"BD","Slug":"bangladesh","NewConfirmed":571,"TotalConfirmed":8238,"NewDeaths":2,"TotalDeaths":170,"NewRecovered":14,"TotalRecovered":174,"Date":"2020-05-02T18:46:23Z"},{"Country":"Barbados","CountryCode":"BB","Slug":"barbados","NewConfirmed":0,"TotalConfirmed":81,"NewDeaths":0,"TotalDeaths":7,"NewRecovered":0,"TotalRecovered":39,"Date":"2020-05-02T18:46:23Z"},{"Country":"Belarus","CountryCode":"BY","Slug":"belarus","NewConfirmed":890,"TotalConfirmed":14917,"NewDeaths":4,"TotalDeaths":93,"NewRecovered":532,"TotalRecovered":2918,"Date":"2020-05-02T18:46:23Z"},{"Country":"Belgium","CountryCode":"BE","Slug":"belgium","NewConfirmed":513,"TotalConfirmed":49032,"NewDeaths":109,"TotalDeaths":7703,"NewRecovered":316,"TotalRecovered":11892,"Date":"2020-05-02T18:46:23Z"},{"Country":"Belize","CountryCode":"BZ","Slug":"belize","NewConfirmed":0,"TotalConfirmed":18,"NewDeaths":0,"TotalDeaths":2,"NewRecovered":4,"TotalRecovered":13,"Date":"2020-05-02T18:46:23Z"},{"Country":"Benin","CountryCode":"BJ","Slug":"benin","NewConfirmed":26,"TotalConfirmed":90,"NewDeaths":1,"TotalDeaths":2,"NewRecovered":9,"TotalRecovered":42,"Date":"2020-05-02T18:46:23Z"},{"Country":"Bermuda","CountryCode":"BM","Slug":"bermuda","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Bhutan","CountryCode":"BT","Slug":"bhutan","NewConfirmed":0,"TotalConfirmed":7,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":5,"Date":"2020-05-02T18:46:23Z"},{"Country":"Bolivia","CountryCode":"BO","Slug":"bolivia","NewConfirmed":119,"TotalConfirmed":1229,"NewDeaths":7,"TotalDeaths":66,"NewRecovered":17,"TotalRecovered":134,"Date":"2020-05-02T18:46:23Z"},{"Country":"Bosnia and Herzegovina","CountryCode":"BA","Slug":"bosnia-and-herzegovina","NewConfirmed":24,"TotalConfirmed":1781,"NewDeaths":1,"TotalDeaths":70,"NewRecovered":28,"TotalRecovered":755,"Date":"2020-05-02T18:46:23Z"},{"Country":"Botswana","CountryCode":"BW","Slug":"botswana","NewConfirmed":0,"TotalConfirmed":23,"NewDeaths":0,"TotalDeaths":1,"NewRecovered":3,"TotalRecovered":8,"Date":"2020-05-02T18:46:23Z"},{"Country":"Bouvet Island","CountryCode":"BV","Slug":"bouvet-island","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Brazil","CountryCode":"BR","Slug":"brazil","NewConfirmed":5015,"TotalConfirmed":92202,"NewDeaths":406,"TotalDeaths":6412,"NewRecovered":2104,"TotalRecovered":38039,"Date":"2020-05-02T18:46:23Z"},{"Country":"British Indian Ocean Territory","CountryCode":"IO","Slug":"british-indian-ocean-territory","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"British Virgin Islands","CountryCode":"VG","Slug":"british-virgin-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Brunei Darussalam","CountryCode":"BN","Slug":"brunei","NewConfirmed":0,"TotalConfirmed":138,"NewDeaths":0,"TotalDeaths":1,"NewRecovered":0,"TotalRecovered":124,"Date":"2020-05-02T18:46:23Z"},{"Country":"Bulgaria","CountryCode":"BG","Slug":"bulgaria","NewConfirmed":49,"TotalConfirmed":1555,"NewDeaths":2,"TotalDeaths":68,"NewRecovered":10,"TotalRecovered":276,"Date":"2020-05-02T18:46:23Z"},{"Country":"Burkina Faso","CountryCode":"BF","Slug":"burkina-faso","NewConfirmed":4,"TotalConfirmed":649,"NewDeaths":1,"TotalDeaths":44,"NewRecovered":11,"TotalRecovered":517,"Date":"2020-05-02T18:46:23Z"},{"Country":"Burundi","CountryCode":"BI","Slug":"burundi","NewConfirmed":0,"TotalConfirmed":11,"NewDeaths":0,"TotalDeaths":1,"NewRecovered":0,"TotalRecovered":4,"Date":"2020-05-02T18:46:23Z"},{"Country":"Cambodia","CountryCode":"KH","Slug":"cambodia","NewConfirmed":0,"TotalConfirmed":122,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":1,"TotalRecovered":120,"Date":"2020-05-02T18:46:23Z"},{"Country":"Cameroon","CountryCode":"CM","Slug":"cameroon","NewConfirmed":0,"TotalConfirmed":1832,"NewDeaths":0,"TotalDeaths":61,"NewRecovered":0,"TotalRecovered":934,"Date":"2020-05-02T18:46:23Z"},{"Country":"Canada","CountryCode":"CA","Slug":"canada","NewConfirmed":1885,"TotalConfirmed":56342,"NewDeaths":227,"TotalDeaths":3536,"NewRecovered":1340,"TotalRecovered":22764,"Date":"2020-05-02T18:46:23Z"},{"Country":"Cape Verde","CountryCode":"CV","Slug":"cape-verde","NewConfirmed":1,"TotalConfirmed":122,"NewDeaths":0,"TotalDeaths":1,"NewRecovered":14,"TotalRecovered":18,"Date":"2020-05-02T18:46:23Z"},{"Country":"Cayman Islands","CountryCode":"KY","Slug":"cayman-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Central African Republic","CountryCode":"CF","Slug":"central-african-republic","NewConfirmed":22,"TotalConfirmed":72,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":10,"Date":"2020-05-02T18:46:23Z"},{"Country":"Chad","CountryCode":"TD","Slug":"chad","NewConfirmed":0,"TotalConfirmed":73,"NewDeaths":0,"TotalDeaths":5,"NewRecovered":0,"TotalRecovered":33,"Date":"2020-05-02T18:46:23Z"},{"Country":"Chile","CountryCode":"CL","Slug":"chile","NewConfirmed":985,"TotalConfirmed":17008,"NewDeaths":7,"TotalDeaths":234,"NewRecovered":438,"TotalRecovered":9018,"Date":"2020-05-02T18:46:23Z"},{"Country":"China","CountryCode":"CN","Slug":"china","NewConfirmed":3,"TotalConfirmed":83959,"NewDeaths":0,"TotalDeaths":4637,"NewRecovered":50,"TotalRecovered":78573,"Date":"2020-05-02T18:46:23Z"},{"Country":"Christmas Island","CountryCode":"CX","Slug":"christmas-island","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Cocos (Keeling) Islands","CountryCode":"CC","Slug":"cocos-keeling-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Colombia","CountryCode":"CO","Slug":"colombia","NewConfirmed":499,"TotalConfirmed":7006,"NewDeaths":21,"TotalDeaths":314,"NewRecovered":112,"TotalRecovered":1551,"Date":"2020-05-02T18:46:23Z"},{"Country":"Comoros","CountryCode":"KM","Slug":"comoros","NewConfirmed":0,"TotalConfirmed":1,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Congo (Brazzaville)","CountryCode":"CG","Slug":"congo-brazzaville","NewConfirmed":9,"TotalConfirmed":229,"NewDeaths":0,"TotalDeaths":9,"NewRecovered":6,"TotalRecovered":25,"Date":"2020-05-02T18:46:23Z"},{"Country":"Congo (Kinshasa)","CountryCode":"CD","Slug":"congo-kinshasa","NewConfirmed":32,"TotalConfirmed":604,"NewDeaths":1,"TotalDeaths":32,"NewRecovered":2,"TotalRecovered":75,"Date":"2020-05-02T18:46:23Z"},{"Country":"Cook Islands","CountryCode":"CK","Slug":"cook-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Costa Rica","CountryCode":"CR","Slug":"costa-rica","NewConfirmed":6,"TotalConfirmed":725,"NewDeaths":0,"TotalDeaths":6,"NewRecovered":17,"TotalRecovered":355,"Date":"2020-05-02T18:46:23Z"},{"Country":"Croatia","CountryCode":"HR","Slug":"croatia","NewConfirmed":9,"TotalConfirmed":2085,"NewDeaths":6,"TotalDeaths":75,"NewRecovered":73,"TotalRecovered":1421,"Date":"2020-05-02T18:46:23Z"},{"Country":"Cuba","CountryCode":"CU","Slug":"cuba","NewConfirmed":36,"TotalConfirmed":1537,"NewDeaths":3,"TotalDeaths":64,"NewRecovered":33,"TotalRecovered":714,"Date":"2020-05-02T18:46:23Z"},{"Country":"Cyprus","CountryCode":"CY","Slug":"cyprus","NewConfirmed":7,"TotalConfirmed":857,"NewDeaths":0,"TotalDeaths":15,"NewRecovered":0,"TotalRecovered":296,"Date":"2020-05-02T18:46:23Z"},{"Country":"Czech Republic","CountryCode":"CZ","Slug":"czech-republic","NewConfirmed":55,"TotalConfirmed":7737,"NewDeaths":4,"TotalDeaths":240,"NewRecovered":58,"TotalRecovered":3372,"Date":"2020-05-02T18:46:23Z"},{"Country":"Côte d\'Ivoire","CountryCode":"CI","Slug":"cote-divoire","NewConfirmed":58,"TotalConfirmed":1333,"NewDeaths":1,"TotalDeaths":15,"NewRecovered":23,"TotalRecovered":597,"Date":"2020-05-02T18:46:23Z"},{"Country":"Denmark","CountryCode":"DK","Slug":"denmark","NewConfirmed":153,"TotalConfirmed":9509,"NewDeaths":8,"TotalDeaths":460,"NewRecovered":183,"TotalRecovered":6924,"Date":"2020-05-02T18:46:23Z"},{"Country":"Djibouti","CountryCode":"DJ","Slug":"djibouti","NewConfirmed":8,"TotalConfirmed":1097,"NewDeaths":0,"TotalDeaths":2,"NewRecovered":30,"TotalRecovered":672,"Date":"2020-05-02T18:46:23Z"},{"Country":"Dominica","CountryCode":"DM","Slug":"dominica","NewConfirmed":0,"TotalConfirmed":16,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":13,"Date":"2020-05-02T18:46:23Z"},{"Country":"Dominican Republic","CountryCode":"DO","Slug":"dominican-republic","NewConfirmed":316,"TotalConfirmed":7288,"NewDeaths":12,"TotalDeaths":313,"NewRecovered":86,"TotalRecovered":1387,"Date":"2020-05-02T18:46:23Z"},{"Country":"Ecuador","CountryCode":"EC","Slug":"ecuador","NewConfirmed":1402,"TotalConfirmed":26336,"NewDeaths":163,"TotalDeaths":1063,"NewRecovered":355,"TotalRecovered":1913,"Date":"2020-05-02T18:46:23Z"},{"Country":"Egypt","CountryCode":"EG","Slug":"egypt","NewConfirmed":358,"TotalConfirmed":5895,"NewDeaths":14,"TotalDeaths":406,"NewRecovered":79,"TotalRecovered":1460,"Date":"2020-05-02T18:46:23Z"},{"Country":"El Salvador","CountryCode":"SV","Slug":"el-salvador","NewConfirmed":29,"TotalConfirmed":424,"NewDeaths":0,"TotalDeaths":10,"NewRecovered":5,"TotalRecovered":124,"Date":"2020-05-02T18:46:23Z"},{"Country":"Equatorial Guinea","CountryCode":"GQ","Slug":"equatorial-guinea","NewConfirmed":0,"TotalConfirmed":315,"NewDeaths":0,"TotalDeaths":1,"NewRecovered":0,"TotalRecovered":9,"Date":"2020-05-02T18:46:23Z"},{"Country":"Eritrea","CountryCode":"ER","Slug":"eritrea","NewConfirmed":0,"TotalConfirmed":39,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":26,"Date":"2020-05-02T18:46:23Z"},{"Country":"Estonia","CountryCode":"EE","Slug":"estonia","NewConfirmed":5,"TotalConfirmed":1694,"NewDeaths":0,"TotalDeaths":52,"NewRecovered":4,"TotalRecovered":253,"Date":"2020-05-02T18:46:23Z"},{"Country":"Ethiopia","CountryCode":"ET","Slug":"ethiopia","NewConfirmed":2,"TotalConfirmed":133,"NewDeaths":0,"TotalDeaths":3,"NewRecovered":7,"TotalRecovered":66,"Date":"2020-05-02T18:46:23Z"},{"Country":"Falkland Islands (Malvinas)","CountryCode":"FK","Slug":"falkland-islands-malvinas","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Faroe Islands","CountryCode":"FO","Slug":"faroe-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Fiji","CountryCode":"FJ","Slug":"fiji","NewConfirmed":0,"TotalConfirmed":18,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":12,"Date":"2020-05-02T18:46:23Z"},{"Country":"Finland","CountryCode":"FI","Slug":"finland","NewConfirmed":56,"TotalConfirmed":5051,"NewDeaths":7,"TotalDeaths":218,"NewRecovered":0,"TotalRecovered":3000,"Date":"2020-05-02T18:46:23Z"},{"Country":"France","CountryCode":"FR","Slug":"france","NewConfirmed":6,"TotalConfirmed":167305,"NewDeaths":218,"TotalDeaths":24628,"NewRecovered":744,"TotalRecovered":51124,"Date":"2020-05-02T18:46:23Z"},{"Country":"French Guiana","CountryCode":"GF","Slug":"french-guiana","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"French Polynesia","CountryCode":"PF","Slug":"french-polynesia","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"French Southern Territories","CountryCode":"TF","Slug":"french-southern-territories","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Gabon","CountryCode":"GA","Slug":"gabon","NewConfirmed":0,"TotalConfirmed":276,"NewDeaths":0,"TotalDeaths":3,"NewRecovered":0,"TotalRecovered":67,"Date":"2020-05-02T18:46:23Z"},{"Country":"Gambia","CountryCode":"GM","Slug":"gambia","NewConfirmed":1,"TotalConfirmed":12,"NewDeaths":0,"TotalDeaths":1,"NewRecovered":0,"TotalRecovered":8,"Date":"2020-05-02T18:46:23Z"},{"Country":"Georgia","CountryCode":"GE","Slug":"georgia","NewConfirmed":27,"TotalConfirmed":566,"NewDeaths":1,"TotalDeaths":7,"NewRecovered":23,"TotalRecovered":207,"Date":"2020-05-02T18:46:23Z"},{"Country":"Germany","CountryCode":"DE","Slug":"germany","NewConfirmed":1068,"TotalConfirmed":164077,"NewDeaths":113,"TotalDeaths":6736,"NewRecovered":3400,"TotalRecovered":126900,"Date":"2020-05-02T18:46:23Z"},{"Country":"Ghana","CountryCode":"GH","Slug":"ghana","NewConfirmed":0,"TotalConfirmed":2074,"NewDeaths":0,"TotalDeaths":17,"NewRecovered":0,"TotalRecovered":212,"Date":"2020-05-02T18:46:23Z"},{"Country":"Gibraltar","CountryCode":"GI","Slug":"gibraltar","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Greece","CountryCode":"GR","Slug":"greece","NewConfirmed":21,"TotalConfirmed":2612,"NewDeaths":0,"TotalDeaths":140,"NewRecovered":0,"TotalRecovered":1374,"Date":"2020-05-02T18:46:23Z"},{"Country":"Greenland","CountryCode":"GL","Slug":"greenland","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Grenada","CountryCode":"GD","Slug":"grenada","NewConfirmed":0,"TotalConfirmed":20,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":13,"Date":"2020-05-02T18:46:23Z"},{"Country":"Guadeloupe","CountryCode":"GP","Slug":"guadeloupe","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Guam","CountryCode":"GU","Slug":"guam","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Guatemala","CountryCode":"GT","Slug":"guatemala","NewConfirmed":45,"TotalConfirmed":644,"NewDeaths":0,"TotalDeaths":16,"NewRecovered":6,"TotalRecovered":72,"Date":"2020-05-02T18:46:23Z"},{"Country":"Guernsey","CountryCode":"GG","Slug":"guernsey","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Guinea","CountryCode":"GN","Slug":"guinea","NewConfirmed":42,"TotalConfirmed":1537,"NewDeaths":0,"TotalDeaths":7,"NewRecovered":13,"TotalRecovered":342,"Date":"2020-05-02T18:46:23Z"},{"Country":"Guinea-Bissau","CountryCode":"GW","Slug":"guinea-bissau","NewConfirmed":52,"TotalConfirmed":257,"NewDeaths":0,"TotalDeaths":1,"NewRecovered":0,"TotalRecovered":19,"Date":"2020-05-02T18:46:23Z"},{"Country":"Guyana","CountryCode":"GY","Slug":"guyana","NewConfirmed":0,"TotalConfirmed":82,"NewDeaths":0,"TotalDeaths":9,"NewRecovered":0,"TotalRecovered":22,"Date":"2020-05-02T18:46:23Z"},{"Country":"Haiti","CountryCode":"HT","Slug":"haiti","NewConfirmed":4,"TotalConfirmed":85,"NewDeaths":0,"TotalDeaths":8,"NewRecovered":2,"TotalRecovered":10,"Date":"2020-05-02T18:46:23Z"},{"Country":"Heard and Mcdonald Islands","CountryCode":"HM","Slug":"heard-and-mcdonald-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Holy See (Vatican City State)","CountryCode":"VA","Slug":"holy-see-vatican-city-state","NewConfirmed":0,"TotalConfirmed":11,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":2,"Date":"2020-05-02T18:46:23Z"},{"Country":"Honduras","CountryCode":"HN","Slug":"honduras","NewConfirmed":33,"TotalConfirmed":804,"NewDeaths":4,"TotalDeaths":75,"NewRecovered":33,"TotalRecovered":112,"Date":"2020-05-02T18:46:23Z"},{"Country":"Hong Kong, SAR China","CountryCode":"HK","Slug":"hong-kong-sar-china","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Hungary","CountryCode":"HU","Slug":"hungary","NewConfirmed":88,"TotalConfirmed":2863,"NewDeaths":11,"TotalDeaths":323,"NewRecovered":28,"TotalRecovered":609,"Date":"2020-05-02T18:46:23Z"},{"Country":"Iceland","CountryCode":"IS","Slug":"iceland","NewConfirmed":1,"TotalConfirmed":1798,"NewDeaths":0,"TotalDeaths":10,"NewRecovered":19,"TotalRecovered":1689,"Date":"2020-05-02T18:46:23Z"},{"Country":"India","CountryCode":"IN","Slug":"india","NewConfirmed":2394,"TotalConfirmed":37257,"NewDeaths":69,"TotalDeaths":1223,"NewRecovered":939,"TotalRecovered":10007,"Date":"2020-05-02T18:46:23Z"},{"Country":"Indonesia","CountryCode":"ID","Slug":"indonesia","NewConfirmed":433,"TotalConfirmed":10551,"NewDeaths":8,"TotalDeaths":800,"NewRecovered":69,"TotalRecovered":1591,"Date":"2020-05-02T18:46:23Z"},{"Country":"Iran, Islamic Republic of","CountryCode":"IR","Slug":"iran","NewConfirmed":1006,"TotalConfirmed":95646,"NewDeaths":63,"TotalDeaths":6091,"NewRecovered":1215,"TotalRecovered":76318,"Date":"2020-05-02T18:46:23Z"},{"Country":"Iraq","CountryCode":"IQ","Slug":"iraq","NewConfirmed":68,"TotalConfirmed":2153,"NewDeaths":1,"TotalDeaths":94,"NewRecovered":39,"TotalRecovered":1414,"Date":"2020-05-02T18:46:23Z"},{"Country":"Ireland","CountryCode":"IE","Slug":"ireland","NewConfirmed":221,"TotalConfirmed":20833,"NewDeaths":33,"TotalDeaths":1265,"NewRecovered":0,"TotalRecovered":13386,"Date":"2020-05-02T18:46:23Z"},{"Country":"Isle of Man","CountryCode":"IM","Slug":"isle-of-man","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Israel","CountryCode":"IL","Slug":"israel","NewConfirmed":155,"TotalConfirmed":16101,"NewDeaths":3,"TotalDeaths":225,"NewRecovered":595,"TotalRecovered":9156,"Date":"2020-05-02T18:46:23Z"},{"Country":"Italy","CountryCode":"IT","Slug":"italy","NewConfirmed":1965,"TotalConfirmed":207428,"NewDeaths":269,"TotalDeaths":28236,"NewRecovered":2304,"TotalRecovered":78249,"Date":"2020-05-02T18:46:23Z"},{"Country":"Jamaica","CountryCode":"JM","Slug":"jamaica","NewConfirmed":10,"TotalConfirmed":432,"NewDeaths":0,"TotalDeaths":8,"NewRecovered":2,"TotalRecovered":31,"Date":"2020-05-02T18:46:23Z"},{"Country":"Japan","CountryCode":"JP","Slug":"japan","NewConfirmed":217,"TotalConfirmed":14305,"NewDeaths":25,"TotalDeaths":455,"NewRecovered":515,"TotalRecovered":2975,"Date":"2020-05-02T18:46:23Z"},{"Country":"Jersey","CountryCode":"JE","Slug":"jersey","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Jordan","CountryCode":"JO","Slug":"jordan","NewConfirmed":6,"TotalConfirmed":459,"NewDeaths":0,"TotalDeaths":8,"NewRecovered":2,"TotalRecovered":364,"Date":"2020-05-02T18:46:23Z"},{"Country":"Kazakhstan","CountryCode":"KZ","Slug":"kazakhstan","NewConfirmed":195,"TotalConfirmed":3597,"NewDeaths":0,"TotalDeaths":25,"NewRecovered":56,"TotalRecovered":922,"Date":"2020-05-02T18:46:23Z"},{"Country":"Kenya","CountryCode":"KE","Slug":"kenya","NewConfirmed":15,"TotalConfirmed":411,"NewDeaths":4,"TotalDeaths":21,"NewRecovered":6,"TotalRecovered":150,"Date":"2020-05-02T18:46:23Z"},{"Country":"Kiribati","CountryCode":"KI","Slug":"kiribati","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Korea (North)","CountryCode":"KP","Slug":"korea-north","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Korea (South)","CountryCode":"KR","Slug":"korea-south","NewConfirmed":6,"TotalConfirmed":10780,"NewDeaths":2,"TotalDeaths":250,"NewRecovered":51,"TotalRecovered":9123,"Date":"2020-05-02T18:46:23Z"},{"Country":"Kuwait","CountryCode":"KW","Slug":"kuwait","NewConfirmed":353,"TotalConfirmed":4377,"NewDeaths":4,"TotalDeaths":30,"NewRecovered":63,"TotalRecovered":1602,"Date":"2020-05-02T18:46:23Z"},{"Country":"Kyrgyzstan","CountryCode":"KG","Slug":"kyrgyzstan","NewConfirmed":10,"TotalConfirmed":756,"NewDeaths":0,"TotalDeaths":8,"NewRecovered":42,"TotalRecovered":504,"Date":"2020-05-02T18:46:23Z"},{"Country":"Lao PDR","CountryCode":"LA","Slug":"lao-pdr","NewConfirmed":0,"TotalConfirmed":19,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":8,"Date":"2020-05-02T18:46:23Z"},{"Country":"Latvia","CountryCode":"LV","Slug":"latvia","NewConfirmed":12,"TotalConfirmed":870,"NewDeaths":1,"TotalDeaths":16,"NewRecovered":0,"TotalRecovered":348,"Date":"2020-05-02T18:46:23Z"},{"Country":"Lebanon","CountryCode":"LB","Slug":"lebanon","NewConfirmed":4,"TotalConfirmed":729,"NewDeaths":0,"TotalDeaths":24,"NewRecovered":42,"TotalRecovered":192,"Date":"2020-05-02T18:46:23Z"},{"Country":"Lesotho","CountryCode":"LS","Slug":"lesotho","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Liberia","CountryCode":"LR","Slug":"liberia","NewConfirmed":11,"TotalConfirmed":152,"NewDeaths":2,"TotalDeaths":18,"NewRecovered":0,"TotalRecovered":45,"Date":"2020-05-02T18:46:23Z"},{"Country":"Libya","CountryCode":"LY","Slug":"libya","NewConfirmed":2,"TotalConfirmed":63,"NewDeaths":0,"TotalDeaths":3,"NewRecovered":0,"TotalRecovered":18,"Date":"2020-05-02T18:46:23Z"},{"Country":"Liechtenstein","CountryCode":"LI","Slug":"liechtenstein","NewConfirmed":0,"TotalConfirmed":82,"NewDeaths":0,"TotalDeaths":1,"NewRecovered":0,"TotalRecovered":55,"Date":"2020-05-02T18:46:23Z"},{"Country":"Lithuania","CountryCode":"LT","Slug":"lithuania","NewConfirmed":14,"TotalConfirmed":1399,"NewDeaths":0,"TotalDeaths":45,"NewRecovered":5,"TotalRecovered":594,"Date":"2020-05-02T18:46:23Z"},{"Country":"Luxembourg","CountryCode":"LU","Slug":"luxembourg","NewConfirmed":18,"TotalConfirmed":3802,"NewDeaths":2,"TotalDeaths":92,"NewRecovered":0,"TotalRecovered":3213,"Date":"2020-05-02T18:46:23Z"},{"Country":"Macao, SAR China","CountryCode":"MO","Slug":"macao-sar-china","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Macedonia, Republic of","CountryCode":"MK","Slug":"macedonia","NewConfirmed":29,"TotalConfirmed":1494,"NewDeaths":4,"TotalDeaths":81,"NewRecovered":69,"TotalRecovered":807,"Date":"2020-05-02T18:46:23Z"},{"Country":"Madagascar","CountryCode":"MG","Slug":"madagascar","NewConfirmed":4,"TotalConfirmed":132,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":2,"TotalRecovered":94,"Date":"2020-05-02T18:46:23Z"},{"Country":"Malawi","CountryCode":"MW","Slug":"malawi","NewConfirmed":0,"TotalConfirmed":37,"NewDeaths":0,"TotalDeaths":3,"NewRecovered":2,"TotalRecovered":9,"Date":"2020-05-02T18:46:23Z"},{"Country":"Malaysia","CountryCode":"MY","Slug":"malaysia","NewConfirmed":69,"TotalConfirmed":6071,"NewDeaths":1,"TotalDeaths":103,"NewRecovered":39,"TotalRecovered":4210,"Date":"2020-05-02T18:46:23Z"},{"Country":"Maldives","CountryCode":"MV","Slug":"maldives","NewConfirmed":23,"TotalConfirmed":491,"NewDeaths":0,"TotalDeaths":1,"NewRecovered":0,"TotalRecovered":17,"Date":"2020-05-02T18:46:23Z"},{"Country":"Mali","CountryCode":"ML","Slug":"mali","NewConfirmed":18,"TotalConfirmed":508,"NewDeaths":0,"TotalDeaths":26,"NewRecovered":61,"TotalRecovered":196,"Date":"2020-05-02T18:46:23Z"},{"Country":"Malta","CountryCode":"MT","Slug":"malta","NewConfirmed":2,"TotalConfirmed":467,"NewDeaths":0,"TotalDeaths":4,"NewRecovered":32,"TotalRecovered":383,"Date":"2020-05-02T18:46:23Z"},{"Country":"Marshall Islands","CountryCode":"MH","Slug":"marshall-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Martinique","CountryCode":"MQ","Slug":"martinique","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Mauritania","CountryCode":"MR","Slug":"mauritania","NewConfirmed":0,"TotalConfirmed":8,"NewDeaths":0,"TotalDeaths":1,"NewRecovered":0,"TotalRecovered":6,"Date":"2020-05-02T18:46:23Z"},{"Country":"Mauritius","CountryCode":"MU","Slug":"mauritius","NewConfirmed":0,"TotalConfirmed":332,"NewDeaths":0,"TotalDeaths":10,"NewRecovered":2,"TotalRecovered":312,"Date":"2020-05-02T18:46:23Z"},{"Country":"Mayotte","CountryCode":"YT","Slug":"mayotte","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Mexico","CountryCode":"MX","Slug":"mexico","NewConfirmed":1515,"TotalConfirmed":20739,"NewDeaths":113,"TotalDeaths":1972,"NewRecovered":954,"TotalRecovered":12377,"Date":"2020-05-02T18:46:23Z"},{"Country":"Micronesia, Federated States of","CountryCode":"FM","Slug":"micronesia","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Moldova","CountryCode":"MD","Slug":"moldova","NewConfirmed":83,"TotalConfirmed":3980,"NewDeaths":6,"TotalDeaths":122,"NewRecovered":90,"TotalRecovered":1272,"Date":"2020-05-02T18:46:23Z"},{"Country":"Monaco","CountryCode":"MC","Slug":"monaco","NewConfirmed":0,"TotalConfirmed":95,"NewDeaths":0,"TotalDeaths":4,"NewRecovered":9,"TotalRecovered":73,"Date":"2020-05-02T18:46:23Z"},{"Country":"Mongolia","CountryCode":"MN","Slug":"mongolia","NewConfirmed":0,"TotalConfirmed":38,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":10,"Date":"2020-05-02T18:46:23Z"},{"Country":"Montenegro","CountryCode":"ME","Slug":"montenegro","NewConfirmed":0,"TotalConfirmed":322,"NewDeaths":0,"TotalDeaths":7,"NewRecovered":19,"TotalRecovered":233,"Date":"2020-05-02T18:46:23Z"},{"Country":"Montserrat","CountryCode":"MS","Slug":"montserrat","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Morocco","CountryCode":"MA","Slug":"morocco","NewConfirmed":146,"TotalConfirmed":4569,"NewDeaths":1,"TotalDeaths":171,"NewRecovered":99,"TotalRecovered":1083,"Date":"2020-05-02T18:46:23Z"},{"Country":"Mozambique","CountryCode":"MZ","Slug":"mozambique","NewConfirmed":3,"TotalConfirmed":79,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":12,"Date":"2020-05-02T18:46:23Z"},{"Country":"Myanmar","CountryCode":"MM","Slug":"myanmar","NewConfirmed":0,"TotalConfirmed":151,"NewDeaths":0,"TotalDeaths":6,"NewRecovered":4,"TotalRecovered":31,"Date":"2020-05-02T18:46:23Z"},{"Country":"Namibia","CountryCode":"NA","Slug":"namibia","NewConfirmed":0,"TotalConfirmed":16,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":8,"Date":"2020-05-02T18:46:23Z"},{"Country":"Nauru","CountryCode":"NR","Slug":"nauru","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Nepal","CountryCode":"NP","Slug":"nepal","NewConfirmed":2,"TotalConfirmed":59,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":16,"Date":"2020-05-02T18:46:23Z"},{"Country":"Netherlands","CountryCode":"NL","Slug":"netherlands","NewConfirmed":477,"TotalConfirmed":39989,"NewDeaths":98,"TotalDeaths":4909,"NewRecovered":13,"TotalRecovered":138,"Date":"2020-05-02T18:46:23Z"},{"Country":"Netherlands Antilles","CountryCode":"AN","Slug":"netherlands-antilles","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"New Caledonia","CountryCode":"NC","Slug":"new-caledonia","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"New Zealand","CountryCode":"NZ","Slug":"new-zealand","NewConfirmed":6,"TotalConfirmed":1485,"NewDeaths":1,"TotalDeaths":20,"NewRecovered":11,"TotalRecovered":1263,"Date":"2020-05-02T18:46:23Z"},{"Country":"Nicaragua","CountryCode":"NI","Slug":"nicaragua","NewConfirmed":0,"TotalConfirmed":14,"NewDeaths":0,"TotalDeaths":3,"NewRecovered":0,"TotalRecovered":7,"Date":"2020-05-02T18:46:23Z"},{"Country":"Niger","CountryCode":"NE","Slug":"niger","NewConfirmed":9,"TotalConfirmed":728,"NewDeaths":1,"TotalDeaths":33,"NewRecovered":26,"TotalRecovered":478,"Date":"2020-05-02T18:46:23Z"},{"Country":"Nigeria","CountryCode":"NG","Slug":"nigeria","NewConfirmed":238,"TotalConfirmed":2170,"NewDeaths":10,"TotalDeaths":68,"NewRecovered":32,"TotalRecovered":351,"Date":"2020-05-02T18:46:23Z"},{"Country":"Niue","CountryCode":"NU","Slug":"niue","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Norfolk Island","CountryCode":"NF","Slug":"norfolk-island","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Northern Mariana Islands","CountryCode":"MP","Slug":"northern-mariana-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Norway","CountryCode":"NO","Slug":"norway","NewConfirmed":45,"TotalConfirmed":7783,"NewDeaths":0,"TotalDeaths":210,"NewRecovered":0,"TotalRecovered":32,"Date":"2020-05-02T18:46:23Z"},{"Country":"Oman","CountryCode":"OM","Slug":"oman","NewConfirmed":99,"TotalConfirmed":2447,"NewDeaths":0,"TotalDeaths":11,"NewRecovered":0,"TotalRecovered":495,"Date":"2020-05-02T18:46:23Z"},{"Country":"Pakistan","CountryCode":"PK","Slug":"pakistan","NewConfirmed":1297,"TotalConfirmed":18114,"NewDeaths":32,"TotalDeaths":417,"NewRecovered":400,"TotalRecovered":4715,"Date":"2020-05-02T18:46:23Z"},{"Country":"Palau","CountryCode":"PW","Slug":"palau","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Palestinian Territory","CountryCode":"PS","Slug":"palestine","NewConfirmed":9,"TotalConfirmed":353,"NewDeaths":0,"TotalDeaths":2,"NewRecovered":0,"TotalRecovered":76,"Date":"2020-05-02T18:46:23Z"},{"Country":"Panama","CountryCode":"PA","Slug":"panama","NewConfirmed":188,"TotalConfirmed":6720,"NewDeaths":4,"TotalDeaths":192,"NewRecovered":46,"TotalRecovered":622,"Date":"2020-05-02T18:46:23Z"},{"Country":"Papua New Guinea","CountryCode":"PG","Slug":"papua-new-guinea","NewConfirmed":0,"TotalConfirmed":8,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Paraguay","CountryCode":"PY","Slug":"paraguay","NewConfirmed":67,"TotalConfirmed":333,"NewDeaths":0,"TotalDeaths":10,"NewRecovered":2,"TotalRecovered":115,"Date":"2020-05-02T18:46:23Z"},{"Country":"Peru","CountryCode":"PE","Slug":"peru","NewConfirmed":3483,"TotalConfirmed":40459,"NewDeaths":73,"TotalDeaths":1124,"NewRecovered":724,"TotalRecovered":11129,"Date":"2020-05-02T18:46:23Z"},{"Country":"Philippines","CountryCode":"PH","Slug":"philippines","NewConfirmed":284,"TotalConfirmed":8772,"NewDeaths":11,"TotalDeaths":579,"NewRecovered":41,"TotalRecovered":1084,"Date":"2020-05-02T18:46:23Z"},{"Country":"Pitcairn","CountryCode":"PN","Slug":"pitcairn","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Poland","CountryCode":"PL","Slug":"poland","NewConfirmed":228,"TotalConfirmed":13105,"NewDeaths":7,"TotalDeaths":651,"NewRecovered":255,"TotalRecovered":3491,"Date":"2020-05-02T18:46:23Z"},{"Country":"Portugal","CountryCode":"PT","Slug":"portugal","NewConfirmed":306,"TotalConfirmed":25351,"NewDeaths":18,"TotalDeaths":1007,"NewRecovered":128,"TotalRecovered":1647,"Date":"2020-05-02T18:46:23Z"},{"Country":"Puerto Rico","CountryCode":"PR","Slug":"puerto-rico","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Qatar","CountryCode":"QA","Slug":"qatar","NewConfirmed":687,"TotalConfirmed":14096,"NewDeaths":2,"TotalDeaths":12,"NewRecovered":64,"TotalRecovered":1436,"Date":"2020-05-02T18:46:23Z"},{"Country":"Republic of Kosovo","CountryCode":"XK","Slug":"kosovo","NewConfirmed":7,"TotalConfirmed":806,"NewDeaths":0,"TotalDeaths":22,"NewRecovered":22,"TotalRecovered":271,"Date":"2020-05-02T18:46:23Z"},{"Country":"Romania","CountryCode":"RO","Slug":"romania","NewConfirmed":327,"TotalConfirmed":12567,"NewDeaths":27,"TotalDeaths":744,"NewRecovered":311,"TotalRecovered":4328,"Date":"2020-05-02T18:46:23Z"},{"Country":"Russian Federation","CountryCode":"RU","Slug":"russia","NewConfirmed":7933,"TotalConfirmed":114431,"NewDeaths":96,"TotalDeaths":1169,"NewRecovered":1601,"TotalRecovered":13220,"Date":"2020-05-02T18:46:23Z"},{"Country":"Rwanda","CountryCode":"RW","Slug":"rwanda","NewConfirmed":6,"TotalConfirmed":249,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":5,"TotalRecovered":109,"Date":"2020-05-02T18:46:23Z"},{"Country":"Réunion","CountryCode":"RE","Slug":"réunion","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Saint Helena","CountryCode":"SH","Slug":"saint-helena","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Saint Kitts and Nevis","CountryCode":"KN","Slug":"saint-kitts-and-nevis","NewConfirmed":0,"TotalConfirmed":15,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":2,"TotalRecovered":8,"Date":"2020-05-02T18:46:23Z"},{"Country":"Saint Lucia","CountryCode":"LC","Slug":"saint-lucia","NewConfirmed":0,"TotalConfirmed":17,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":15,"Date":"2020-05-02T18:46:23Z"},{"Country":"Saint Pierre and Miquelon","CountryCode":"PM","Slug":"saint-pierre-and-miquelon","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Saint Vincent and Grenadines","CountryCode":"VC","Slug":"saint-vincent-and-the-grenadines","NewConfirmed":0,"TotalConfirmed":16,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":8,"Date":"2020-05-02T18:46:23Z"},{"Country":"Saint-Barthélemy","CountryCode":"BL","Slug":"saint-barthélemy","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Saint-Martin (French part)","CountryCode":"MF","Slug":"saint-martin-french-part","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Samoa","CountryCode":"WS","Slug":"samoa","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"San Marino","CountryCode":"SM","Slug":"san-marino","NewConfirmed":11,"TotalConfirmed":580,"NewDeaths":0,"TotalDeaths":41,"NewRecovered":4,"TotalRecovered":82,"Date":"2020-05-02T18:46:23Z"},{"Country":"Sao Tome and Principe","CountryCode":"ST","Slug":"sao-tome-and-principe","NewConfirmed":2,"TotalConfirmed":16,"NewDeaths":1,"TotalDeaths":1,"NewRecovered":0,"TotalRecovered":4,"Date":"2020-05-02T18:46:23Z"},{"Country":"Saudi Arabia","CountryCode":"SA","Slug":"saudi-arabia","NewConfirmed":1344,"TotalConfirmed":24097,"NewDeaths":7,"TotalDeaths":169,"NewRecovered":392,"TotalRecovered":3555,"Date":"2020-05-02T18:46:23Z"},{"Country":"Senegal","CountryCode":"SN","Slug":"senegal","NewConfirmed":91,"TotalConfirmed":1024,"NewDeaths":0,"TotalDeaths":9,"NewRecovered":22,"TotalRecovered":356,"Date":"2020-05-02T18:46:23Z"},{"Country":"Serbia","CountryCode":"RS","Slug":"serbia","NewConfirmed":0,"TotalConfirmed":9009,"NewDeaths":0,"TotalDeaths":179,"NewRecovered":0,"TotalRecovered":1343,"Date":"2020-05-02T18:46:23Z"},{"Country":"Seychelles","CountryCode":"SC","Slug":"seychelles","NewConfirmed":0,"TotalConfirmed":11,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":6,"Date":"2020-05-02T18:46:23Z"},{"Country":"Sierra Leone","CountryCode":"SL","Slug":"sierra-leone","NewConfirmed":12,"TotalConfirmed":136,"NewDeaths":0,"TotalDeaths":7,"NewRecovered":0,"TotalRecovered":21,"Date":"2020-05-02T18:46:23Z"},{"Country":"Singapore","CountryCode":"SG","Slug":"singapore","NewConfirmed":932,"TotalConfirmed":17101,"NewDeaths":1,"TotalDeaths":16,"NewRecovered":24,"TotalRecovered":1268,"Date":"2020-05-02T18:46:23Z"},{"Country":"Slovakia","CountryCode":"SK","Slug":"slovakia","NewConfirmed":7,"TotalConfirmed":1403,"NewDeaths":0,"TotalDeaths":23,"NewRecovered":34,"TotalRecovered":558,"Date":"2020-05-02T18:46:23Z"},{"Country":"Slovenia","CountryCode":"SI","Slug":"slovenia","NewConfirmed":5,"TotalConfirmed":1434,"NewDeaths":1,"TotalDeaths":92,"NewRecovered":0,"TotalRecovered":233,"Date":"2020-05-02T18:46:23Z"},{"Country":"Solomon Islands","CountryCode":"SB","Slug":"solomon-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Somalia","CountryCode":"SO","Slug":"somalia","NewConfirmed":0,"TotalConfirmed":601,"NewDeaths":0,"TotalDeaths":28,"NewRecovered":0,"TotalRecovered":31,"Date":"2020-05-02T18:46:23Z"},{"Country":"South Africa","CountryCode":"ZA","Slug":"south-africa","NewConfirmed":304,"TotalConfirmed":5951,"NewDeaths":13,"TotalDeaths":116,"NewRecovered":309,"TotalRecovered":2382,"Date":"2020-05-02T18:46:23Z"},{"Country":"South Georgia and the South Sandwich Islands","CountryCode":"GS","Slug":"south-georgia-and-the-south-sandwich-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"South Sudan","CountryCode":"SS","Slug":"south-sudan","NewConfirmed":10,"TotalConfirmed":45,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Spain","CountryCode":"ES","Slug":"spain","NewConfirmed":0,"TotalConfirmed":213435,"NewDeaths":0,"TotalDeaths":24543,"NewRecovered":0,"TotalRecovered":112050,"Date":"2020-05-02T18:46:23Z"},{"Country":"Sri Lanka","CountryCode":"LK","Slug":"sri-lanka","NewConfirmed":27,"TotalConfirmed":690,"NewDeaths":0,"TotalDeaths":7,"NewRecovered":8,"TotalRecovered":162,"Date":"2020-05-02T18:46:23Z"},{"Country":"Sudan","CountryCode":"SD","Slug":"sudan","NewConfirmed":91,"TotalConfirmed":533,"NewDeaths":5,"TotalDeaths":36,"NewRecovered":7,"TotalRecovered":46,"Date":"2020-05-02T18:46:23Z"},{"Country":"Suriname","CountryCode":"SR","Slug":"suriname","NewConfirmed":0,"TotalConfirmed":10,"NewDeaths":0,"TotalDeaths":1,"NewRecovered":0,"TotalRecovered":8,"Date":"2020-05-02T18:46:23Z"},{"Country":"Svalbard and Jan Mayen Islands","CountryCode":"SJ","Slug":"svalbard-and-jan-mayen-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Swaziland","CountryCode":"SZ","Slug":"swaziland","NewConfirmed":6,"TotalConfirmed":106,"NewDeaths":0,"TotalDeaths":1,"NewRecovered":0,"TotalRecovered":12,"Date":"2020-05-02T18:46:23Z"},{"Country":"Sweden","CountryCode":"SE","Slug":"sweden","NewConfirmed":428,"TotalConfirmed":21520,"NewDeaths":67,"TotalDeaths":2653,"NewRecovered":0,"TotalRecovered":1005,"Date":"2020-05-02T18:46:23Z"},{"Country":"Switzerland","CountryCode":"CH","Slug":"switzerland","NewConfirmed":119,"TotalConfirmed":29705,"NewDeaths":17,"TotalDeaths":1754,"NewRecovered":500,"TotalRecovered":23900,"Date":"2020-05-02T18:46:23Z"},{"Country":"Syrian Arab Republic (Syria)","CountryCode":"SY","Slug":"syria","NewConfirmed":1,"TotalConfirmed":44,"NewDeaths":0,"TotalDeaths":3,"NewRecovered":6,"TotalRecovered":27,"Date":"2020-05-02T18:46:23Z"},{"Country":"Taiwan, Republic of China","CountryCode":"TW","Slug":"taiwan","NewConfirmed":0,"TotalConfirmed":429,"NewDeaths":0,"TotalDeaths":6,"NewRecovered":2,"TotalRecovered":324,"Date":"2020-05-02T18:46:23Z"},{"Country":"Tajikistan","CountryCode":"TJ","Slug":"tajikistan","NewConfirmed":0,"TotalConfirmed":15,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Tanzania, United Republic of","CountryCode":"TZ","Slug":"tanzania","NewConfirmed":0,"TotalConfirmed":480,"NewDeaths":0,"TotalDeaths":16,"NewRecovered":0,"TotalRecovered":167,"Date":"2020-05-02T18:46:23Z"},{"Country":"Thailand","CountryCode":"TH","Slug":"thailand","NewConfirmed":6,"TotalConfirmed":2960,"NewDeaths":0,"TotalDeaths":54,"NewRecovered":35,"TotalRecovered":2719,"Date":"2020-05-02T18:46:23Z"},{"Country":"Timor-Leste","CountryCode":"TL","Slug":"timor-leste","NewConfirmed":0,"TotalConfirmed":24,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":16,"Date":"2020-05-02T18:46:23Z"},{"Country":"Togo","CountryCode":"TG","Slug":"togo","NewConfirmed":7,"TotalConfirmed":123,"NewDeaths":0,"TotalDeaths":9,"NewRecovered":1,"TotalRecovered":66,"Date":"2020-05-02T18:46:23Z"},{"Country":"Tokelau","CountryCode":"TK","Slug":"tokelau","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Tonga","CountryCode":"TO","Slug":"tonga","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Trinidad and Tobago","CountryCode":"TT","Slug":"trinidad-and-tobago","NewConfirmed":0,"TotalConfirmed":116,"NewDeaths":0,"TotalDeaths":8,"NewRecovered":11,"TotalRecovered":83,"Date":"2020-05-02T18:46:23Z"},{"Country":"Tunisia","CountryCode":"TN","Slug":"tunisia","NewConfirmed":4,"TotalConfirmed":998,"NewDeaths":0,"TotalDeaths":41,"NewRecovered":11,"TotalRecovered":316,"Date":"2020-05-02T18:46:23Z"},{"Country":"Turkey","CountryCode":"TR","Slug":"turkey","NewConfirmed":2188,"TotalConfirmed":122392,"NewDeaths":84,"TotalDeaths":3258,"NewRecovered":4922,"TotalRecovered":53808,"Date":"2020-05-02T18:46:23Z"},{"Country":"Turkmenistan","CountryCode":"TM","Slug":"turkmenistan","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Turks and Caicos Islands","CountryCode":"TC","Slug":"turks-and-caicos-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Tuvalu","CountryCode":"TV","Slug":"tuvalu","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"US Minor Outlying Islands","CountryCode":"UM","Slug":"us-minor-outlying-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Uganda","CountryCode":"UG","Slug":"uganda","NewConfirmed":2,"TotalConfirmed":85,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":52,"Date":"2020-05-02T18:46:23Z"},{"Country":"Ukraine","CountryCode":"UA","Slug":"ukraine","NewConfirmed":455,"TotalConfirmed":10861,"NewDeaths":11,"TotalDeaths":272,"NewRecovered":175,"TotalRecovered":1413,"Date":"2020-05-02T18:46:23Z"},{"Country":"United Arab Emirates","CountryCode":"AE","Slug":"united-arab-emirates","NewConfirmed":557,"TotalConfirmed":13038,"NewDeaths":6,"TotalDeaths":111,"NewRecovered":114,"TotalRecovered":2543,"Date":"2020-05-02T18:46:23Z"},{"Country":"United Kingdom","CountryCode":"GB","Slug":"united-kingdom","NewConfirmed":6204,"TotalConfirmed":178685,"NewDeaths":741,"TotalDeaths":27583,"NewRecovered":33,"TotalRecovered":892,"Date":"2020-05-02T18:46:23Z"},{"Country":"United States of America","CountryCode":"US","Slug":"united-states","NewConfirmed":33928,"TotalConfirmed":1101811,"NewDeaths":1947,"TotalDeaths":64899,"NewRecovered":10068,"TotalRecovered":164015,"Date":"2020-05-02T18:46:23Z"},{"Country":"Uruguay","CountryCode":"UY","Slug":"uruguay","NewConfirmed":5,"TotalConfirmed":648,"NewDeaths":0,"TotalDeaths":17,"NewRecovered":18,"TotalRecovered":435,"Date":"2020-05-02T18:46:23Z"},{"Country":"Uzbekistan","CountryCode":"UZ","Slug":"uzbekistan","NewConfirmed":47,"TotalConfirmed":2086,"NewDeaths":0,"TotalDeaths":9,"NewRecovered":79,"TotalRecovered":1212,"Date":"2020-05-02T18:46:23Z"},{"Country":"Vanuatu","CountryCode":"VU","Slug":"vanuatu","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Viet Nam","CountryCode":"VN","Slug":"vietnam","NewConfirmed":0,"TotalConfirmed":270,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":219,"Date":"2020-05-02T18:46:23Z"},{"Country":"Virgin Islands, US","CountryCode":"VI","Slug":"virgin-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Wallis and Futuna Islands","CountryCode":"WF","Slug":"wallis-and-futuna-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-05-02T18:46:23Z"},{"Country":"Western Sahara","CountryCode":"EH","Slug":"western-sahara","NewConfirmed":0,"TotalConfirmed":6,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":5,"Date":"2020-05-02T18:46:23Z"},{"Country":"Yemen","CountryCode":"YE","Slug":"yemen","NewConfirmed":1,"TotalConfirmed":7,"NewDeaths":0,"TotalDeaths":2,"NewRecovered":0,"TotalRecovered":1,"Date":"2020-05-02T18:46:23Z"},{"Country":"Zambia","CountryCode":"ZM","Slug":"zambia","NewConfirmed":3,"TotalConfirmed":109,"NewDeaths":0,"TotalDeaths":3,"NewRecovered":19,"TotalRecovered":74,"Date":"2020-05-02T18:46:23Z"},{"Country":"Zimbabwe","CountryCode":"ZW","Slug":"zimbabwe","NewConfirmed":0,"TotalConfirmed":40,"NewDeaths":0,"TotalDeaths":4,"NewRecovered":0,"TotalRecovered":5,"Date":"2020-05-02T18:46:23Z"}],"Date":"2020-05-02T18:46:23Z"}');
//      var convertDataToJson = json.decode(response.body);
      var data = convertDataToJson['Global'];

      globalData = [];
      for (int i = 0; i < globalDataKeys.length; i++) {
        print(data[globalDataKeys[i]]);
        globalData.add(data[globalDataKeys[i]].toString());
      }
      globalData[0] = 'Worldwide';
//      if (response.statusCode == 200) {
      showToastMsg("Call Success", 0, Color(0xFF34C360));
//      } else {
//        showToastMsg("Call Failed", 0, Color(0xFFFA5252));
//      }
      print("gd:::" + globalData.toString());

      var countries = convertDataToJson['Countries'];
      countriesData = countries;
      print("type:::" + countriesData.runtimeType.toString());
      print("countries:::" + countries.length.toString());
    });

    return "Success";
  }

  void initState() {
    super.initState();
    getData();
  }

  String title = "";
  String totalDeaths = "";
  String newDeaths = "";
  String totalConfirmed = "";
  String newConfirmed = "";
  String totalRecovered = "";
  String newRecovered = "";

  void changeValue(selectedCountry) {
    for (int i = 0; i < countriesData.length; i++) {
      if (countriesData[i]['Country'] == selectedCountry) {
        setState(() {
          globalData[0] = countriesData[i]['Country'];
          globalData[4] = countriesData[i]['TotalDeaths'].toString();
          globalData[3] = countriesData[i]['NewDeaths'].toString();
          globalData[2] = countriesData[i]['TotalConfirmed'].toString();
          globalData[1] = countriesData[i]['NewConfirmed'].toString();
          globalData[6] = countriesData[i]['TotalRecovered'].toString();
          globalData[5] = countriesData[i]['NewRecovered'].toString();
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // navigation bar color
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
        body: new Column(
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
                      globalData[0],
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
                    padding: EdgeInsets.only(top: 0.0),
                    alignment: Alignment.topCenter,
                    tooltip: "Select Country",
                    color: Colors.yellow,
                    iconSize: 25,
                    splashColor: const Color(0xFFF2F6F8),
                    onPressed: () {
                      Navigator.pushNamed(context, '/location');
                    }),
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
                                'TOTAL DEATHS',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                globalData[4],
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
                                'NEW DEATHS',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                globalData[3],
                                style: TextStyle(
                                  fontSize: 30,
                                  color: const Color(0xFFFA5252),
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
                      // Long Row 1

//                      Card(
//                        color: Colors.white,
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(15.0),
//                        ),
//                        child: Padding(
//                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
//                          child: Row(
////                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              Expanded(
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Text(
//                                      'ACTIVE CASES',
//                                      style: TextStyle(
//                                        fontSize: 14,
//                                      ),
//                                    ),
//                                    Text(
//                                      '103,103',
//                                      style: TextStyle(
//                                        fontSize: 30,
//                                        color: const Color(0xFFF000000),
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                              ),
//                              Column(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceBetween,
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  Icon(
//                                    Icons.arrow_downward,
//                                    color: Color(0xFF34c360),
//                                    size: 15,
//                                  ),
//                                  SizedBox(
//                                    height: 20,
//                                  ),
//                                  Icon(
//                                    Icons.arrow_upward,
//                                    color: Color(0xFFfa5252),
//                                    size: 15,
//                                  ),
//                                ],
//                              ),
//                              SizedBox(
//                                width: 5,
//                              ),
//                              Column(
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  Text(
//                                    '55%',
//                                    style: TextStyle(
//                                      fontSize: 15,
//                                    ),
//                                  ),
//                                  Text(
//                                    'Mild Condition',
//                                    style: TextStyle(
//                                      fontSize: 10,
//                                      color: const Color(0xFFFAFB8BE),
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    height: 10,
//                                  ),
//                                  Text(
//                                    '45%',
//                                    style: TextStyle(
//                                      fontSize: 15,
//                                    ),
//                                  ),
//                                  Text(
//                                    'Critical Condition',
//                                    style: TextStyle(
//                                      fontSize: 10,
//                                      color: const Color(0xFFFAFB8BE),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),

                      // Long Row 2

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
                                    'TOTAL CONFIRMED',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    globalData[2],
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
                                    'NEW',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    globalData[1],
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'TOTAL RECOVERED',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    globalData[6],
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: const Color(0xFF34C360),
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
                                    'NEW',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    globalData[5],
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: const Color(0xFF34C360),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Long Row 3
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
//                          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
//                                  FlatButton(child: new Icon(Icons.backspace),onPressed: (){},),
                                  FlatButton(
                                    child: new Row(
                                      children: <Widget>[
                                        Visibility(
                                          visible: false,
                                          child: new Icon(Icons.search),
                                        ),
                                        Visibility(
                                            visible: true,
                                            child: Text(
                                              globalData[0],
                                              style: TextStyle(
                                                fontSize: 25,
                                              ),
                                            )),
                                        Visibility(
                                          visible: true,
                                          child: new Icon(Icons.backspace),
                                        ),
                                      ],
                                    ),
                                    onPressed: () async {
//                                      Navigator.push(context,MaterialPageRoute(builder: (context)=> ChooseLocation(countriesData)));
                                      final selectedCountry =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChooseLocation(
                                                          countriesData)));
                                      print("selectedCountry:::" +
                                          selectedCountry.toString());
                                      changeValue(selectedCountry.toString());
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
//                                width: 55,
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
    ));
  }
}
