import 'package:darps_news/src/morePage.dart';
import 'package:darps_news/src/searchPage.dart';
import 'package:darps_news/src/tabView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'categories.dart';
import 'network/newsApi.dart';
//import 'newsCard.dart';
import 'package:connectivity/connectivity.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: categories.length, vsync: this, initialIndex: 0);
  }

  void status() async{
      var connectionResult = await Connectivity().checkConnectivity();
      if(connectionResult == ConnectivityResult.wifi){
        CupertinoAlertDialog(actions: <Widget>[Text("You are connected to the internet")],);
      }
      else {
        CupertinoAlertDialog(actions: <Widget>[Text("You are not connected to the internet")],);
      }
  }
  var navigationPages = [TabView(), Search(), More()];
  var _selectedIndex = 0;
  void _itemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: CircleAvatar(child: Image(image: ExactAssetImage("assets/image/darpsIcon.png"),)),
        title: Text("Darps News", style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.transparent,
        actions: <Widget>[],
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          controller: tabController,
          indicatorColor: Colors.green,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.green,
          labelStyle: TextStyle(fontSize: 18),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          tabs: List.generate(categories.length, (index){
            return Category(index);
          })
        ),
      ),
      body: navigationPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
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
        onTap:(context) => _itemTapped(_selectedIndex),
      ),
    );
  }
}