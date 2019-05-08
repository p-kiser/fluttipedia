
import 'package:flutter/material.dart';
import 'package:fluttipedia/widgets/TutorialText.dart';

class TutorialPage extends StatefulWidget {
  TutorialPage({Key key }) : super(key: key);
   String title = "Fluttipedia™";
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {

  int _page = 1;
  static const int _NUM_OF_PAGES = 3;

  void _previousInfoPage() { setState( () { if (_page > 1) _page--; }); }
  void _nextInfoPage() { setState(() { if (_page < _NUM_OF_PAGES) { _page++; } }); }

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
            TutorialText(_page - 1),
            
            /*
            Container(
              padding: EdgeInsets.all(42),
              child: getInfoText()[_page - 1],
            ),
            */
          ],
        ),
      ),
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 0.0,0.0,0.0),
        child: Row(
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
      ),
    );
  }
}