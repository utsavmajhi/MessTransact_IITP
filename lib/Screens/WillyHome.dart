import 'package:flutter/material.dart';
import 'package:messtransacts/Screens/AddEntryScreens/AEdatefoodtype.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'LogData.dart';


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
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                /*image: DecorationImage(
                        image: AssetImage('images/back1.jpg'),
                        fit: BoxFit.cover,
                      ),*/
                color: Colors.red[600] ,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    child: Image.asset('images/iitpatna.png'),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'MessLogger',
                    style: GoogleFonts.wellfleet(
                      fontSize: 28,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: GridView.count(
                mainAxisSpacing: 30,
                crossAxisSpacing: 10,
                primary: false,
                children: <Widget>[
                  InkWell(
                    onTap: ()
                    {
                      //goto addentryscreens screen
                      Navigator.pushNamed(context, AEdatefoodtype.id);

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Hero(tag: 'AddEntry',
                                child: SvgPicture.asset('images/add.svg',height: 110,)),
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
                        //
                          Navigator.pushNamed(context, LogData.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Hero(tag: "LogData",
                                child: SvgPicture.asset('images/result.svg',height: 100,)),
                            SizedBox(
                              height: 20 ,
                            ),
                            Text(
                              'Log Data',
                              style: TextStyle(

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
                      //goto screen


                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Hero(tag: 'Cloud',
                                child: SvgPicture.asset('images/cloud.svg',height: 100,)),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Upload Data',
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 4,
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset('images/excel.svg',height: 110,),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Export',
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
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 20;
    while (curXPos < size.width) {
      curXPos += increment;
      path.arcToPoint(Offset(curXPos, curYPos), radius: Radius.circular(5));
    }
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}