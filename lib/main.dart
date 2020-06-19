import 'package:flutter/material.dart';
import 'package:messtransacts/Screens/LogData.dart';
import 'package:messtransacts/Screens/WillyHome.dart';
import 'package:messtransacts/Screens/AddEntryScreens/AEdatefoodtype.dart';
import 'package:messtransacts/Screens/AddEntryScreens/AddEntryFinal.dart';

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
        LogData.id:(context) =>LogData(),
        WillyHome.id:(context) => WillyHome(),
        AEdatefoodtype.id:(context) => AEdatefoodtype(),
        AddEntryFinal.id:(context) => AddEntryFinal(),
      },
    );
  }
}


