import 'package:flutter/material.dart';
import './cards/countryCard.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return searchCountries();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return searchCountries();
  }

  ListView searchCountries() {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList.where((country) =>
            country['country'].toString().toLowerCase().startsWith(query)).toList();
    
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return CountryCard(
        countryData: suggestionList,
        index: index,
      );
    });
  }
}
