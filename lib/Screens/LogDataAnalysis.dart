import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messtransacts/Passarguments/LogdataDateargs.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:messtransacts/Screens/LogDataAnalysis.dart';
import "dart:collection";
List<String> tablecat=["Breakfast","Lunch","Snacks","Dinner"];

class LogDataAnalysis extends StatefulWidget {

  static String id='logdataanalysis_screen';
  @override
  _LogDataAnalysisState createState() => _LogDataAnalysisState();
}

class _LogDataAnalysisState extends State<LogDataAnalysis> {
  DatabaseHelper databaseHelper = DatabaseHelper();

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
  }
  @override
  Widget build(BuildContext context) {
    if (entryList1 == null) {
      LogdataDateargs logdataDateargs=ModalRoute.of(context).settings.arguments;
      entryList1 = List<EntryModel>();
      updateListView(logdataDateargs.date);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Text(
                'BreakFast',
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Type')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Cash')),
                    DataColumn(label: Text('GPay')),
                    DataColumn(label: Text('Khaata')),
                    DataColumn(label: Text('Total Amt'))

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
                            fontSize: 15,
                        ),
                        )),
                        DataCell(Text(element["Cash"],
                          style: TextStyle(
                              fontSize: 15,

                          ),)),
                        DataCell(Text(element["GPay"],
                          style: TextStyle(
                              fontSize: 15,

                          ),)), //Extracting from Map element the value
                        DataCell(Text(element["Khaata"],
                          style: TextStyle(
                              fontSize: 15,
                          ),)),
                        DataCell(Text(element["TotalAmt"],
                          style: TextStyle(
                              fontSize: 15,),)),
                      ],
                    )).toList(),
                ),
              ),
              Text(
                'Lunch',
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Type')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Cash')),
                    DataColumn(label: Text('GPay')),
                    DataColumn(label: Text('Khaata')),
                    DataColumn(label: Text('Total Amt'))

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
                          fontSize: 15,
                        ),
                      )),
                      DataCell(Text(element["Cash"],
                        style: TextStyle(
                          fontSize: 15,

                        ),)),
                      DataCell(Text(element["GPay"],
                        style: TextStyle(
                          fontSize: 15,

                        ),)), //Extracting from Map element the value
                      DataCell(Text(element["Khaata"],
                        style: TextStyle(
                          fontSize: 15,
                        ),)),
                      DataCell(Text(element["TotalAmt"],
                        style: TextStyle(
                          fontSize: 15,),)),
                    ],
                  )).toList(),
                ),
              ),
              Text(
                'Snacks',
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Type')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Cash')),
                    DataColumn(label: Text('GPay')),
                    DataColumn(label: Text('Khaata')),
                    DataColumn(label: Text('Total Amt'))

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
                          fontSize: 15,
                        ),
                      )),
                      DataCell(Text(element["Cash"],
                        style: TextStyle(
                          fontSize: 15,

                        ),)),
                      DataCell(Text(element["GPay"],
                        style: TextStyle(
                          fontSize: 15,

                        ),)), //Extracting from Map element the value
                      DataCell(Text(element["Khaata"],
                        style: TextStyle(
                          fontSize: 15,
                        ),)),
                      DataCell(Text(element["TotalAmt"],
                        style: TextStyle(
                          fontSize: 15,),)),
                    ],
                  )).toList(),
                ),
              ),
              Text(
                'Dinner',
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Type')),
                    DataColumn(label: Text('Quantity')),
                    DataColumn(label: Text('Cash')),
                    DataColumn(label: Text('GPay')),
                    DataColumn(label: Text('Khaata')),
                    DataColumn(label: Text('Total Amt'))

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
                          fontSize: 15,
                        ),
                      )),
                      DataCell(Text(element["Cash"],
                        style: TextStyle(
                          fontSize: 15,

                        ),)),
                      DataCell(Text(element["GPay"],
                        style: TextStyle(
                          fontSize: 15,

                        ),)), //Extracting from Map element the value
                      DataCell(Text(element["Khaata"],
                        style: TextStyle(
                          fontSize: 15,
                        ),)),
                      DataCell(Text(element["TotalAmt"],
                        style: TextStyle(
                          fontSize: 15,),)),
                    ],
                  )).toList(),
                ),
              ),
            ],
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