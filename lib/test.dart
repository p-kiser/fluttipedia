import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TEST'),
      ),
      body: new Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: Text('-This is the TEST page-'),
        ),
      ),
    );
  }
}