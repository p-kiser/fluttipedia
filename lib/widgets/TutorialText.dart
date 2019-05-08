import 'package:flutter/material.dart';

class TutorialText extends StatelessWidget {
  
  final int _index;
  //static const int _NUM_OF_PAGES = 3;

  TutorialText(this._index);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(42),
      child: getInfoText()[_index]);
  }

  // buzzword generating engine framework
  static String _generateBuzzword() {

    // Random buzzwords for tutorial texts, expand as needed
    List<String> _buzzwordAdjective = ['hyperagile', 'Big Data', '5G NextGen',
    'Cross Plattform','Test Driven', 'Deep Learning', 'Datafication', 'SaaS',
    'PaaS', 'Bleeding Edge', 'Open Source', 'Machine Learning', ];
    List<String> _buzzwordNoun = ['Microservices', 'IoT-Device Cluster',
    'Artificial Neural Networks (ANN)', 'Quantum Computer', 'Hybrid-Clouds',
    'Blockchain Engines', 'Deep Web Services', 'Cloud-Algorithmen',
    'Crypto Container', ];

    return (_buzzwordAdjective..shuffle()).first + " " + (_buzzwordNoun..shuffle()).first;
  }

  List<RichText> getInfoText() {
    return [
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
              text: _generateBuzzword() + "\n", 
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
  }
}