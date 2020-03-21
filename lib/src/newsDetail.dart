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
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Meta News", style: TextStyle(color: Colors.red)),
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
                            onPressed: (){},
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
      ),
    );
  }
}

