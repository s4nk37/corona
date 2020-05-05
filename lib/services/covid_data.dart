// To parse this JSON data, do
//
//     final countries = countriesFromJson(jsonString);

import 'dart:convert';

List<Countries> countriesFromJson(String str) => List<Countries>.from(json.decode(str).map((x) => Countries.fromJson(x)));

String countriesToJson(List<Countries> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Countries {
  int updated;
  String country;
  CountryInfo countryInfo;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  int casesPerOneMillion;
  int deathsPerOneMillion;
  int tests;
  int testsPerOneMillion;
  Continent continent;

  Countries({
    this.updated,
    this.country,
    this.countryInfo,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
    this.continent,
  });

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
    updated: json["updated"] == null ? null : json["updated"],
    country: json["country"] == null ? null : json["country"],
    countryInfo: json["countryInfo"] == null ? null : CountryInfo.fromJson(json["countryInfo"]),
    cases: json["cases"] == null ? null : json["cases"],
    todayCases: json["todayCases"] == null ? null : json["todayCases"],
    deaths: json["deaths"] == null ? null : json["deaths"],
    todayDeaths: json["todayDeaths"] == null ? null : json["todayDeaths"],
    recovered: json["recovered"] == null ? null : json["recovered"],
    active: json["active"] == null ? null : json["active"],
    critical: json["critical"] == null ? null : json["critical"],
    casesPerOneMillion: json["casesPerOneMillion"] == null ? null : json["casesPerOneMillion"],
    deathsPerOneMillion: json["deathsPerOneMillion"] == null ? null : json["deathsPerOneMillion"],
    tests: json["tests"] == null ? null : json["tests"],
    testsPerOneMillion: json["testsPerOneMillion"] == null ? null : json["testsPerOneMillion"],
    continent: json["continent"] == null ? null : continentValues.map[json["continent"]],
  );

  Map<String, dynamic> toJson() => {
    "updated": updated == null ? null : updated,
    "country": country == null ? null : country,
    "countryInfo": countryInfo == null ? null : countryInfo.toJson(),
    "cases": cases == null ? null : cases,
    "todayCases": todayCases == null ? null : todayCases,
    "deaths": deaths == null ? null : deaths,
    "todayDeaths": todayDeaths == null ? null : todayDeaths,
    "recovered": recovered == null ? null : recovered,
    "active": active == null ? null : active,
    "critical": critical == null ? null : critical,
    "casesPerOneMillion": casesPerOneMillion == null ? null : casesPerOneMillion,
    "deathsPerOneMillion": deathsPerOneMillion == null ? null : deathsPerOneMillion,
    "tests": tests == null ? null : tests,
    "testsPerOneMillion": testsPerOneMillion == null ? null : testsPerOneMillion,
    "continent": continent == null ? null : continentValues.reverse[continent],
  };
}

enum Continent { ASIA, EUROPE, AFRICA, NORTH_AMERICA, SOUTH_AMERICA, AUSTRALIA_OCEANIA, EMPTY }

final continentValues = EnumValues({
  "Africa": Continent.AFRICA,
  "Asia": Continent.ASIA,
  "Australia/Oceania": Continent.AUSTRALIA_OCEANIA,
  "": Continent.EMPTY,
  "Europe": Continent.EUROPE,
  "North America": Continent.NORTH_AMERICA,
  "South America": Continent.SOUTH_AMERICA
});

class CountryInfo {
  int id;
  String iso2;
  String iso3;
  double lat;
  double long;
  String flag;

  CountryInfo({
    this.id,
    this.iso2,
    this.iso3,
    this.lat,
    this.long,
    this.flag,
  });

  factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
    id: json["_id"] == null ? null : json["_id"],
    iso2: json["iso2"] == null ? null : json["iso2"],
    iso3: json["iso3"] == null ? null : json["iso3"],
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    long: json["long"] == null ? null : json["long"].toDouble(),
    flag: json["flag"] == null ? null : json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "iso2": iso2 == null ? null : iso2,
    "iso3": iso3 == null ? null : iso3,
    "lat": lat == null ? null : lat,
    "long": long == null ? null : long,
    "flag": flag == null ? null : flag,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
