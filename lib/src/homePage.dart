import 'package:flutter/material.dart';
import 'categories.dart';
import 'network/newsApi.dart';
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
    _scrollController =
        new ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
  }

  void status() async{
      var connectionStatus = await Connectivity().checkConnectivity();
      if(connectionStatus == ConnectionState.active){
        print("Is connected");
      }
      else {
        print("Not connected");
      }

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
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.home, color: Colors.blue,),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.search, color: Colors.blue,),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.settings, color: Colors.blue,),
            ),
          ],
        ),
      ),
    );
  }
}
