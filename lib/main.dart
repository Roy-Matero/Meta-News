import 'package:flutter/material.dart';
import 'src/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Darps',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}


