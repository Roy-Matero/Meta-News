import 'package:flutter/material.dart';


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
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.only(bottom: 20),
          constraints: BoxConstraints(minWidth: double.infinity),
          height: 200,
          decoration: BoxDecoration(
            color: Colors.green,
            image: DecorationImage(image: ExactAssetImage('lib/images/image_${widget.index}.jpg'),
            fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30)),
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
    );
  }
}

