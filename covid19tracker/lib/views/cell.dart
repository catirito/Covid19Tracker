import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final data;

  Cell(this.data);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(data["country"],
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              new Container(
                height: 8.0,
              ),
              new Text(
                "Total cases: " + data["cases"].toString(),
                style:
                    new TextStyle(fontSize: 12.0),
              ),
              new Text(
                "Today cases: " + data["todayCases"].toString(),
                style:
                    new TextStyle(fontSize: 12.0),
              ),
            ],
          ),
        ),
        new Divider()
      ],
    );
  }
}
