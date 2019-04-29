
import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  TutorialPage({Key key }) : super(key: key);
   String title = "Fluttipedia - Tutorial";
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {

  int _page = 1;
  static const int _NUM_OF_PAGES = 3;

  // random buzzwords for tutorial texts, expand as needed
  List<String> _buzzwordAdjective = ['hyperagile', 'Big Data', '5G NextGen',
  'Cross Plattform','Test Driven', 'Deep Learning', 'Datafication', 'SaaS',
  'PaaS', 'Bleeding Edge', 'Open Source', 'Machine Learning', ];
  List<String> _buzzwordNoun = ['Microservices', 'IoT-Device Cluster',
  'Artificial Neural Networks (ANN)', 'Quantum Computer', 'Hybrid-Clouds',
  'Blockchain Engines', 'Deep Web Services', 'Cloud-Algorithmen',
  'Crypto Container', ];

  // dynamically generate tutorial content based on random bs list
  List<RichText> getInfoText() {
    List<RichText> infoText = [
      RichText(
        //textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: Colors.black87),
          children: <TextSpan>[
            TextSpan(text: 'Die Spielregeln sind simpel:'),
            TextSpan(text: '\n\n'),
            TextSpan(text: 'Klicke im Inhaltteil eines beliebigen Wikipedia-Artikels '),
            TextSpan(text: 'auf den ersten Link, der weder '),
            TextSpan(text: 'kursiv', style: TextStyle(fontStyle: FontStyle.italic)),
            TextSpan(text: ' ist noch in (Klammern) steht.'),
            TextSpan(text: '\n\n'), 
            TextSpan(text: 'Wiederhole diesen Vorgang so lange, '),
            TextSpan(text: 'bis du auf der Seite "Philosophie" angelangt bist. Es kann in manchen Fällen jedoch '),
            TextSpan(text: 'vorkommen, dass kein Weg zum Ziel führt, wenn z.B. zwei Artikel aufeinander verweisen '),
            TextSpan(text: 'oder ein Artikel über keine Links verfügt, die den Spielregeln entsprechen.'),
          ],
        ),
      ),
      RichText(
        //textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: Colors.black87),
          
          children: <TextSpan>[
            TextSpan(text: 'Doch keine Angst, du musst keinen Internet Explorer '),
            TextSpan(text: 'auf deinem Handy installieren.\n\n'),
            TextSpan(text: 'Die Fluttipedia™ App verwendet fortgeschrittene\n '),
            // bs description of the skiadopen microservice
            TextSpan(
              text: (_buzzwordAdjective..shuffle()).first + " " + (_buzzwordNoun..shuffle()).first + "\n", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ), 
            TextSpan(text: 'die das Klicken für dich übernehmen. Alles was du tun musst, ist zu Raten, wie viele '),
            TextSpan(text: 'Klicks benötigt werden, um auf den Artikel "Philosophie" zu kommen.'),
          ] 
        ),
      ),
      RichText(
        //textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: Colors.black87),
          children: <TextSpan>[
            TextSpan(text: 'Basierend auf hochkomplexen, affektheuristischen Algorithmen '),
            TextSpan(text: 'vergibt dir Fluttipedia Punkte, je nachdem wie gut du geraten hast.'),
            TextSpan(text: '\n\n'),
            TextSpan(text: 'Alles klar? Wunderbar!'),
          ] 
        ),
      ),
    ];
    return infoText;
  }

  void _previousInfoPage() { setState( () { if (_page > 1) _page--; }); }

  void _nextInfoPage() { setState(() {
      if (_page < _NUM_OF_PAGES) { _page++;
        debugPrint("Go to page $_page");
      } else { _startGame(); }
    });
  }

  void _startGame() {
    setState(() {
      _page = 1; // reset tutorial
      // TODO: Start the game
      debugPrint("Start the game");
      Navigator.pushNamed(context, '/guess');
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // vertical alignment
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(24),
              child: Text(
                'Getting to Philosophy',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            Text(
              'Fluttorial ($_page/$_NUM_OF_PAGES)',
              style: Theme.of(context).textTheme.subtitle
            ),
            Image.asset(
              'assets/img/skiapoden-trans.png',
              width: 600,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(42),
              child: getInfoText()[_page - 1],
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Visibility(
            child: FloatingActionButton(
              onPressed: _previousInfoPage,
              tooltip: 'previous Page',
              child: Icon(Icons.chevron_left),
            ),
            visible: _page > 1,
          ),
          MaterialButton(
            child: new Text( _page == 3 ? 'Start' : 'Skip' ),
            onPressed: _startGame
          ),
          Visibility(
            child: FloatingActionButton(
              onPressed: _nextInfoPage,
              tooltip: 'next Page',
              child: Icon(Icons.chevron_right),
            ),
            visible: _page < _NUM_OF_PAGES,            
          ),
        ],
      ),
    );
  }
}