import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messtransacts/Passarguments/LogdataDateargs.dart';
import 'package:messtransacts/Screens/RegistrationScreen.dart';
import 'package:messtransacts/Screens/WillyHome.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messtransacts/Screens/LogDataAnalysis.dart';
import "dart:collection";
import 'package:messtransacts/Screens/rounded_button.dart';
import 'package:messtransacts/Screens/roundedbuttonsmall.dart';
final _firestore=Firestore.instance;

class LoginScreen extends StatefulWidget {
  static String id='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  String email="";
  String password="";
  bool passwordVisible;
  bool showSpinner = false;
  final resetemail = TextEditingController();
  final _auth = FirebaseAuth.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = false;
    getCurrentUser();


  }
  void getCurrentUser () async{
    setState(() {
      showSpinner=true;
    });
    try{
      final user=await _auth.currentUser();
      if(user!=null&&(user.isEmailVerified==true))
      {
        _firestore.collection("UsersData").document(user.uid).get().then((value){
          if(value.data['typeofuser']=='2'){
            setsharedprefs(value.data['username'],value.data['workspace'], user.uid).then((value){
              Navigator.pushReplacementNamed(context,WillyHome.id);
              setState(() {
                showSpinner=false;
              });

            });
          }
        });
        setState(() {
          showSpinner=false;
        });

      }else{
        setState(() {
          showSpinner=false;
        });
      }
    }
    catch(e)
    {
      print(e);
    }

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
                      backgroundColor: Colors.red[600],
                      radius: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('images/agriculture.png',color: Colors.white,),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0),
                  child: Text(
                    'Mess Transact IITP',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25.0,vertical: 10),
                  child: Text('Sign in to continue',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, top: 20, right: 30, bottom: 20),
                  child: TextFormField(
                    cursorColor: Colors.redAccent,

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
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        //Navigate to forgot password page
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            //goto passwordresetScreen
                            // Navigator.pushNamed(context, PasswordResetScreen.id);
                            /*  var sheetController =  _scaffoldKey.currentState.showBottomSheet(
                                  (context) => BottomSheetWidget());
                              sheetController.closed.then((value) {
                                print(value);
                              });*/

                            showModalBottomSheet<void>(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {

                                return SingleChildScrollView(
                                  child: Container(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding:  EdgeInsets.only(
                                                bottom: MediaQuery.of(context).viewInsets.bottom),
                                            child: Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: TextFormField(
                                                controller: resetemail,
                                                textAlign: TextAlign.start,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(
                                                      left: 15, bottom: 11, top: 11, right: 15),
                                                  labelText: 'Enter your Registered Institute ID',
                                                  prefixIcon: Icon(Icons.email),
                                                  labelStyle: TextStyle(
                                                    color: Color(0xFFB2BCC8),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left:18.0,right: 18,top: 0,bottom: 10),
                                            child: RoundedButton(
                                              title: "Send Reset Link",
                                              colour: Colors.red[600],
                                              onPressed: (){
                                                setState(()async{
                                                  if(resetemail.text.isEmpty){
                                                    _showSnackBar(
                                                        'Please enter your Registered Institute Id',
                                                        Colors.red[600]);
                                                    Navigator.pop(context);
                                                  }
                                                  else{
                                                //checks completed and passed
                                                //backend starts
                                                String check=await firebasepasswordreset(resetemail.text,_auth);
                                                if(check=="ResetLinkSent")
                                                {
                                                  _showSnackBar(
                                                      'Password Reset link has been sent to ${resetemail.text}',
                                                      Colors.green);
                                                  Navigator.pop(context);
                                                }else
                                                {
                                                  _showSnackBar(check,
                                                      Colors.red[600]);
                                                  Navigator.pop(context);
                                                }


                                                  }


                                                });

                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );

                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.red[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Center(
                      child: RoundedButton(
                        title: 'Login',
                        colour: Colors.red[600],
                        onPressed: () async {
                          //backends starts

                          String check = checkparameters(
                              email.toLowerCase().trim(), password);
                          if (check == "Checks passed") {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              var user = await _auth.signInWithEmailAndPassword(
                                  email: email.toLowerCase().trim(),
                                  password: password);
                              var _authenticatedUser = await _auth.currentUser();
                                //now get the workspace & typeofuser verify

                              if (await _authenticatedUser.isEmailVerified) {
                                print(_authenticatedUser.uid);
                                print("Email is :" +
                                    _authenticatedUser.isEmailVerified
                                        .toString());
                                _firestore.collection("UsersData").document(_authenticatedUser.uid).get().then((value) async{
                                  String typeuser=value.data['typeofuser'];
                                  String workspace=value.data['workspace'];
                                  String username=value.data['username'];
                                  print(typeuser);
                                  print(workspace);
                                  if(typeuser!='2'){
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    _showSnackBar(
                                        'The user is not Authorised to use Mess Transact App',
                                        Colors.red[600]);
                                  }else{
                                    if(await setsharedprefs(username, workspace, _authenticatedUser.uid)=="true"){
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      Navigator.pushReplacementNamed(context, WillyHome.id);
                                    }
                                  }
                                });
                                // await _showSnackBar('Email is verified',Colors.lightGreen);

                              } else {
                                print("Email is :" +
                                    _authenticatedUser.isEmailVerified
                                        .toString());
                                _showSnackBar(
                                    'Email is not verified ! Please verify your email',
                                    Colors.red[600]);
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            } catch (e) {
                              _showSnackBar(e.message, Colors.red[600]);
                              print(e);
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          } else {
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
                            'New User ?',
                            style: TextStyle(
                                color: Color(0xFFB2BCC8),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              //goto registration page
                              Navigator.pushNamed(context, RegistrationScreen.id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                    color: Colors.red[600],
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
  //firebae password reset
  Future<String> firebasepasswordreset(@required String email,FirebaseAuth _auth) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
      print("password reset link has been sent to: "+email);
      return "ResetLinkSent";
    }
    catch(e)
    {
      return e.message;

    }


  }
  String checkparameters(
      @required String institutemail, @required String password) {
    if (institutemail.isEmpty ||
        password.isEmpty ||
        institutemail == null ||
        password == null) {
      return "All Fields are Mandatory";
    } else {
      if (password.length < 6) {
        return "Password Length is less than 6";
      } else {
        return "Checks passed";

      }
    }
  }
  Future<String> setsharedprefs(String username,String workspace,String uid) async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString('username', username);
    await sharedPreferences.setString('workspace', workspace);
    await sharedPreferences.setString('UID', uid);
    sharedPreferences.commit();
    return "true";

  }
}
