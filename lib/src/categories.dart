import 'package:flutter/material.dart';

final List<String> categories = [
  "Global",
  "Technology",
  "Science",
  "Sports",
  "Business",
  "Politics",
  "Art",
  "Health",
];

class Category extends StatelessWidget {
  final int index;
  Category(this.index);

  @override
  Widget build(BuildContext context) {
    return Tab(
      text: categories[index],
    );
  }
}