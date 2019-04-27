import 'package:flutter/material.dart';

class GuessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate mal!'),
      ),
      body: new Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/test');
          },
          child: Text('TEST'),
        ),
      ),
    );
  }
}