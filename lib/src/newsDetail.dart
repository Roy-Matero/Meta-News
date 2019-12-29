import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({Key key, this.title, this.content, this.imageToUrl, this.url})
      : super(key: key);
  final title;
  final content;
  final imageToUrl;
  final url;

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-6964159613326022~6385164891").then((response){
      detailPageBanner..load()..show(anchorOffset: 60.0, anchorType: AnchorType.bottom);
    }); 
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Darps News", style: TextStyle(color: Colors.red)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.black,
        child: Card(
          color: Colors.black,
          child: ListView(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(minHeight: 200),
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  gradient:
                      LinearGradient(colors: [Colors.blue, Colors.purple]),
                  image: DecorationImage(
                    image: NetworkImage(imageToUrl),
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
                      content,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.open_in_new,
                              color: Colors.blue,
                            ),
                            onPressed: () => launch(url),
                        ),
                        IconButton(
                            icon: Icon(Icons.more_vert, color: Colors.blue),
                            onPressed: () {}),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
keywords: <String>['flutterio', 'beautiful apps'],
contentUrl: 'https://flutter.io',
birthday: DateTime.now(),
childDirected: false,
designedForFamilies: false,
gender: MobileAdGender.unknown, 
testDevices: <String>["7C61AB7F2B5F7A21A060B681001F85E9"], 
);

BannerAd detailPageBanner = BannerAd(


adUnitId: "ca-app-pub-6964159613326022/1762042536",
size: AdSize.smartBanner,
targetingInfo: targetingInfo,
listener: (MobileAdEvent event) {
  //print("BannerAd event is $event");
},
);
