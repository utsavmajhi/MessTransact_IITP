import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messtransacts/Screens/AddEntryScreens/AEdatefoodtype.dart';
import 'package:messtransacts/Screens/WillyHome.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:messtransacts/Screens/AllLogData.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messtransacts/Passarguments/Addentrysc1.dart';
import 'package:messtransacts/utils/roundedbuttonsmall.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import "dart:collection";
final _firestore=Firestore.instance;

List<String> tablecat=["Breakfast","Lunch","Snacks","Dinner"];
class UpdateDataCloud extends StatefulWidget {
  static String id='updatedatatocloud_screen';

  @override
  _UpdateDataCloudState createState() => _UpdateDataCloudState();
}

class _UpdateDataCloudState extends State<UpdateDataCloud> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  String workspace="";
  List<String> uniqueitems=[];
  List<EntryModel> m=List<EntryModel>();
  List<EntryModel> entryList1;
  DateTime _dateTime=DateTime.now();//date picker from calendar
  String lastupdate="";

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
    super.initState();
    getvaluesfromshared();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:Colors.red[600],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
            'Log Data'
        ),

      ),
      body: StreamBuilder(
        stream:  _firestore.collection("CloudDataEvents").document(workspace).collection("DataAnalysis").document(changetimeformat(_dateTime)).snapshots(),
        builder: (context,snapshot){
          if((snapshot.hasData)){
                try{
                  lastupdate=snapshot.data['LastUpdate'];
                }
                catch(e){
                    lastupdate="Not Updated";
                }
//                finally{
//                  lastupdate="Not Updated";
//                }
          }
          else{
            lastupdate="Not Updated";
            //lastupdate=snapshot.data['LastUpdate'];
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center ,
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
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
                              child: SvgPicture.asset('images/cloud.svg',fit: BoxFit.contain,),
                            ),
                          ),
                          Text(
                            "Save Your Precious data to Cloud",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Last Update : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              Text("$lastupdate"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Select Entry Date',
                            style: TextStyle(
                                fontSize: 18
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
                          GestureDetector(
                            onTap: (){
                              //Navigator.pushNamed(context,LogDataAnalysis.id,arguments: LogdataDateargs(changetimeformat(_dateTime)));
                              print(_dateTime);
                              updateListView(changetimeformat(_dateTime));
                              lastupdatetime(_dateTime);

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
          );
        },
      ),

    );
  }
  changetimeformat(@required DateTime datetimepicked)
  {
    String formattedDate = DateFormat('dd-MM-yyyy').format(datetimepicked);

    return formattedDate;

  }

  changetimeformattype2(@required DateTime datetimepicked)
  {
    DateTime _nowTime=DateTime.now();
    String formattedtime=DateFormat('h:mm a').format(_nowTime);
    String formattedDate = DateFormat('EEE, MMM d, ').format(datetimepicked);

    return formattedDate+formattedtime;

  }
  void updateListView(String date) {

    for(int table=0;table<4;table++)
    {
      final Future<Database> dbFuture = databaseHelper.initializeDatabase();
      dbFuture.then((database) {

        Future<List<EntryModel>> noteListFuture = databaseHelper.getNoteList1(date,2,"",tablecat[table]);
        noteListFuture.then((entryList) {
          if(entryList!=null||entryList.isNotEmpty)
          {
            for(int i=0;i<entryList.length;i++)
            {
              uniqueitems.add(entryList[i].FoodCat);
            }
            setState(() {
              this.entryList1 = entryList;
            });
            uniqueitems = LinkedHashSet<String>.from(uniqueitems).toList();

            print("Unique items:$uniqueitems");
            setentries(table,date);
          }

        });
      });
      uniqueitems.clear();
    }


  }
  void setentries(int table, String date){

    for(int ui=0;ui<uniqueitems.length;ui++)
    {
      int GPay=0,Cash=0,Khaata=0;
      int totQuantity=0;
      Future<List<EntryModel>> noteListFuture2 = databaseHelper.getNoteList1(date, 3, uniqueitems[ui],tablecat[table]);
      noteListFuture2.then((entryList) {
        this.m=entryList;
        print(m[0].FoodCat);
      }).then((value){
        print(m.length);
        for(int k=0;k<m.length;k++)
        {
          totQuantity=totQuantity+m[k].Quantity;
          if(m[k].Payment=="Cash")
          {
            Cash=Cash+m[k].Quantity;
          }
          if(m[k].Payment=="GPay")
          {
            GPay=GPay+m[k].Quantity;
          }
          if(m[k].Payment=="Khaata")
          {
            Khaata=Khaata+m[k].Quantity;
          }

        }

        switch(table){
          case 0:{
            _firestore.collection("CloudDataEvents").document(workspace).collection("DataAnalysis").document(changetimeformat(_dateTime)).collection("Breakfast").document(uniqueitems[ui]).setData({
              "ItemName":uniqueitems[ui],
              "Quantity":totQuantity.toString(),
              "Cash":Cash.toString(),
              "GPay":GPay.toString(),
              "Khaata":Khaata.toString(),
              "TotalAmt":(totQuantity*m[0].Amount).toString(),
            });
            break;
          }
          case 1:
            _firestore.collection("CloudDataEvents").document(workspace).collection("DataAnalysis").document(changetimeformat(_dateTime)).collection("Lunch").document(uniqueitems[ui]).setData({
              "ItemName":uniqueitems[ui],
              "Quantity":totQuantity.toString(),
              "Cash":Cash.toString(),
              "GPay":GPay.toString(),
              "Khaata":Khaata.toString(),
              "TotalAmt":(totQuantity*m[0].Amount).toString(),
            });
            break;
          case 2:_firestore.collection("CloudDataEvents").document(workspace).collection("DataAnalysis").document(changetimeformat(_dateTime)).collection("Snacks").document(uniqueitems[ui]).setData({
            "ItemName":uniqueitems[ui],
            "Quantity":totQuantity.toString(),
            "Cash":Cash.toString(),
            "GPay":GPay.toString(),
            "Khaata":Khaata.toString(),
            "TotalAmt":(totQuantity*m[0].Amount).toString(),
          });
          break;
          case 3:
            _firestore.collection("CloudDataEvents").document(workspace).collection("DataAnalysis").document(changetimeformat(_dateTime)).collection("Dinner").document(uniqueitems[ui]).setData({
              "ItemName":uniqueitems[ui],
              "Quantity":totQuantity.toString(),
              "Cash":Cash.toString(),
              "GPay":GPay.toString(),
              "Khaata":Khaata.toString(),
              "TotalAmt":(totQuantity*m[0].Amount).toString(),
            });
            break;
        }
      });

    }

  }
  
  void lastupdatetime(DateTime dateTime){
    _firestore.collection("CloudDataEvents").document(workspace).collection("DataAnalysis").document(changetimeformat(dateTime)).setData({
      'LastUpdate':changetimeformattype2(dateTime),
    }).then((value) => _showSnackBar("Successfully Updated", Colors.green[600]));
    
  }
}
