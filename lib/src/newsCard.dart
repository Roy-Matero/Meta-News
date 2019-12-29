import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
   NewsCard(
      {Key key,
      this.title,
      this.details,
      this.imageToUrl,
      this.source,
      this.author, 
      this.url,
        this.publishTime,
      })
      : super(key: key);
  final title;
  final details;
  final imageToUrl;
  final author;
  final Map source;
  final url;
  final publishTime;


  void showInterstitialAd(){
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
      adUnitId: "ca-app-pub-6964159613326022/5946498427",
      targetingInfo: interstitialTargetingInfo,
      listener: (MobileAdEvent event) {
        //print("InterstitialAd event is $event");
      },
    );

    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-6964159613326022~6385164891").then((response){
      homePageInterstitial..load()..show();
    });
  }

  @override
  Widget build(BuildContext context) {
    var timeDiffDays = DateTime.now().difference(DateTime.parse(publishTime)).inDays.toInt();
    var timeDiffHours = DateTime.now().difference(DateTime.parse(publishTime)).inHours.toInt();
    var timeDiffMinutes = DateTime.now().difference(DateTime.parse(publishTime)).inMinutes.toInt();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.black,
      child: Card(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(minHeight: 150),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
                image: DecorationImage(
                  image: NetworkImage(
                    imageToUrl ?? "https://pulmanseat.co.uk/img/motability/no-image-found.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    details,
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            source["name"] != null ? source["name"] : "Unknown",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            author != null && author.length < 30 ? author : "",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        timeDiffDays != 0 ? "$timeDiffDays Days ago" 
                        : "$timeDiffHours Hours ago",
                        style: TextStyle(fontSize: 10.0, color: Colors.greenAccent),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.open_in_new,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            if(url != null){
                               return launch(url);
                            }
                            else{
                              return () {};
                            }
                          }),
                      IconButton(
                          icon: Icon(Icons.more_vert, color: Colors.blue),
                          onPressed: showInterstitialAd,
                          ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

