import 'package:flutter/material.dart';

import '../countryDetailPage.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({
    Key key,
    @required this.countryData,
    @required this.index,
  }) : super(key: key);

  final List countryData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CountryDetail(countryId: countryData[index]['countryInfo']['_id'], countryName: countryData[index]['country'],),
              ),
            );
          },
        child: Container(
          //height: 130,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey[100], blurRadius: 10, offset: Offset(0, 10)),
          ]),
          child: Row(
            children: <Widget>[
              Container(
                width: 100,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        countryData[index]['country'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Image.network(
                        countryData[index]['countryInfo']['flag'],
                        height: 50,
                        width: 60,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'CONFIRMED:' + countryData[index]['cases'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                      Padding(padding: EdgeInsets.all(4)),
                      Text(
                        'ACTIVE:' + countryData[index]['active'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      Padding(padding: EdgeInsets.all(4)),
                      Text(
                        'RECOVERED:' + countryData[index]['recovered'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      Padding(padding: EdgeInsets.all(4)),
                      Text(
                        'DEATHS:' + countryData[index]['deaths'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
