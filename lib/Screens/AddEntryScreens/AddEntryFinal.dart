import 'package:flutter/material.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messtransacts/Screens/LogData.dart';
import 'package:intl/intl.dart';
import 'package:messtransacts/Passarguments/Addentrysc1.dart';

class AddEntryFinal extends StatefulWidget {
  static String id='addentryfinal_screen';
  @override
  _AddEntryFinalState createState() => _AddEntryFinalState();
}

class _AddEntryFinalState extends State<AddEntryFinal> {


  @override
  Widget build(BuildContext context) {
    Addentrysc1 addentrysc1Data=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '27 May 2020',
                      ),
                      Text(
                        'BreakFast'
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Entry No:',
                      ),
                      Text(
                        '12',
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
