import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter/material.dart';

class ChartPanel extends StatelessWidget {

  final List<double> historicalData;

  ChartPanel({this.historicalData});

  @override
  Widget build(BuildContext context) {
    var data = historicalData;

    return Container(
      width: 300.0,
      height: 100.0,
      child: new Sparkline(
        data: data,
        fillMode: FillMode.below,
        lineColor: Colors.red,
        fillColor: Colors.red[100],
      ),
    );
  }
}
