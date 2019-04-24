import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futtipedia',
      theme: ThemeData(
        // Theme of your application.
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Fluttipedia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0; // not used, part of the hello world template
  int _page = 1;

  static const List<String> _infoTexts = [
    
    'Die Spielregeln sind simpel: '
    'Klicke im Inhaltteil eines beliebigen Wikipedia-Artikels auf den ersten Link,'
    ' der weder kursiv ist noch in Klammern steht. Wiederhole diesen Vorgang so lange, '
    'bis du auf der Seite "Philosophie" angelangt bist. Es kann in manchen Fällen jedoch '
    'vorkommen, dass kein Weg zum Ziel führt, wenn z.B. zwei Artikel aufeinander verweisen '
    'oder ein Artikel über keine Links verfügt, die den Spielregeln entsprechen.',

    'Doch keine Angst, du musst keinen Internet Explorer auf deinem Handy installieren. '
    'Fluttipedia verwendet einen nextGen cloudbasierten AI-Microservice, der das Klicken für dich übernimmt. '
    'Alles was du tun musst, ist zu Raten, wie viele '
    'Klicks benötigt werden, um auf den Artikel "Philosophie" zu kommen.'
    ,
    'Basierend auf hochkomplexen, affektheuristischen Berechnungen vergibt dir Fluttipedia Punkte, je '
    'nachdem wie gut du geraten hast. Alles klar? Wunderbar!',

  ];

  void _nextInfoPage() {
    setState(() {
      
      if (_page < _infoTexts.length) {
        _page++;
        // TODO: next tutorial text
        debugPrint("Go to page $_page");
      } else {
        //TODO: start the game
        _startGame();
      }
    });
  }

  void _startGame() {
    setState(() {
      //  reset tutorial for debugging
      _page = 1;
      debugPrint("Start the game");
      // TODO: Start the game
    });
  }

  /* not used - part of the hello world template
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. 
      _counter++;
      debugPrint("Start pressed $_counter times.");
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // To invoke "debug painting" press "p" in the console

          mainAxisAlignment: MainAxisAlignment.center, // vertical alignment
          children: <Widget>[
            Text(
              "Spielregeln (${_page}/${_infoTexts.length})",
              style: Theme.of(context).textTheme.display1,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Center(
                    child: Text(
                      '"Getting to Philosophy"',
                      style: Theme.of(context).textTheme.subtitle
                    ),
                  ),
                  Center(
                    child: Image.asset(
                    'images/skiapoden.png',
                    width: 600,
                    fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      _infoTexts[_page-1],
                      softWrap: true,
                    ),
                  )
                ],
              )  
          ),
            RaisedButton(
              child: new Text(
                'Skip',
                style: new TextStyle(
                  fontSize:18.0,
                  //color: const Color(0xFFFAFAFA),
                  fontWeight: FontWeight.w200,
                  fontFamily: "Roboto"
                ),
              ),
              //color: Colors.deepPurpleAccent,
              // TODO: Go to start of the game
              onPressed: _startGame,
              
            ),
          ],
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: _nextInfoPage,
        tooltip: 'next Page',
        child: Icon(Icons.chevron_right),
      ),
    );
  }
}