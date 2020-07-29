import 'package:flutter/material.dart';
import 'package:messtransacts/Screens/AddEntryScreens/AEdatefoodtype.dart';
import 'package:messtransacts/Screens/AllLogDataDateSelec.dart';
import 'package:messtransacts/Screens/LogDataAnalysis.dart';
import 'package:messtransacts/Screens/LoginScreen.dart';
import 'package:messtransacts/Screens/UpdateDataCloud.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:google_fonts/google_fonts.dart';
import 'AllLogData.dart';

final _auth = FirebaseAuth.instance;
final _firestore=Firestore.instance;

class WillyHome extends StatefulWidget {
  static String id='Willy_homescreen';
  @override
  _WillyHomeState createState() => _WillyHomeState();
}

class _WillyHomeState extends State<WillyHome> {
  String workspace="";
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser().then((value){
      //uid=value.uid;
      _firestore.collection("UsersData").document(value.uid).get().then((value){

        setState(() {
          workspace=value.data['workspace'];
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage('images/dummypro.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:1.0,top: 5),
                    child: Text("Welcome!",style: TextStyle(color: Colors.white,fontSize: 25),),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/navbar.jpg"),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            ListTile(
              leading: Icon(Icons.track_changes),
              title: Text('Change Workspace'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: () async{
                Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Warning",
                  desc: "You will be Logged Out",
                  buttons: [
                    DialogButton(
                      child: Text(
                        "Log Out!",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: ()async {
                        _signOut();//signout from firebase
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        await preferences.clear();
                        // Navigator.pushReplacementNamed(context, LoginScreen.id);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()
                            ),
                            ModalRoute.withName("/Login_screen")
                        );
                      },
                      color: Colors.red[600],
                    ),
                    DialogButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.blueAccent,
                    )
                  ],
                ).show();
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.red[600] ,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(Icons.menu,color: Colors.white,size: 28,), onPressed: ()
                        {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        ),
                      ),
                      Row(
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("WORKSPACE: $workspace",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),

                    ],
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
                          Navigator.pushNamed(context, AllLogDataDateSelec.id);
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

                        Navigator.pushNamed(context, UpdateDataCloud.id);
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
  _signOut() async {
    await _auth.signOut();
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