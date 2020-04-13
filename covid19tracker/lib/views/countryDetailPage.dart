import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './panels/chartPanel.dart';
import './panels/worldPanel.dart';

class CountryDetail extends StatefulWidget {
  final int countryId;
  final String countryName;

  const CountryDetail({Key key, this.countryId, this.countryName}) : super(key: key);

  @override
  _CountryDetailState createState() => _CountryDetailState(countryId, countryName);
}

class _CountryDetailState extends State<CountryDetail> {
  final int countryId;
  final String countryName;

  _CountryDetailState(this.countryId, this.countryName);

  
  List<double> historicalData;
  fetchHistoricalData() async {
    http.Response response = await http
        .get('https://corona.lmao.ninja/v2/historical/$countryId?lastdays=all');
    setState(() {
      var data = json.decode(response.body)['timeline'];
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

  Map countryData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/all');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    fetchHistoricalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$countryName Stats'),
      ),
      body: Column(
        children: <Widget>[
          countryData == null
              ? CircularProgressIndicator()
              : WorldPanel(worldData: countryData),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  countryName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                
              ],
            ),
          ),
          
          historicalData == null
            ? CircularProgressIndicator()
            : ChartPanel(historicalData: historicalData),
        ],
      )
    );
  }
}
