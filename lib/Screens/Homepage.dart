import 'package:flutter/material.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
EntryModel entryfake=new EntryModel("Breakfasewft", "FowerweodCat"," Paymerewrewnt", 200, 3);
class Homepage extends StatefulWidget {
  static String id='home_screen';
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<EntryModel> entryList;

  int count = 0;
  @override
  Widget build(BuildContext context) {

    if (entryList == null) {
      entryList = List<EntryModel>();
      updateListView();
    }
    return Scaffold(
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){


              try {
                _save();
              }catch (e) {
                // TODO
                print(e.message);
              }

        },
        child: Icon(Icons.add),
      ),
    );
  }
  ListView getNoteListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            title: Text(this.entryList[position].MealType, style: titleStyle,),

            subtitle: Text(this.entryList[position].FoodCat),

          ),
        );
      },
    );
  }
  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<EntryModel>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((entryList) {
        setState(() {
          this.entryList = entryList;
          this.count = entryList.length;
        });
      });
    });
  }
  void _save() async {

    int result;
    if (entryfake.id != null) {  // Case 1: Update operation
      print("null id");
    } else { // Case 2: Insert Operation
      result = await databaseHelper.insertNote(entryfake);
      print("Entering");
    }
    if(result!=0)
      {
        print("Success");
      }

  }
}
