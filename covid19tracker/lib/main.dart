import 'package:flutter/material.dart';
import './views/homePage.dart';

void main() => runApp(Covid19TrackerApp());

class Covid19TrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xffC42021),
          accentColor: Color(0xffE4999A),
          textTheme: TextTheme(
            title: TextStyle(
              color: Color(0xff084447),
            ),
            body1: TextStyle(color: Color(0xff084447),),
          )
          //textColor: Color(0xffC42021),
          ),
      home: HomePage(),
    );
  }
}
