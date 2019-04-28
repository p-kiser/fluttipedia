import 'dart:io';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResultPageState();
  }
}

class _ResultPageState extends State<ResultPage> {

  // TODO: replace with real word
  static String _word = 'Zeppelinwurst';

  List<String> _results = ['$_word', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test', 'test'
  ];

  List<Widget> _getResults(List<String> _results) {
    return _results.map((text) => Text(text)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Fluttipedia - Results')),
        body: Container(
          padding: EdgeInsets.all(42),
          child: ListView(
            children: <Widget>[
              Text('Resultate'),
              Column(
                children:
                _getResults(_results),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
