import 'package:flutter/material.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WillyHome extends StatefulWidget {
  static String id='Willy_homescreen';
  @override
  _WillyHomeState createState() => _WillyHomeState();
}

class _WillyHomeState extends State<WillyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.red[700]
            ),
            height: 150,
          ),
          Container(
            child: Expanded(
              child: GridView.count(
                mainAxisSpacing: 35,
                crossAxisSpacing: 22,
                primary: false,
                children: <Widget>[
                  InkWell(
                    onTap: ()
                    {
                      //goto next screen

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Hero(tag: 'AddEntry',
                                child: SvgPicture.asset('images/travel2.svg',height: 110,)),
                            SizedBox(
                              height: 10 ,
                            ),
                            Text(
                              'Add Entry',
                              style: TextStyle(
                                  fontFamily: 'Montserrat Regular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(63, 63, 63, 1)
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Hero(tag: "Edit Travel Plan",
                              child: SvgPicture.asset('images/pencil.svg',height: 100,)),
                          SizedBox(
                            height: 20 ,
                          ),
                          Text(
                            'Edit Journey',
                            style: TextStyle(
                                fontFamily: 'Montserrat Regular',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(63, 63, 63, 1)
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                      //goto screen


                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Hero(tag: 'CalenderHero',
                                child: SvgPicture.asset('images/calendar.svg',height: 100,)),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Browse Calender',
                              style: TextStyle(
                                  fontFamily: 'Montserrat Regular',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(63, 63, 63, 1)
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      //                      _showSnackBar("Coming Soon! Stay tuned",Colors.blue);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 4,
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset('images/taxi.svg',height: 110,),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Cab Drivers',
                            style: TextStyle(
                                fontFamily: 'Montserrat Regular',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(63, 63, 63, 1)
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
                crossAxisCount: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
