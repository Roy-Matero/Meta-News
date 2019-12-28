import 'package:darps_news/src/searchPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:darps_news/src/morePage.dart';
import 'package:darps_news/src/tabView.dart';
import 'categories.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = new TabController(
        length: categories.length, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              controller: tabController,
              indicatorColor: Colors.green,
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.green,
              labelStyle: TextStyle(fontSize: 18),
              unselectedLabelStyle: TextStyle(fontSize: 12),
              tabs: List.generate(categories.length, (index) {
                return Category(index);
              })),
        body: TabView());
  }
}

class HomeNavigation extends StatefulWidget {
  HomeNavigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<HomeNavigation> {
  final List<Widget> navigationPages = [MyHomePage(), Search(), More()];
  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //leading: Image.asset("lib/assets/images/darpsIcon.png"),
        title: Text("Darps News", style: TextStyle(color: Colors.white)),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        actions: <Widget>[],
        primary: true,
      ),
      body: navigationPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedFontSize: 15,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.teal,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            title: Text("More"),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

/*
class Admob {
  final String appId = "ca-app-pub-6964159613326022~6385164891";
  FirebaseAdMob.instance.initialize(appId: appId);
}

*/