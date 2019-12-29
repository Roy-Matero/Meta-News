import 'package:firebase_admob/firebase_admob.dart';

import '../categories.dart';
import '../newsCard.dart';
import '../newsDetail.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final apiKey = "3e098666ac9b4a6c85b716074a9f0475";

class Article {
  final Map source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json["source"],
      author: json["author"],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}

class NewsApi extends StatefulWidget {
  final int index;
  NewsApi(this.index, {Key key}) : super(key: key);

  _NewsApiState createState() => _NewsApiState(index);
}

class _NewsApiState extends State<NewsApi> {
  _NewsApiState(this.urlIndex);
  var list_articles;
  final int urlIndex;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    refresListArticle();
  }

  Future<Null> refresListArticle() async {
    refreshKey.currentState?.show(atTop: true);

    setState(() {
      list_articles = fetchArticles();
    });
  }

  Future<List<Article>> fetchArticles() async {
    var response = await http.get(
        'https://newsapi.org/v2/everything?q=${categories[urlIndex]}&apiKey=$apiKey');

    if (response.statusCode == 200) {
      List articles = json.decode(response.body)["articles"];

      return articles.map((article) => Article.fromJson(article)).toList();
    } else {
      return throw Exception('Failed to load data');
    }
  }

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
      adUnitId: "ca-app-pub-6964159613326022/8258280072",
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
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: refresListArticle,
      child: FutureBuilder(
        future: list_articles,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data;
            List articleList = articles
                .map((article) => NewsCard(
                      title: article.title,
                      details: article.description,
                      imageToUrl: article.urlToImage,
                      source: article.source,
                      author: article.author,
                      url: article.url,
                    ))
                .toList();

            var articleDetail = articles
                .map((article) => NewsDetails(
                      title: article.title,
                      content: article.content,
                      imageToUrl: article.urlToImage,
                      url: article.url
                    ))
                .toList();
            return ListView.builder(
              itemCount: articleList.length,
              itemBuilder: (context, int index) {
                return GestureDetector(
                  onLongPressUp: showInterstitialAd,
                  onLongPress: showInterstitialAd,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => articleDetail[index])),
                  child: articleList[index],
                );
              },
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
