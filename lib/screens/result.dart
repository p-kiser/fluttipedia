import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  final String startWord;
  final int guess;

  ResultPage({Key key, this.startWord, this.guess})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ResultPageState();
  }
}

class _ResultPageState extends State<ResultPage> {
  static final String _wikiPrefix = 'https://de.wikipedia.org/wiki/';
  static final String _url = 'https://skiapoden.herokuapp.com/firstlink';

// TODO: get from GuessPage
  int _guess = 6;
  static String _start = 'Zeppelinwurst';
  List<String> _res = [
    '$_start',
  ];
  List<Text> resultList;

  // TODO: get from config
  static int _max = 20;
  static String _lang = 'de';

  /// Get the first link in a wikipedia page via Skiapoden microservice:
  /// curl -X POST https://skiapoden.herokuapp.com/firstlink -d '{ "language": "en", "article": "Heroku" }'
  Future<String> getFirstLink(String _word) async {
    debugPrint('uri: $_url');
    String s;
    var _data = '{ "language": "$_lang", "article": "$_word" }';
    final response = await http.post(
        'https://skiapoden.herokuapp.com/firstlink',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
        },
        body: _data);
    if (response.statusCode < 200 || response.statusCode > 400) {
      throw new Exception("Error while fetching data");
    }
    // get word from response
    // TODO: using json.decode
    s = response.body
        .substring(14 + _wikiPrefix.length, response.body.length - 3);
    debugPrint('$_word >>> $s');
    return s;
  }

  List<Widget> _getResults(List<String> _res) {
    debugPrint('${_res.length}');
    return _res.map((text) => Text(text)).toList();
  }

  double _getPoints(int g, int r) {
    if (g == r && false) {
      return 10.0;
    } else {
      // TODO: More complex algorithm
      int difference = r > g ? r - g : g - r;

      double difficultyFactor = 1.0 + (r / 10);
      debugPrint('diff: $difference, factor: $difficultyFactor');
      return 100 * difficultyFactor - difference;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fluttipedia')),
      backgroundColor: Color(0xffe6e6e6),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      elevation: 3,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Nächster Begriff',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        _res.add(await getFirstLink(_res[_res.length - 1]));
                        setState(() {});
                      },
                    ),
                    RaisedButton(
                        elevation: 3,
                        color: Theme.of(context).accentColor,
                        child: Text(
                          'Neustarten',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            _res = [
                              _start,
                            ];
                          });
                        }),
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
                          Text('Effektive Aufrufe: ${_res.length - 1}')
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
                        Text('${_getPoints(_guess, _res.length)}'),
                      ],
                    ),
                  ),
                ],
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
                      title: Text('Aufgerufene Begriffe'),
                      subtitle: Column(
                        children: _getResults(_res),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
