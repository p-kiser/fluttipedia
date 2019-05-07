import 'package:flutter/material.dart';

class TargetCard extends StatelessWidget {
	
  final String _target;

  TargetCard(this._target);
  
  Widget build(context) {
		return new Card(
      elevation: 3,
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text('Ziel'),
          subtitle: Text('$_target'),
        ),
      ],
    ),
  );
	}
}


