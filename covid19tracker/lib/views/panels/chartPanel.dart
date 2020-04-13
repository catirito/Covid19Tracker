import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter/material.dart';

class ChartPanel extends StatelessWidget {

  final List<double> historicalData;

  ChartPanel({this.historicalData});

  @override
  Widget build(BuildContext context) {
    var data = historicalData;

    return Container(
      margin: EdgeInsets.all(10),
      //width: 800,
      height: 150.0,
      child: new Sparkline(
        data: data,
        fillMode: FillMode.below,
        lineColor: Theme.of(context).primaryColor,
        fillColor: Theme.of(context).accentColor,
      ),
    );
  }
}
