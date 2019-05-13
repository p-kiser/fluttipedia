import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttipedia/screens/guess.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ResultPage extends StatefulWidget {
  final String startWord;
  final int guess;

  ResultPage({Key key, this.startWord, this.guess})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ResultPageState(startWord, guess);
  }
}

class _ResultPageState extends State<ResultPage> {
  static final String _wikiPrefix = 'https://de.wikipedia.org/wiki/';

  // values from shared preferences
  int _max = 20;
  String _lang = 'de';
  String target = 'Philosophie';
  // values from GuessPage
  int guess;
  String startWord;

  bool _isTarget = false;
  bool _isLoop = false;
  bool _isMax = false;

  List<String> _res;
  _ResultPageState(this.startWord, this.guess);

  @override
  void initState() {
    _getSharedPrefences();
    _initResultList();
  }

  void _initResultList() {
    _res = ['$startWord'];
    _isLoop = false;
    _isTarget = false;
    _isMax = false;
  }

  void _getSharedPrefences() async {
    final prefs = await SharedPreferences.getInstance();
    this.target = prefs.getString('targetKey');
    this._max = prefs.getInt('hopsKey');
    debugPrint('SharedPrefs: max=$_max, target=$target');
  }

  // Get the first link in a wikipedia page via Skiapoden microservice
  Future<String> _getFirstLink(String _word) async {
    final response = await http.post(
      'https://skiapoden.herokuapp.com/firstlink',
      headers: { HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded' },
      body: '{ "language": "$_lang", "article": "$_word" }'
    );
    if (response.statusCode < 200 || response.statusCode > 400) {
      throw new Exception("Error while fetching data");
    }
    String s = response.body;
    return s.substring(14 + _wikiPrefix.length, s.length - 3);
  }

  List<Widget> _getResultList(List<String> _res) {
    return _res.map((text) => Text(text)).toList();
  }

  void _getNext() async{
    // get next word
    int i = _res.length - 1;
    String next = await _getFirstLink(_res[i]);
    

    // redraw
    setState(() {
      // check if max is reached
     if (i >= _max) {
      _isMax = true;
      debugPrint("Maximum reached!");
    }
    // check for loop
    if (_res.contains(next)) {
      _isLoop = true;
      debugPrint("Loop!");
    }
    _res.add(next);
    // check if target
    if (next == target) {
      _isTarget = true;
    }     
    });
  }

  double _getPoints() {
    double highscore = 25.0;
    if (_isLoop || _isMax) { 
      if (guess == _max) return highscore;
      else return 0.0;
    }
    int g = guess;
    int r = _res.length-1;
    int diff = r>g ? r-g : g-r;
    double fac = (diff*diff) / 2;
    var score = highscore - fac;
    return score > 0 ? score : 0.0;
  }

  _isGameOver() {
    return _isLoop || _isTarget || _isMax;
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
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Text(
                        '$startWord  ➡ $target',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Visibility(
                          visible: !_isGameOver(),
                          child: RaisedButton(
                            elevation: 3,
                            color: Theme.of(context).accentColor,
                            child: Text(
                              'Nächster Begriff',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: _getNext,
                          ),
                        ),                            
                      ],
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
                      title: Text('Aufgerufene Begriffe'),
                      subtitle: Column(
                        children: _getResultList(_res),
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
                      title: Text('Auswertung'),
                      subtitle: Column(
                        children: <Widget>[
                          Text('Geratene Aufrufe: $guess'),
                          Text('Effektive Aufrufe: ${_res.length - 1}')
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _isMax,
                      child: Text('Maximale Anzahl Versuche erreicht ($_max)!'),
                    ),
                    Visibility(
                      visible: _isLoop,
                      child: Text('Endlosschleife :('),
                    ),
                    Visibility(
                      visible: _isTarget,
                      child: Text('$target erreicht!'),
                    ),

                  Visibility(
                    visible: _isGameOver(),
                    child: ListTile(
                      title: Text('Punktzahl'),
                      subtitle: Column(
                        children: <Widget>[
                          Text('${_getPoints()}',style: TextStyle(fontSize: 24)),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isGameOver(),
                    child: RaisedButton(
                      elevation: 3,
                      color: Theme.of(context).accentColor,
                      child: Text(
                        'Neues Spiel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GuessPage(),
                          )
                        );
                      },
                  ),
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
