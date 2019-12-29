import 'package:firebase_admob/firebase_admob.dart';

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
      FirebaseAdMob.instance.initialize(appId: "ca-app-pub-6964159613326022~6385164891").then((response){
      homePageInterstitial..load()..show();
    });

    return TabBarView(controller: tabController,
       children: List.generate(categories.length, (index){
         return NewsApi(index);
       }) 
      );
  }
}


MobileAdTargetingInfo interstitialTargetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      birthday: DateTime.now().add(Duration(minutes: 2)),
      childDirected: false,
      designedForFamilies: false,
      gender: MobileAdGender.unknown, // or MobileAdGender.female, MobileAdGender.unknown
      testDevices: <String>["7C61AB7F2B5F7A21A060B681001F85E9"], // Android emulators are considered test devices
      );

    InterstitialAd homePageInterstitial = InterstitialAd(
  adUnitId: "ca-app-pub-6964159613326022/3170778386",
  targetingInfo: interstitialTargetingInfo,
  listener: (MobileAdEvent event) {
    //print("InterstitialAd event is $event");
  },
);