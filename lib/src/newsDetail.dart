import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({Key key, this.title, this.content, this.imageToUrl})
      : super(key: key);
  final title;
  final content;
  final imageToUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Darps News"),
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
                  gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
                  image: DecorationImage(
                    image: NetworkImage(imageToUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  child: Text(
                    title,
                  ),
                  color: Colors.transparent,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 10000,
                child: Text(content)
              ),
              SizedBox(height: 10),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
