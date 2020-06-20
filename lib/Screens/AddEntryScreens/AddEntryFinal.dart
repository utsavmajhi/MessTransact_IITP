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
int selectradio;

//RADIO BUTTONS DESCRIPSTION: 1-Cash 2-Gpay 3-Khata
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectradio=0;
  }

  setSelectedRadio(int val){
  setState(() {
    selectradio=val;
  });
  }

  @override
  Widget build(BuildContext context) {
    Addentrysc1 addentrysc1Data=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.red[500],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            addentrysc1Data.date,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Colors.white
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),

                        ],
                      ),
                      Column(
                        children: <Widget>[
                          CircleAvatar(
                            child:Icon(Icons.fastfood),
                          ),
                          Text(
                            addentrysc1Data.foodcat,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            'Entry No:',
                            style: GoogleFonts.montserrat(

                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '12',
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.white
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.red,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text('Select the Mode of Payment',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                    ),),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Radio(
                              value:1,
                              groupValue: selectradio,
                              activeColor: Colors.white,
                              onChanged: (value){
                                print(value);
                                setSelectedRadio(value);
                              },
                            ),
                            Text(
                              'Cash',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              value:2,
                              groupValue: selectradio,
                              activeColor: Colors.white,
                              onChanged: (value){
                                print(value);
                                setSelectedRadio(value);
                              },
                            ),
                            Text(
                              'GPay',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              value:3,
                              groupValue: selectradio,
                              activeColor: Colors.white,
                              onChanged: (value){
                                print(value);
                                setSelectedRadio(value);
                              },
                            ),
                            Text(
                              'Khaata',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),

                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(

              ),
            )
          ],
        ),
      ),
    );
  }
}
