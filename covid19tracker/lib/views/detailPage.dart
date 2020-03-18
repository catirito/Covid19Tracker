import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final data;

  DetailPage(this.data);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(data["country"]),
      ),
      body: new Center(
        child: new Text("Detail detail detail"),
        
      ),
    );
  }
}