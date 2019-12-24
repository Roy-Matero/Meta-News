import 'dart:ui';

import 'package:flutter/material.dart';
import 'categories.dart';
import 'network/newsApi.dart';


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
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0);
    _scrollController =
        new ScrollController(initialScrollOffset: 0, keepScrollOffset: true);
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
          controller: _tabController,
          indicatorColor: Colors.green,
          tabs: <Widget>[
            new Tab(
                icon: Icon(
              Icons.home,
              color: Colors.green,
            )),
            new Tab(
                icon: Icon(
              Icons.more,
              color: Colors.green,
            )),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.black
              //gradient: RadialGradient(colors: [Colors.white, Colors.black]),
              ),
          child: ListView(
            controller: _scrollController,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
              /*  decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Colors.purple, Colors.blue]),
                    borderRadius: BorderRadius.all(Radius.circular(23))), */
                height: 50,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(categories.length, (index) {
                    return Category(index);
                  }),
                ),
              ),

              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 400,
                child: NewsApi(),
              ),
            ],
          ),
        ),
        Container(
          //child: NewsApi(),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
