import 'package:flutter/material.dart';
import 'package:messtransacts/Screens/AllLogData.dart';
import 'package:messtransacts/Screens/WillyHome.dart';
import 'package:messtransacts/Screens/AddEntryScreens/AEdatefoodtype.dart';
import 'package:messtransacts/Screens/AddEntryScreens/AddEntryFinal.dart';
import 'package:messtransacts/Screens/LogDataAnalysis.dart';
import 'package:messtransacts/Screens/AllLogDataDateSelec.dart';
import 'Screens/UpdateDataCloud.dart';
import 'package:messtransacts/Screens/LoginScreen.dart';
import 'package:messtransacts/Screens/RegistrationScreen.dart';

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
        LogDataAnalysis.id:(context) => LogDataAnalysis(),
        AllLogDataDateSelec.id:(context) => AllLogDataDateSelec(),
        UpdateDataCloud.id:(context) => UpdateDataCloud(),
        LoginScreen.id:(context) => LoginScreen(),
        RegistrationScreen.id:(context) => RegistrationScreen(),
      },
    );
  }
}


