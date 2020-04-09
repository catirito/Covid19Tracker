import 'package:flutter/material.dart';
import './views/homePage.dart';

void main() => runApp(Covid19TrackerApp());

class Covid19TrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
  debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff202c3b),
      ),
      home: HomePage(),
    );
  }
}