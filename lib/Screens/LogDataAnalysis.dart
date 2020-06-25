import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:rxdart/rxdart.dart';
import "dart:collection";
class LogDataAnalysis extends StatefulWidget {
  static String id='logdataanalysis_screen';
  @override
  _LogDataAnalysisState createState() => _LogDataAnalysisState();
}

class _LogDataAnalysisState extends State<LogDataAnalysis> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<EntryModel> entryList1;
  List<String> uniqueitems=[];
  List<EntryModel> entrytempList;
  final List<Map<String, String>> listOfColumns = [];
  @override
  Widget build(BuildContext context) {
    if (entryList1 == null) {
      entryList1 = List<EntryModel>();
      updateListView();
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
              )
            ],
          ),
        ),
      ),

    );
  }
  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<EntryModel>> noteListFuture = databaseHelper.getNoteList1();
      noteListFuture.then((entryList) {
        for(int i=0;i<entryList.length;i++)
        {
          uniqueitems.add(entryList[i].FoodCat);
        }
        setState(() {
          this.entryList1 = entryList;
          uniqueitems = LinkedHashSet<String>.from(uniqueitems).toList();
          print(uniqueitems);
          setentries();
          print("Unique items:$uniqueitems");
        });
      });
    });
  }
  void setentries(){
    List<DataCell> dataentrylist;
    for(int i=0;i<entryList1.length;i++)
      {
        listOfColumns.add({
          "Type":entryList1[i].FoodCat,
          "Quantity":entryList1[i].Quantity.toString(),
          "Cash":"45",
          "GPay":"76",
          "Khaata":"78",
          "TotalAmt":(entryList1[i].Quantity*entryList1[i].Amount).toString(),
        });
      }
    print(listOfColumns);
  }

}
