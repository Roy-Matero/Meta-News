import 'package:darps_news/src/morePage.dart';
import 'package:darps_news/src/searchPage.dart';
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
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: categories.length, vsync: this, initialIndex: 0);
  }

  void status() async{
      var connectionResult = await Connectivity().checkConnectivity();
      if(connectionResult == ConnectivityResult.mobile){
        CupertinoAlertDialog(actions: <Widget>[Text("You are connected to the internet")],);
      }
      else {
        CupertinoAlertDialog(actions: <Widget>[Text("You are not connected to the internet")],);
      }
  }
  var pages = [MyHomePage(), Search(), More()];
  var _selectedIndex = 0;
  void _itemTapped(int index){
    setState(() {
      _selectedIndex = index;
      Navigator.push(context, MaterialPageRoute(builder: (context) => pages[index]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Darps News"),
        backgroundColor: Colors.transparent,
        actions: <Widget>[],
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          indicatorColor: Colors.green,
          tabs: List.generate(categories.length, (index){
            return Category(index);
          })
        ),
      ),
      body: TabBarView(controller: _tabController,
       children: List.generate(categories.length, (index){
         return NewsApi(index);
       }) 
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        //onTap: _itemTapped(_selectedIndex),
      ),
    );
  }
}
