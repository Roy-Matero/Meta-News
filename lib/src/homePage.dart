import 'package:flutter/material.dart';
import 'categories.dart';
import 'newsCard.dart';
import 'network/jsonFeed.dart';


class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState(){
    super.initState();
    _tabController = new TabController(
        length: 3,
        vsync: this, initialIndex: 1);
    _scrollController = new ScrollController(initialScrollOffset: 1, keepScrollOffset: true);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Darps News"),
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Icon(Icons.search,
            size: 35,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.green,
          tabs: <Widget> [
            new Tab(icon: Icon(Icons.home, color: Colors.green,)),
            new Tab(icon: Icon(Icons.search, color: Colors.green,)),
            new Tab(icon: Icon(Icons.rss_feed, color: Colors.green,)),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
        ),
        //color: Colors.black,
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.purple, Colors.blue]),
                borderRadius: BorderRadius.all(Radius.circular(23))
              ),
              height: 50,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(categories.length, (index){
                  return Category(index);
                }),
              ),
            ),
            //SizedBox(height: 50),
            //Container(child: JsonParse()),
            //SizedBox(height: 50),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: 400,
              child: ListView(
                children: List.generate(6, (index){
                  return NewsCard(index);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
