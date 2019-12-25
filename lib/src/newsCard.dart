import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({Key key, this.title, this.details, this.imageToUrl})
      : super(key: key);
  final title;
  final details;
  final imageToUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.black,
      child: Card(
        color: Colors.black,
        child: Column(
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
                color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: 10),
            Text(details),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.developer_board,color: Colors.blue,),onPressed: (){}),
                IconButton(icon: Icon(Icons.more_vert,color: Colors.blue),onPressed: (){}),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
