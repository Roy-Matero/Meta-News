import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class JsonParse extends StatefulWidget{

  @override
  _JsonParseState createState() => _JsonParseState();
}

class _JsonParseState extends State<JsonParse> {
  final jsonUrl = "https://swapi.co/starships";
  List data;
  Future<String> getData() async {
    var res = await http.get(Uri.encodeFull(jsonUrl), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["results"];
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Text(data[1]["name"]),
    );
  }
  @override
  void initState(){
    super.initState();
    this.getData();
  }
}


/* ListView.builder(
        itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index){
          return new Container(
            child: Text(data[index]["name"]),
          );
          },
      ),
     */