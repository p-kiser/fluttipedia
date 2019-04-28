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

  // Test strings to use until I figure out how to read from a file :)
  static List<String> _testWords =  [
    'Zeppelinwurst', 'Blümchenkaffee', 'Deppenleerzeichen', 'Stuhltransplantation',
    'Schiebewurst', 'Bastarda', 'Joshua_Milton_Blahyi', 'Leberknödel', 'Bockbier'
    'Dachhase', 'Phallografie', 'Joseph_Pujol', 'Panzerabwehrhund', 'Landpomeranze',
    'Diogenes_von_Sinope', 'Beaujolais', 'Bielefeld-Verschwörung', 'Mäusemilch',
    'Heilige_Vorhaut', 'Wechselbalg', 'Gemeine_Hundsrute', 'Lyoner',
  ];

  static String _path = 'assets/words_' + _lang + '.txt';
  //static File data = new File(_path);
  //List<String> _words = data.readAsLinesSync();
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
      home: Scaffold(
        appBar: AppBar(title: Text('Fluttipedia')),
        body: Center(
          child: Column(children: [
            Text('Begriff:'),
            Text(_prettify(_word)),
            //Text('($_word)'),
            RaisedButton(
              child: Icon(Icons.shuffle),
              onPressed: _shuffle,
            )
          ]),
        ),
      ),
    );
  }
}
