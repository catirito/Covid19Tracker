import 'dart:convert';

import 'package:Covid19Tracker/views/panels/mostAffectedCountries.dart';

import './panels/worldPanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/countries');
    setState(() {
      countryData = json.decode(response.body);
      countryData.sort(
          (a, b) => b['active'].compareTo(a['active']));
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    fetchCountryData();
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
          // Container(
          //   height: 100,
          //   color: Colors.orange[100],
          //   alignment: Alignment.center,
          //   padding: EdgeInsets.all(10),
          //   child: Text('Text'),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'World status',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
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
              ],
            ),
          ),
          worldData == null
              ? CircularProgressIndicator()
              : WorldPanel(worldData: worldData),
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
