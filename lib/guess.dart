import 'dart:io';
import 'package:flutter/material.dart';

class GuessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GuessPageState();
  }
}

class _GuessPageState extends State<GuessPage> {

  // TODO: get this from config
  String _target = 'Philosophie';
  static String _lang = 'de';
  static int _maxVal = 20;
  int _val = _maxVal ~/ 2;

  // Test strings to use until I figure out how to read from a file :)
  static List<String> _testWords =  [
    'Zeppelinwurst', 'Blümchenkaffee', 'Deppenleerzeichen', 'Stuhltransplantation',
    'Schiebewurst', 'Bastarda', 'Joshua_Milton_Blahyi', 'Leberknödel', 'Bockbier',
    'Dachhase', 'Phallografie', 'Joseph_Pujol', 'Panzerabwehrhund', 'Landpomeranze',
    'Diogenes_von_Sinope', 'Beaujolais', 'Bielefeld-Verschwörung', 'Mäusemilch',
    'Heilige_Vorhaut', 'Wechselbalg', 'Gemeine_Hundsrute', 'Lyoner', 'Rotkreuz_ZG'
  ];

  // static String _path = 'assets/words_' + _lang + '.txt';
  // static File data = new File(_path);
  // List<String> _words = data.readAsLinesSync();
  static var _words = _testWords;

  static String _word = _getRandom(_words);

  void _shuffle() {
    setState(() {
      _word = _getRandom(_words);
      debugPrint('New word: $_word');      
    });
  }

  static String _getRandom(_words) {
    return (_words..shuffle()).first;
  }
  static String _prettify(String word) {
    // undo the urlification
    word = word.replaceAll('_', ' ');
    return word;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(title: Text('Fluttipedia - Guess')),
        body: Container(
          padding: EdgeInsets.all(42),
          child: Column(children: [
            Text('Ziel: $_target'),
            Divider(),
            Text('Begriff:', style: TextStyle(fontSize: 24),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_prettify(_word)),
                //Text('($_word)'),
                RaisedButton(
                  child: Icon(Icons.shuffle),
                  onPressed: _shuffle,
                ),
              ],
            ),
            Divider(),
            Slider(
              value: _val.toDouble(),
              min: 0,
              max: _maxVal.toDouble(),
              divisions: _maxVal,
              label: 'What is your guess?',
              onChanged: (double newVal) {
                setState(() {
                  _val = newVal.toInt();
                  debugPrint('$_val');
                });
              },
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('0'),
                Text(
                  _val < _maxVal ? _val.toString() : '∞',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('∞')
              ],
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                child: Text('Try it'),
                onPressed: () { Navigator.pushNamed(context, '/result'); },  
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
