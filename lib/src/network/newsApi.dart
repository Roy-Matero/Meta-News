import 'package:darps_news/src/categories.dart';
import 'package:darps_news/src/newsCard.dart';
import 'package:darps_news/src/newsDetail.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


final apiKey = "3e098666ac9b4a6c85b716074a9f0475";

class Article {
  //final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article(
      { //this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      //source: json["source"],
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
  final int urlIndex;

  _NewsApiState(this.urlIndex); 

  Future<List<Article>> fetchArticles() async {
    var response = await http
        .get('https://newsapi.org/v2/everything?q=${categories[urlIndex]}&apiKey=$apiKey');

    if (response.statusCode == 200) {
      List articles = json.decode(response.body)["articles"];

      return articles.map((article) => Article.fromJson(article)).toList();
    } else {
      return throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchArticles(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Article> articles = snapshot.data;
          List articleList = articles.map((article) 
          => NewsCard(title: article.title, details: article.description, imageToUrl: article.urlToImage,)).toList();

          var articleDetail = articles.map((article) 
          => NewsDetails(title: article.title, content: article.content, imageToUrl: article.urlToImage,)).toList();
          return ListView.builder(
            itemCount: articleList.length,
            itemBuilder: (context,int index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context ) => articleDetail[index])
                  ),
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
    );
  }
}