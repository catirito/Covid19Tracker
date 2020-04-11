import 'dart:collection';
import 'dart:convert';

import './panels/mostAffectedCountries.dart';
import './panels/worldPanel.dart';
import './panels/chartPanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'countryPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  Map<String, double> historicalData;

  fetchHistoricalData() async {
    historicalData = Map<String, double>();
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/historical?lastdays=all');
    setState(() {
      var dates =
          json.decode(response.body).map((h) => {h['timeline']['cases']});
      print(dates.runtimeType);

      dates.forEach((d) => {
            d.forEach((f) => {
                  f.forEach((a, b) => {
                        if (historicalData[a] == null)
                          {
                            historicalData[a] = b.toDouble(),
                          }
                        else
                          {
                            historicalData[a] = historicalData[a] + b.toDouble(),
                          }
                      }),
                })
          });
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/countries');
    setState(() {
      countryData = json.decode(response.body);
      countryData.sort((a, b) => b['active'].compareTo(a['active']));
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    fetchCountryData();
    fetchHistoricalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid-19 Tracker"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'World status',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountryPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Regional',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          worldData == null
              ? CircularProgressIndicator()
              : WorldPanel(worldData: worldData),
          historicalData == null
              ? CircularProgressIndicator()
              : ChartPanel(historicalData: historicalData),
          Text(
            'Most affected countries',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          countryData == null
              ? CircularProgressIndicator()
              : MostAffectedPanel(countryData: countryData),
        ],
      )),
    );
  }
}
