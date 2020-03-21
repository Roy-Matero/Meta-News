import '../categories.dart';
import '../newsCard.dart';
import '../newsDetail.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


final apiKey = "3e098666ac9b4a6c85b716074a9f0475"; 
var queryText = "everything";

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
  var listArticles;
  final int urlIndex;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    refresListArticle();
  }

  Future<Null> refresListArticle() async {
    var counter = 1;
    counter % 2 != 0 
    ? queryText = "top-headlines"
    : queryText = "everything";
    counter += 1;
    
    refreshKey.currentState?.show(atTop: true);

    setState(() {
      listArticles = fetchArticles();
    });
  }

  Future<List<Article>> fetchArticles() async {
    var response = await http.get(
        "https://newsapi.org/v2/top-headlines?q=${categories[urlIndex]}&sortBy=time&apiKey=$apiKey");


    if (response.statusCode == 200) {
      List articles = json.decode(response.body)["articles"];

      return articles.map((article) => Article.fromJson(article)).toList();
    } else {
      return throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: refresListArticle,
      child: FutureBuilder(
        future: listArticles,
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
                      publishTime: article.publishedAt,
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
                  onLongPressUp: () => null,
                  onLongPress: () => null,
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
