import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messtransacts/Passarguments/LogdataDateargs.dart';
import 'package:messtransacts/Screens/LoginScreen.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messtransacts/Screens/LogDataAnalysis.dart';
import "dart:collection";
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:messtransacts/Screens/roundedbuttonsmall.dart';
import 'package:messtransacts/Screens/rounded_button.dart';
import 'package:strings/strings.dart';

final _firestore=Firestore.instance;

class RegistrationScreen extends StatefulWidget {
  static String id='registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _workspacetype='Choose your mess/workspace';

  bool _obscureText = true;
  bool _obscureText2=true;
  String email="";
  List<String> workspaces=["Choose your mess/workspace"];
  String password="";
  String conpassword="";
  String _fullname="";
  bool passwordVisible;
  bool passwordVisible2;
  bool showSpinner = false;
  final resetemail = TextEditingController();
  final _auth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = false;
    passwordVisible2=false;
    _firestore.collection("Workspaces").getDocuments().then((value){
      for(int i=0;i<value.documents.length;i++){
        workspaces.add(value.documents[i].data['WorkspaceName']);
      }
    }).then((value){
      setState(() {

      });
    });

  }
  //snackbar initialises
  _showSnackBar(@required String message, @required Color colors) {
    if (_scaffoldKey != null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: colors,
          content: new Text(message),
          duration: new Duration(seconds: 4),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0,vertical: 20),
                  child: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      radius: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('images/agriculture.png',color: Colors.white,),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0),
                  child: Text(
                    'New User,',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0,vertical: 10),
                  child: Text('Get yourself Registered',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 20, right: 30),
                  child: TextFormField(
                    cursorColor: Color(0xFF6746CC),

                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      //get the email
                      _fullname=value;

                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person_pin),
                      labelStyle: TextStyle(
                        color: Color(0xFFB2BCC8),
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 20, right: 30, bottom: 20),
                  child: TextFormField(
                    cursorColor: Color(0xFF6746CC),

                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      //get the email
                      email=value;

                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      labelText: 'Institute Email',
                      prefixIcon: Icon(Icons.email),
                      labelStyle: TextStyle(
                        color: Color(0xFFB2BCC8),
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),

                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 10, right: 30, bottom: 20),
                  child: TextFormField(
                    obscureText: _obscureText,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      //get the pass
                      password=value;

                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                            passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xFFB2BCC8),
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 10, right: 30, bottom: 20),
                  child: TextFormField(
                    obscureText: _obscureText,
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      //get the pass
                      conpassword=value;

                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                            passwordVisible2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            passwordVisible2 = !passwordVisible2;
                            _obscureText2 = !_obscureText2;
                          });
                        },
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xFFB2BCC8),
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:30.0),
                  child: DropdownButton<String>(
                    value: _workspacetype ,
                    isExpanded: true,
                    icon: Icon(Icons.room_service,
                      color: Colors.red,),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black54),
                    underline: Container(
                      height: 2,
                      color: Colors.black87,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        _workspacetype = newValue;
                      });
                    },
                    items: workspaces
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Column(
                  children: <Widget>[
                    Center(
                      child: RoundedButton(
                        title: 'Submit',
                        colour: Color(0xFF6746CC),
                        onPressed: () async {
                          //backends starts

                          String check = checkparameters(_fullname,email.toLowerCase().trim(), password,conpassword,_workspacetype);
                          if (check == "Checks passed") {
                            setState(() {
                              showSpinner=true;
                            });
                            try{
                              final  newUser=await _auth.createUserWithEmailAndPassword(email: email.toLowerCase().trim(), password: password);
                              var _authenticatedUser = await _auth.currentUser();
                              await _authenticatedUser.sendEmailVerification();
                              if(await newUser!=null)
                              {
                                String uid=_authenticatedUser.uid;
                                //Navigator.pushNamed(context, ChatScreen.id);
                                //firestore datacollection starts
                                await _firestore.collection('UsersData').document(uid).setData({
                                  'username':capitalize(_fullname),
                                  'institutemail':email.toLowerCase().trim(),
                                  'workspace':_workspacetype,
                                  'typeofuser':"2",
                                });
                                setState(() {
                                  showSpinner=false;
                                });

                                _showSnackBar("Verification Mail has been sent to provided Institute mail Id", Colors.lightGreen);
                              }
                            }
                            catch(e)
                            {
                              setState(() {
                                showSpinner=false;
                              });
                              _showSnackBar(e.toString(),Colors.red[700]);
                              print(e);
                            }
                          }
                          else {
                            setState(() {
                              showSpinner = false;
                            });
                            _showSnackBar(check, Colors.red[700]);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already Registered ?',
                            style: TextStyle(
                                color: Color(0xFFB2BCC8),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              //goto registration page
                              Navigator.pushReplacementNamed(context, LoginScreen.id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Color(0xFF6746CC),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  String checkparameters(@required String fullname,
      @required String institutemail, @required String password, @required String conpassword,@required String workspace) {
    if (institutemail.isEmpty ||
        password.isEmpty ||
        institutemail == null ||
        password == null||fullname.isEmpty||fullname==null||conpassword.isEmpty||conpassword==null) {
      return "All Fields are Mandatory";
    } else {
      if (password.length < 6) {
        return "Password Length is less than 6";
      } else {
        if(password!=conpassword){
          return "Passwords do not match ! Please Check";
        }else{
          if(workspace=="Choose your mess/workspace"){
            return "Select your Mess from Dropdown Menu";
          }
          else{
            return "Checks passed";

          }
        }


      }
    }
  }

}
