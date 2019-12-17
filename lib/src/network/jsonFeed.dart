import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class JsonParse extends StatefulWidget {
  JsonParse({Key key}) : super(key: key);

  _JsonParseState createState() => _JsonParseState();
}

class _JsonParseState extends State<JsonParse> {

  // Pass a valid data type at the user 
  Future<List<FeedProperties>> _getUser() async{
    //pass in the url of the json web
    
    final APIUrl = 'https://newsapi.org/v2/top-headlines?' +
                    'country=us&' +
                    'apiKey=3e098666ac9b4a6c85b716074a9f0475';
    final APIKey = "3e098666ac9b4a6c85b716074a9f0475";

    var data = await http.get(APIUrl);
    var jsonData = json.decode(data.body);
    //Add a for loop to populate the list {users}
    // Return the users 
    for(var u in jsonData){
      FeedProperties feed = FeedProperties(u["id"], u["name"], u["author"], u["title"], 
      u["description"], u["url"], u["urlToImage"], u["publishedAt"], u["content"]);
    }
    //return Users;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: FutureBuilder(
         future: _getUser(),
         builder: (BuildContext context, AsyncSnapshot snapshot){
           if(snapshot.data == null){
             return CircularProgressIndicator();
           }
           else{
             return ListView.builder(
             itemCount: snapshot.data.length,
             itemBuilder: (BuildContext context, int index){
               return ListTile(
                 title: Text(snapshot.data[index].name),
               );
             },
           );
           }
         },
       ),
    );
  }
}


class FeedProperties {
  // Enter your properties here 
  final String id;
  final String name;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  // Initialise them here 
  FeedProperties(this.id, this.name, this.author, this.title, this.description, 
  this.url, this.urlToImage, this.publishedAt, this.content);
}


