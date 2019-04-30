
import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  TutorialPage({Key key }) : super(key: key);
   String title = "Fluttipedia - Anleitung";
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {

  int _page = 1;
  static const int _NUM_OF_PAGES = 3;

  // Random buzzwords for tutorial texts, expand as needed
  List<String> _buzzwordAdjective = ['hyperagile', 'Big Data', '5G NextGen',
  'Cross Plattform','Test Driven', 'Deep Learning', 'Datafication', 'SaaS',
  'PaaS', 'Bleeding Edge', 'Open Source', 'Machine Learning', ];
  List<String> _buzzwordNoun = ['Microservices', 'IoT-Device Cluster',
  'Artificial Neural Networks (ANN)', 'Quantum Computer', 'Hybrid-Clouds',
  'Blockchain Engines', 'Deep Web Services', 'Cloud-Algorithmen',
  'Crypto Container', ];

  // Dynamically generate tutorial content based on scientifically proven expressions
  List<RichText> getInfoText() {
    List<RichText> infoText = [
      RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: TextStyle(color: Colors.black87),
          children: <TextSpan>[
            TextSpan(text: 'Die Spielregeln sind simpel:\n\n'),
            TextSpan(text: 'Klicke im Inhaltteil eines beliebigen Wikipedia-Artikels auf den ersten Link, der weder '),
            TextSpan(text: 'kursiv', style: TextStyle(fontStyle: FontStyle.italic)),
            TextSpan(text: ' ist noch in (Klammern) steht.\n\n'),
            TextSpan(text: 'Wiederhole diesen Vorgang so lange, bis du auf der Seite "Philosophie" angelangt bist. Es kann in manchen Fällen jedoch vorkommen, dass kein Weg zum Ziel führt, wenn z.B. zwei Artikel aufeinander verweisen oder ein Artikel über keine Links verfügt, die den Spielregeln entsprechen.'),
          ],
        ),
      ),
      RichText(
        //textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: Colors.black87),
          children: <TextSpan>[
            TextSpan(text: 'Doch keine Angst, du musst keinen Internet Explorer auf deinem Handy installieren.\n\n'),
            TextSpan(text: ''),
            TextSpan(text: 'Die Fluttipedia™ App verwendet fortgeschrittene\n'),
            // Display dynamically loaded word because reasons
            TextSpan(
              text: (_buzzwordAdjective..shuffle()).first + " " + (_buzzwordNoun..shuffle()).first + "\n", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ), 
            TextSpan(text: 'die das Klicken für dich übernehmen. Alles was du tun musst, ist zu Raten, wie viele Klicks benötigt werden, um auf den Artikel "Philosophie" zu kommen.'),
          ] 
        ),
      ),
      RichText(
        //textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: Colors.black87),
          children: <TextSpan>[
            TextSpan(text: 'Basierend auf hochkomplexen, affektheuristischen Algorithmen vergibt dir Fluttipedia Punkte, je nachdem wie gut du geraten hast.\n\n'),
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 87.5),
        child: ListView(
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
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title
            ),
            Image.asset(
              'assets/img/skiapoden-trans.png',
              fit: BoxFit.scaleDown,
            ),
            Container(
              padding: EdgeInsets.all(42),
              child: getInfoText()[_page - 1],
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Visibility(
            child: FloatingActionButton(
              foregroundColor: Theme.of(context).accentColor,
              onPressed: _previousInfoPage,
              child: IconTheme(data: IconThemeData(
                  color: Colors.white),
                child: Icon(Icons.chevron_left),
              ),
            ),
            visible: _page > 1,
          ),
          Visibility(
            child: FloatingActionButton(
              onPressed: _nextInfoPage,
              foregroundColor: Theme.of(context).accentColor,
              child: IconTheme(data: IconThemeData(
                  color: Colors.white),
                  child: Icon(Icons.chevron_right)
              ),
            ),
            visible: _page < _NUM_OF_PAGES,
          ),
        ],
      ),
    );
  }
}