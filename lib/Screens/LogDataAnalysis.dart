import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messtransacts/Passarguments/LogdataDateargs.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:messtransacts/Screens/LogDataAnalysis.dart';
import "dart:collection";
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> tablecat=["Breakfast","Lunch","Snacks","Dinner"];

class LogDataAnalysis extends StatefulWidget {

  static String id='logdataanalysis_screen';
  @override
  _LogDataAnalysisState createState() => _LogDataAnalysisState();
}

class _LogDataAnalysisState extends State<LogDataAnalysis> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  String workspace="";

  List<EntryModel> entryList1;
  List<String> uniqueitems=[];
  List<EntryModel> entrytempList=[];
  List<EntryModel> m=List<EntryModel>();
  final List<Map<String, String>> listOfColumns = [];
  final List<Map<String, String>> listOfColumnsLunch = [];
  final List<Map<String, String>> listOfColumnsSnacks = [];
  final List<Map<String, String>> listOfColumnsDinner = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getvaluesfromshared();
  }
  Future<bool> getvaluesfromshared() async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();

    setState(() {
      workspace=sharedPreferences.getString('workspace');
    });

    return true;
  }
  @override
  Widget build(BuildContext context) {
    if (entryList1 == null) {
      LogdataDateargs logdataDateargs=ModalRoute.of(context).settings.arguments;
      entryList1 = List<EntryModel>();
      updateListView(logdataDateargs.date);
    }
    return Scaffold(
      backgroundColor: Colors.limeAccent[100],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.group_work,size: 35,),
                    Text(workspace,style: GoogleFonts.saira(color:Colors.red,fontSize: 30),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'BreakFast',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,

                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Type',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Quantity',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Cash',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('GPay',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Khaata',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Total Amt',style: TextStyle(fontSize: 18),))

                    ],
                    rows:
                      listOfColumns.map((element) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(element["Type"],style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),)), //Extracting from Map element the value
                          DataCell(Text(element["Quantity"],
                              style: TextStyle(
                              fontSize: 18,
                          ),
                          )),
                          DataCell(Text(element["Cash"],
                            style: TextStyle(
                                fontSize: 18,

                            ),)),
                          DataCell(Text(element["GPay"],
                            style: TextStyle(
                                fontSize: 18,

                            ),)), //Extracting from Map element the value
                          DataCell(Text(element["Khaata"],
                            style: TextStyle(
                                fontSize: 18,
                            ),)),
                          DataCell(Text("Rs "+element["TotalAmt"],
                            style: TextStyle(
                                fontSize: 19,),)),
                        ],
                      )).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Lunch',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,

                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Type',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Quantity',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Cash',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('GPay',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Khaata',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Total Amt',style: TextStyle(fontSize: 18),))

                    ],
                    rows:
                    listOfColumnsLunch.map((element) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text(element["Type"],style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),)), //Extracting from Map element the value
                        DataCell(Text(element["Quantity"],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                        DataCell(Text(element["Cash"],
                          style: TextStyle(
                            fontSize: 18,

                          ),)),
                        DataCell(Text(element["GPay"],
                          style: TextStyle(
                            fontSize: 18,

                          ),)), //Extracting from Map element the value
                        DataCell(Text(element["Khaata"],
                          style: TextStyle(
                            fontSize: 18,
                          ),)),
                        DataCell(Text("Rs "+element["TotalAmt"],
                          style: TextStyle(
                            fontSize: 19,),)),
                      ],
                    )).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Snacks',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,

                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Type',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Quantity',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Cash',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('GPay',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Khaata',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Total Amt',style: TextStyle(fontSize: 18),))

                    ],
                    rows:
                    listOfColumnsSnacks.map((element) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text(element["Type"],style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),)), //Extracting from Map element the value
                        DataCell(Text(element["Quantity"],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                        DataCell(Text(element["Cash"],
                          style: TextStyle(
                            fontSize: 18,

                          ),)),
                        DataCell(Text(element["GPay"],
                          style: TextStyle(
                            fontSize: 18,

                          ),)), //Extracting from Map element the value
                        DataCell(Text(element["Khaata"],
                          style: TextStyle(
                            fontSize: 18,
                          ),)),
                        DataCell(Text("Rs "+element["TotalAmt"],
                          style: TextStyle(
                            fontSize: 19,),)),
                      ],
                    )).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Dinner',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,

                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Type',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Quantity',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Cash',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('GPay',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Khaata',style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('Total Amt',style: TextStyle(fontSize: 18),))

                    ],
                    rows:
                    listOfColumnsDinner.map((element) => DataRow(

                      cells: <DataCell>[
                        DataCell(Text(element["Type"],style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),)), //Extracting from Map element the value
                        DataCell(Text(element["Quantity"],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                        DataCell(Text(element["Cash"],
                          style: TextStyle(
                            fontSize: 18,

                          ),)),
                        DataCell(Text(element["GPay"],
                          style: TextStyle(
                            fontSize: 18,

                          ),)), //Extracting from Map element the value
                        DataCell(Text(element["Khaata"],
                          style: TextStyle(
                            fontSize: 18,
                          ),)),
                        DataCell(Text("Rs "+element["TotalAmt"],
                          style: TextStyle(
                            fontSize: 19,),)),
                      ],
                    )).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
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

      setState(() {

        switch(table){
          case 0:{
            listOfColumns.add({
            "Type":uniqueitems[ui],
            "Quantity":totQuantity.toString(),
            "Cash":Cash.toString(),
            "GPay":GPay.toString(),
            "Khaata":Khaata.toString(),
            "TotalAmt":(totQuantity*m[0].Amount).toString(),
          });
          break;
          }

          case 1:
            listOfColumnsLunch.add({
            "Type":uniqueitems[ui],
            "Quantity":totQuantity.toString(),
            "Cash":Cash.toString(),
            "GPay":GPay.toString(),
            "Khaata":Khaata.toString(),
            "TotalAmt":(totQuantity*m[0].Amount).toString(),
          });
            break;
          case 2:listOfColumnsSnacks.add({
            "Type":uniqueitems[ui],
            "Quantity":totQuantity.toString(),
            "Cash":Cash.toString(),
            "GPay":GPay.toString(),
            "Khaata":Khaata.toString(),
            "TotalAmt":(totQuantity*m[0].Amount).toString(),
          });
          break;
          case 3:
            listOfColumnsDinner.add({
              "Type":uniqueitems[ui],
              "Quantity":totQuantity.toString(),
              "Cash":Cash.toString(),
              "GPay":GPay.toString(),
              "Khaata":Khaata.toString(),
              "TotalAmt":(totQuantity*m[0].Amount).toString(),
            });
            break;
        }

      });
      });

      }

  }
}
