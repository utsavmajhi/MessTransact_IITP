import 'package:flutter/material.dart';
import 'package:messtransacts/Screens/Homepage.dart';
import 'package:messtransacts/Screens/WillyHome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WillyHome.id,
      routes: {
        Homepage.id:(context) =>Homepage(),
        WillyHome.id:(context) => WillyHome(),
      },
    );
  }
}


