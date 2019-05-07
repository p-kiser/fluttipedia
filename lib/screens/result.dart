import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


class ResultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResultPageState();
  }
}


class _ResultPageState extends State<ResultPage> {

  static final String WIKI_PREFIX = 'https://de.wikipedia.org/wiki/';
  static final String _url = 'https://skiapoden.herokuapp.com/firstlink';

  static String _start = 'Zeppelinwurst';
  List<String> _res= ['$_start',];
  List<Text> resultList;

  // TODO: get from config
  static int _max = 20;
  static String _lang = 'de';

  // TODO: get from GuessPage
  int _guess = 6;
  /* Fetching from teh interwebz */
  //curl -X POST https://skiapoden.herokuapp.com/firstlink -d '{ "language": "en", "article": "Heroku" }'
  
  
  Future<String> getFirstLink(String _word)  async {

    debugPrint('uri: $_url');
    var _data = '{ "language": "$_lang", "article": "$_word" }';
    final response = await http.post(
      'https://skiapoden.herokuapp.com/firstlink',
      headers: { HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded' },
      body: _data
    );
    // TODO: some proper error handling
    if (response.statusCode == 200) {
      // get word from response
      // TODO: using json.decode
      String s = response.body.substring(14+WIKI_PREFIX.length, response.body.length-3);
      debugPrint('$_word >>> $s');
      return s;
    } 
  }

  List<Widget> _getResults(List<String> _res) {
    debugPrint('${_res.length}');
    //return _dummyResults.map((text) => Text(text)).toList();
    return _res.map((text) => Text(text)).toList();
  }

  String getNext(String word) {
    // TODO: recursively get from linked list via HTTP
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: Scaffold(
        appBar: AppBar(title: Text('Fluttipedia™')),
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
                          _getResults(_res),
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
                            Text('Effektive Aufrufe: ${_res.length-1}')
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
              RaisedButton(
                child: Text('Test'),
                onPressed: () async {
                  _res.add(await getFirstLink(_res[_res.length-1]));
                  setState(() {
                    //
                  });
                },
              ),
              RaisedButton(
                child: Text('Empty List'),
                onPressed: () {
                  setState(() {
                    _res = [_start,];
                  });
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
