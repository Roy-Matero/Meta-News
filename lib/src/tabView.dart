import 'categories.dart';
import 'network/newsApi.dart';
import 'package:flutter/material.dart';


TabController tabController;

class TabView extends StatefulWidget {
  const TabView({Key key}) : super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin{


  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: categories.length, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {

    return TabBarView(controller: tabController,
       children: List.generate(categories.length, (index){
         return NewsApi(index);
       }) 
      );
  }
}
