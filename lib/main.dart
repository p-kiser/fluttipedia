import 'package:flutter/material.dart';
import 'package:fluttipedia/guess.dart';
import 'package:fluttipedia/test.dart';
import 'package:fluttipedia/tutorial.dart';

void main() => runApp(FluttiApp());

class FluttiApp extends StatelessWidget {
  // Root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futtipedia',
      theme: ThemeData( primarySwatch: Colors.deepPurple ),
      home: HomePage(),
      //initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/tutorial': (context) => TutorialPage(),
        '/guess': (context) => GuessPage(),
        // '/game': (context) => GamePage(),
        // '/result': (context) => ResultPage(),
        // '/config': (context) => ConfigPage(),
        '/test': (context) => TestPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fluttipedia'),
      ),
      body: Container(
        padding: EdgeInsets.all(42),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Fluttipedia v 0.1.1',
                style: Theme.of(context).textTheme.display1,
              ),
              RaisedButton(
                onPressed: () { Navigator.pushNamed(context, '/tutorial'); },
                child: Text('Tutorial'),
              ),
              RaisedButton(
                onPressed: () { Navigator.pushNamed(context, '/guess'); },
                child: Text('Start the game'),
              ),       
              RaisedButton(
                onPressed: () { Navigator.pushNamed(context, '/test'); },
                child: Text('DEBUG_PAGE'),
            ),
          ],)
          

        //),
      ),
    );
  }
}

