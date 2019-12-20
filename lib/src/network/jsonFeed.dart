import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final apiKey = "3e098666ac9b4a6c85b716074a9f0475";

class Post {
  List<Feed> articles;

  Post({this.articles});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      articles:
          json['articles'].map((value) => new Feed.fromJson(value)).toList(),
    );
  }
}

class Feed {
  //final int totalResults;
  //final articles;
  final source;
  final author;
  final title;
  final description;
  final url;
  final urlToImage;
  final publishedAt;
  final content;

  Feed(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
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
  NewsApi({Key key}) : super(key: key);

  _NewsApiState createState() => _NewsApiState();
}

class _NewsApiState extends State<NewsApi> {
  Future<List<Post>> fetchNews() async {
    var data = await http
        .get('https://newsapi.org/v2/everything?q=tech&apiKey=$apiKey');

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);
      List<Post> posts = [];
      for (var u in jsonData) {
        Post news = Post.fromJson(u);
      }
      return posts;
    } else {
      return throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchNews(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(snapshot.data[index].title),
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
