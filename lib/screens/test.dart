import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TEST'),
      ),
      body: Column(
        children:<Widget>[
          RaisedButton(
            onPressed: () { Navigator.pushNamed(context, '/'); },
            child: Text('Back to Fluttipedia'),
          ),
        ],
      ),
    );
  }
}