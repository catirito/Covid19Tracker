import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './views/cell.dart';

void main() => runApp(new Covid19TrackerApp());

class Covid19TrackerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Covid19State();
  }
}

class Covid19State extends State<Covid19TrackerApp> {
  var _isLoading = true;

  var data;

  _fetchData() async {
    print("Attempting to fetch data from network");

    final url = "https://corona.lmao.ninja/countries";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // print(response.body);

      final map = json.decode(response.body);

      // videosJson.forEach((video) {
      //   print(video["name"]);
      // });

      setState(() {
        _isLoading = false;
        this.data = map;
      });
    }
  }

  // @override
  //   void initState() {
  //     // TODO: implement initState
  //     super.initState();
  //     _fetchData();
  //   }

  @override
  Widget build(BuildContext context) {
    // return new MaterialApp();
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Covid 19 Tracker"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                print("Reloading...");
                setState(() {
                  _isLoading = true;
                });
                _fetchData();
              },
            )
          ],
        ),
        body: new Center(
          child: _isLoading
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount: this.data != null ? this.data.length : 0,
                  itemBuilder: (context, i) {
                    final countryData = this.data[i];
                    return new FlatButton(
                      padding: new EdgeInsets.all(0.0),
                      child: new Cell(countryData),
                      onPressed: () {
                        print("Video cell tapped: $i");
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new DetailPage()));
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Detail page"),
      ),
      body: new Center(
        child: new Text("Detail detail detail"),
      ),
    );
  }
}
