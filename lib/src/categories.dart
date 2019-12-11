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
    // TODO: implement build
    return MaterialButton(
      onPressed: (){},
      child: Row(
        children: <Widget>[
          Icon(Icons.track_changes),
          Text(categories[index]),
        ],
      ),
      color: Colors.red,
      shape: StadiumBorder(),
      splashColor: Colors.yellowAccent,
      colorBrightness: Brightness.dark,
    );
  }
}

/* ListView(
            scrollDirection: Axis.horizontal,
                  children: List.generate(categories.length , (index){
                    return Category(index);
                  })
                ), */