import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewsCard extends StatefulWidget {
  final int index;
  NewsCard(this.index);

  @override
  _NewsCardState createState() => _NewsCardState(index);
}

class _NewsCardState extends State<NewsCard> {
  final int index;
  _NewsCardState(this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, NewsDetail(index));
      },
      child: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            constraints: BoxConstraints(minWidth: double.infinity),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                image: ExactAssetImage('lib/images/image_$index.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("This is where the feed text will appear"),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class NewsDetail extends MaterialPageRoute<Null> {
  final index;

  NewsDetail(this.index)
      : super(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Darps News"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            body: Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 200),
                    constraints: BoxConstraints(minWidth: double.infinity),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      image: DecorationImage(
                        image: ExactAssetImage('lib/images/image_$index.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gradient:
                          LinearGradient(colors: [Colors.blue, Colors.purple]),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text("Detailed Full story appears here "),
                      Image.asset('lib/images/image_$index.jpg'),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
}
