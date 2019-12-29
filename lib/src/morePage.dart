import 'package:firebase_admob/firebase_admob.dart';
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
          Text(""),
        ],
      ),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-6964159613326022~6385164891").then((response){
      morePageInterstitial..load()..show();
    }); 
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

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
keywords: <String>['flutterio', 'beautiful apps'],
contentUrl: 'https://flutter.io',
birthday: DateTime.now().add(Duration(seconds: 15)),
childDirected: false,
designedForFamilies: false,
gender: MobileAdGender.unknown, 
testDevices: <String>["7C61AB7F2B5F7A21A060B681001F85E9"], 
);

InterstitialAd morePageInterstitial = InterstitialAd(

  adUnitId: "ca-app-pub-6964159613326022/8474790549",
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    //print("InterstitialAd event is $event");
  },
);
