import 'package:flutter/material.dart';
import 'src/homePage.dart';
import 'package:connectivity/connectivity.dart';

void main() {
  var connectionStatus = Connectivity().checkConnectivity();
  print(connectionStatus);
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


