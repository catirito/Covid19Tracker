import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../countryDetailPage.dart';

class MostAffectedPanel extends StatelessWidget {
  final List countryData;

  const MostAffectedPanel({Key key, this.countryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CountryDetail(countryId: countryData[index]['countryInfo']['_id'], countryName: countryData[index]['country'],),
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Image.network(
                    countryData[index]['countryInfo']['flag'],
                    height: 30,
                    width: 50,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    countryData[index]['country'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Active:' + formatter.format(countryData[index]['active']),
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
