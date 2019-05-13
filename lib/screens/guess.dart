import 'package:flutter/material.dart';
import 'package:fluttipedia/screens/result.dart';
import 'package:fluttipedia/widgets/targetCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GuessPageState();
}

int userGuess = 0;

class _GuessPageState extends State<GuessPage> {
  final String _targetKey = 'targetKey';
  final String _hopsKey = 'hopsKey';

  String _target = 'Philosophie'; // Default target
  static String _lang = 'de';
  static int _maxHops = 20; // Default max Hops
  int _currHops = 0;

  @override
  void initState() {
    _loadTarget();
    _loadHops();
  }

  _loadTarget() async {
    final prefs = await SharedPreferences.getInstance();
    String target = prefs.getString(_targetKey);

    this._target = target;
    debugPrint('Loaded persisted value \'$target\' with key \'$_targetKey\'.');
  }

  _loadHops() async {
    final prefs = await SharedPreferences.getInstance();
    int hops = prefs.getInt(_hopsKey);

    _maxHops = hops;
    _currHops = _maxHops ~/ 2;
    debugPrint('Loaded persisted value \'$hops\' with key \'$_hopsKey\'.');
  }

  // Test strings to use until I figure out how to read from a file :)
  static List<String> _testWords = [
    'Zeppelinwurst',
    'Blümchenkaffee',
    'Deppenleerzeichen',
    'Stuhltransplantation',
    'Schiebewurst',
    'Bastarda',
    'Joshua_Milton_Blahyi',
    'Leberknödel',
    'Bockbier',
    'Dachhase',
    'Phallografie',
    'Joseph_Pujol',
    'Panzerabwehrhund',
    'Landpomeranze',
    'Diogenes_von_Sinope',
    'Beaujolais',
    'Bielefeld-Verschwörung',
    'Mäusemilch',
    'Heilige_Vorhaut',
    'Wechselbalg',
    'Gemeine_Hundsrute',
    'Lyoner',
    'Rotkreuz_ZG',
    'Freßgass',
    'Andouillette',
    'Flavor_Flav',
    'Thomas,_die_kleine_Lokomotive',
    'Münchhausen-Zahl',
    'Pfannkuchen-Sortierproblem',
    'Gemeine_Hundsrute',
    'Bambiraptor',
    'Deo_volente',
    'Kinderkreuzzug',
    'Pampelmuse',
    'Jerusalemkreuz',
    'Truthahn-Illusion',
    'Kunstfurzer',
    'Coactus_feci',
    'Coca-Cola',
    'Absatzwirtschaft'
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
    return Scaffold(
      appBar: AppBar(title: Text('Fluttipedia')),
      backgroundColor: Color(0xffe6e6e6),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(children: [
          TargetCard(_target),
          Card(
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 14, 0, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Begriff'),
                    subtitle: Container(
                      // padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_prettify(_word)),
                          //Text('($_word)'),
                          RaisedButton(
                            elevation: 3,
                            child: Icon(
                              Icons.shuffle,
                              color: Colors.white,
                            ),
                            color: Theme.of(context).accentColor,
                            onPressed: _shuffle,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 14, 0, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Aufrufe'),
                    subtitle: Text(
                        'Schätze, wieviele Aufrufe es benötigt, bis das Ziel erreicht wurde.'),
                  ),
                  Slider(
                    value: _currHops.toDouble(),
                    min: 0,
                    max: _maxHops.toDouble(),
                    divisions: _maxHops,
                    label: 'What is your guess?',
                    onChanged: (double newVal) {
                      setState(() {
                        _currHops = newVal.toInt();
                        userGuess = _currHops;
                      });
                    },
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(14, 0, 14, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('0'),
                        Text(
                          _currHops < _maxHops ? _currHops.toString() : '∞',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('∞')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            child: RaisedButton(
              elevation: 3,
              color: Theme.of(context).accentColor,
              child: Text(
                'Los!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ResultPage(startWord: _word, guess: _currHops),
                    ));
              },
            ),
          ),
        ]),
      ),
    );
  }
}
