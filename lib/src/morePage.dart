import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class More extends StatefulWidget {
  More({Key key, this.header, this.body, this.isExpanded: false}) : super(key: key);

  bool isExpanded;
  final Widget header;
  final Widget body;

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {


  List<More> _items = <More> [
    More(
      header: Row(
        children: <Widget>[
          Icon(Icons.info),
          SizedBox(width: 30,),
          Text("About"),
        ],
      ), 
      body: Column(
        children: <Widget>[
          SizedBox(width: 10),
          Text("This app was created by : Roy Matero"),
          Text("Email: roymatero@gmail.com"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("twitter:"),
              MaterialButton(
            child: Text("@RoyMatero", style: TextStyle(color: Colors.blue),),
            onPressed: () => launch('https://twitter.com/RoyMatero'),
          ),
            ],
          ),
          SizedBox(width: 50),
        ],
      ),
    ),
    More(
      header: Row(
        children: <Widget>[
          Icon(Icons.assistant),
          SizedBox(width: 30,),
          Text("Credit"),
        ],
      ), 
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Powered by"),
          MaterialButton(
            child: Text("News API", style: TextStyle(color: Colors.blue),),
            onPressed: () => launch('https://newsapi.org/'),
          ),
          SizedBox(height: 20.0,)
        ],
      ),
    ),

    More(
      header: Row(
        children: <Widget>[
          Icon(Icons.question_answer),
          SizedBox(width: 30,),
          Text("FAQ"),
        ],
      ), 
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Please note that this app may contain development errors, I'll try as much to correct them, for the best user experience possible."),
          SizedBox(height: 10,),
          Text("Be sure to keep updating this app to get the best out of it",
          style: TextStyle(),),
        ],
      ),
      ),
  ];

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.black,
        child: ListView(
          children: <Widget>[
          ExpansionPanelList(
            animationDuration: Duration(seconds: 1),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
              _items[index].isExpanded = !_items[index].isExpanded;
              });
            },
            children: _items.map((More item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                    child: item.header,
                    padding: EdgeInsets.all(10),
                  );
                },
                isExpanded: item.isExpanded,
                body: Container(child: item.body),
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }
}

