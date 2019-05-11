import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  static String _target = 'Philosophie'; // Default target
  static int _hops = 10; // Default hops

  var _targetController = TextEditingController();
  var _hopsController = TextEditingController();

  final FocusNode _targetFocus = FocusNode();
  final FocusNode _hopsFocus = FocusNode();

  final String _targetKey = 'targetKey';
  final String _hopsKey = 'hopsKey';

  @override
  void initState() {
    _loadTarget();
    _loadHops();
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus) {
    currentFocus.unfocus();
  }

  _saveTarget(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_targetKey, value);
    debugPrint('Persisted value \'$value\' with key \'$_targetKey\'.');
  }

  _loadTarget() async {
    final prefs = await SharedPreferences.getInstance();
    String target = prefs.getString(_targetKey);

    _target = target;
    _targetController.text = _target;
    debugPrint('Loaded persisted value \'$target\' with key \'$_targetKey\'.');
  }

  _saveHops(String value) async {
    final prefs = await SharedPreferences.getInstance();
    int hops = int.parse(value);
    prefs.setInt(_hopsKey, hops);
    debugPrint('Persisted value \'$hops\' with key \'$_hopsKey\'.');
  }

  _loadHops() async {
    final prefs = await SharedPreferences.getInstance();
    int hops = prefs.getInt(_hopsKey);

    _hops = hops;
    _hopsController.text = _hops.toString();
    debugPrint('Loaded persisted value \'$hops\' with key \'$_hopsKey\'.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Fluttipedia')),
      backgroundColor: Color(0xffe6e6e6),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  controller: _targetController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  focusNode: _targetFocus,
                  onFieldSubmitted: (term) {
                    _saveTarget(_targetController.text);
                    _fieldFocusChange(context, _targetFocus);
                  },
                  decoration: InputDecoration(
                    labelText: 'Zielbegriff',
                    hintText: 'Gültiger Wikipedia-Begriff',
                    icon: Icon(Icons.radio_button_checked),
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  controller: _hopsController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _hopsFocus,
                  onFieldSubmitted: (term) {
                    _saveHops(_hopsController.text);
                    _fieldFocusChange(context, _hopsFocus);
                  },
                  decoration: InputDecoration(
                    labelText: 'Maximale Anzahl Aufrufe',
                    hintText: '2 - 99',
                    icon: Icon(Icons.functions),
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
