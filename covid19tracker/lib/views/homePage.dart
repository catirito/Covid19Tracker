import 'dart:convert';

import './panels/worldPanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map worldData;
  fetchWorldWideData()async{
    http.Response response = await http.get('https://corona.lmao.ninja/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchWorldWideData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid-19 Tracker"),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          // Container(
          //   height: 100,
          //   color: Colors.orange[100],
          //   alignment: Alignment.center,
          //   padding: EdgeInsets.all(10),
          //   child: Text('Text'),
          // )
          worldData == null?CircularProgressIndicator():WorldPanel(worldData: worldData),
        ],)
      ),
    );
  }
}