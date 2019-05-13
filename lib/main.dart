import 'package:flutter/material.dart';
import 'package:fluttipedia/screens/guess.dart';
import 'package:fluttipedia/screens/result.dart';
import 'package:fluttipedia/screens/settings.dart';
import 'package:fluttipedia/screens/tutorial.dart';

void main() => runApp(FluttiApp());

class FluttiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttipedia™',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple, cardColor: Color(0xfff2f2f2)),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/guess': (context) => GuessPage(),
        '/result': (context) => ResultPage(),
        '/tutorial': (context) => TutorialPage(),
        '/setting': (context) => SettingsPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          // Adds pages to the bottom navigation bar
          TutorialPage(),
          GuessPage(),
          //ResultPage(),
          SettingsPage(),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).primaryColor,
        ),
        child: new BottomNavigationBar(
          items: [
            // Styles the bottom navigation bar items
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                title: Text(
                  "Anleitung",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                ),
                title: Text(
                  "Spiel",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
                /*
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.insert_drive_file,
                  color: Colors.white,
                ),
                
                title: Text(
                  "Resultate",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
                */
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  "Einstellungen",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}
