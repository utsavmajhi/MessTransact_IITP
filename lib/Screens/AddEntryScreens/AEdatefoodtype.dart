import 'package:flutter/material.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messtransacts/Screens/AllLogData.dart';
import 'package:intl/intl.dart';
import 'package:messtransacts/Passarguments/Addentrysc1.dart';
import 'package:messtransacts/Screens/AddEntryScreens/AddEntryFinal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


final _firestore=Firestore.instance;
List<String> foodnames=[];
List<double> foodprices=[];
class AEdatefoodtype extends StatefulWidget {
    static String id='aedatefood_screen';
  @override
  _AEdatefoodtypeState createState() => _AEdatefoodtypeState();
}

class _AEdatefoodtypeState extends State<AEdatefoodtype> {
  String workspace="";
  DateTime _dateTime=DateTime.now();  //date picker from calendar
  String _foodcat='None';
  bool showSpinner = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked=await showDatePicker(context: context, initialDate: _dateTime, firstDate: DateTime(2016), lastDate: DateTime(2222));
    if(picked!=null && picked !=_dateTime)
    {

      setState(() {
        _dateTime=picked;
      });
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getvaluesfromshared();

  }
  Future<bool> getvaluesfromshared() async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String username=sharedPreferences.getString('username');
    String workspaceshared=sharedPreferences.getString('workspace');
    setState(() {
     workspace=workspaceshared;
    });
    return true;
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
      backgroundColor: Colors.red[600],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Add Entry'
        ),

      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center ,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 45,
                            child: SvgPicture.asset('images/add.svg',fit: BoxFit.contain,),
                          ),
                        ),
                        Text(
                          "ADD ITEMS",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Select Entry Date',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        FlatButton(
                          color: Colors.amberAccent,
                          onPressed: (){
                            _selectDate(context);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text (
                                _dateTime==null? "Please Select" : changetimeformat(_dateTime),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.arrow_drop_down),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Text(
                          'Select Food Category',
                          style: TextStyle(
                              fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        DropdownButton<String>(
                          value: _foodcat ,
                          icon: Icon(Icons.fastfood,
                          color: Colors.redAccent,),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              _foodcat = newValue;
                            });
                          },
                          items: <String>['None','Breakfast','Lunch','Snacks','Dinner']
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
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () async{
                            setState(() {
                              showSpinner = true;
                            });
                            foodnames.clear();
                            foodprices.clear();
                            if(_foodcat=="None"){
                              setState(() {
                                showSpinner=false;
                              });
                              _showSnackBar("Please Select Food Category from DropDown Menu",Colors.black87);
                            }
                            else{
                              if(await getvaluesfromdatabase(changetimeformat(_dateTime))){
                                _foodcat="None";
                                Navigator.pushReplacementNamed(context,AddEntryFinal.id,arguments: Addentrysc1(date: changetimeformat(_dateTime),mealtype: _foodcat,foodlists:foodnames,fooditemcost:foodprices) );
                              }
                            }
                            setState(() {
                              showSpinner=false;
                            });

                          },
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> getvaluesfromdatabase(String date) async{
    try{
      QuerySnapshot querySnapshot =await _firestore.collection('DailyFoodMenu').document(workspace).collection("Menu").document(date).collection(_foodcat).getDocuments();
      var documents = querySnapshot.documents;
      print(documents);
      for(int i=0;i<documents.length;i++){
        foodnames.add(documents[i].data["itemname"]);
        foodprices.add(documents[i].data["itemprice"]);
      }
    }
    catch(e){
      print(e.message);
    }

    return true;
  }
}

//for formatting date
changetimeformat(@required DateTime datetimepicked)
{
  String formattedDate = DateFormat('dd-MM-yyyy').format(datetimepicked);

  return formattedDate;

}