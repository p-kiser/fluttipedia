import 'package:flutter/material.dart';
import 'package:fluttipedia/screens/guess.dart';
import 'package:fluttipedia/screens/result.dart';
import 'package:fluttipedia/screens/tutorial.dart';
import 'package:fluttipedia/screens/settings.dart';

void main() => runApp(FluttiApp());

class FluttiApp extends StatelessWidget {
  // Root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttipedia™',
      debugShowCheckedModeBanner: false, // TODO Sollte den Debug-Banner entfernen, scheint aber nichts zu bewirken.
      theme: ThemeData(primarySwatch: Colors.deepPurple),
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
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

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
          GuessPage(),
          ResultPage(),
          TutorialPage(),
          SettingsPage(),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.deepPurple,
        ),
        child: new BottomNavigationBar(
          items: [
            // Styles the bottom navigation bar items
            BottomNavigationBarItem(
              icon: Icon(
                Icons.games,
                color: Colors.white,
              ),
              title: Text(
                "Spiel",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ),
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
              )
            ),
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
              )
            ),
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
                )
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}

