import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResultPageState();
  }
}

class _ResultPageState extends State<ResultPage> {

  // TODO: get from config
  static int _max = 20;
  static String _lang = 'de';

  // TODO: get from GuessPage
  static int _guess = 6;
  static String _word = 'Zeppelinwurst';
  List<String> _results = ['$_word',];

  List<String> _dummyResults = ['Zeppelinwurst', 'Leberwurst', 'Kochwurst', 'Wurst', 'Nahrungsmittel', 'Lebensmittel', 'Menschlicher_Körper', 'Materie_(Philosophie)', 'Philosophie'];

  
  /* Fetching from teh interwebz */
  //curl -X POST https://skiapoden.herokuapp.com/firstlink -d '{ "language": "en", "article": "Heroku" }'

  void fetchPost() async {

    String url = 'https://skiapoden.herokuapp.com/firstlink -d \'{ "language": "$_lang", "article": "$_word" }\'';
    final response = await http.post(url);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      debugPrint('Got dis from interwebz: $response.body');
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

 
  List<Widget> _getResults(List<String> _results) {
    fetchPost();
    return _dummyResults.map((text) => Text(text)).toList();
    //return _results.map((text) => Text(text)).toList();
  }

  String getNext(String word) {
    // TODO: recursively get from linked list via HTTP
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(title: Text('Fluttipedia - Resultate')),
        body: Container(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text('Aufgerufene Begriffe'),
                        subtitle: Column(
                          children:
                          _getResults(_results),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text('Auswertung'),
                        subtitle: Column(
                          children: <Widget>[
                            Text('Geratene Aufrufe: $_guess'),
                            Text('Effektive Aufrufe: ${_dummyResults.length-1}')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text('Punktzahl'),
                      subtitle: Column(
                        children: <Widget>[
                          Text('1.5'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
