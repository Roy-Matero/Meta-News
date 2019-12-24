import 'package:flutter/material.dart';

final List<String> categories = [
  "Local",
  "Global",
  "Tech",
  "Sports",
  "Business",
  "Politics",
];

class Category extends StatelessWidget {
  final int index;
  Category(this.index);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        MaterialButton(
          height: double.infinity,
          onPressed: () {},
          child: Row(
            children: <Widget>[
              Icon(Icons.track_changes),
              Text(categories[index]),
            ],
          ),
          color: Colors.green,
          shape: StadiumBorder(),
          splashColor: Colors.yellowAccent,
          colorBrightness: Brightness.dark,
        ),
        SizedBox(width: 5,),
      ],
    );
  }
}

/* ListView(
            scrollDirection: Axis.horizontal,
                  children: List.generate(categories.length , (index){
                    return Category(index);
                  })
                ), */
