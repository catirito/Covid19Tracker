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

  List<double> historicalData;

  fetchHistoricalData() async {
    http.Response response = await http
        .get('https://corona.lmao.ninja/v2/historical/all?lastdays=all');
    setState(() {
      var data = json.decode(response.body);

      var cases = data['cases'].map((a, b) => MapEntry(a, b));
      var deaths = data['deaths'].map((a, b) => MapEntry(a, b));
      var recovered = data['recovered'].map((a, b) => MapEntry(a, b));

      historicalData = [];
      cases.forEach((k, v) => {
            historicalData
                .add((cases[k] - deaths[k] - recovered[k]).toDouble()),
          });
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/countries?sort=active');
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
        title: Text(
          "Covid-19 Tracker",
          style: Theme.of(context).textTheme.title,
        ),
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
                        color: Theme.of(context).textTheme.body1.color,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Countries',
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
