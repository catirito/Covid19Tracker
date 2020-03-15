import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid 19 Tracker',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Covid 19 Tracker'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}