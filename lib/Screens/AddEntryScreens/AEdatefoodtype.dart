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
final _firestore=Firestore.instance;
List<String> foodnames=[];
List<double> foodprices=[];
class AEdatefoodtype extends StatefulWidget {
    static String id='aedatefood_screen';
  @override
  _AEdatefoodtypeState createState() => _AEdatefoodtypeState();
}

class _AEdatefoodtypeState extends State<AEdatefoodtype> {
  DateTime _dateTime=DateTime.now();  //date picker from calendar
  String _foodcat='None';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Add Entry'
        ),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red[600],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Select Entry Date',
                          style: TextStyle(
                            fontSize: 22
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
                              fontSize: 22
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
                            foodnames.clear();
                            foodprices.clear();
                            if(await getvaluesfromdatabase(changetimeformat(_dateTime))){
                              Navigator.pushNamed(context,AddEntryFinal.id,arguments: Addentrysc1(date: changetimeformat(_dateTime),mealtype: _foodcat,foodlists:foodnames,fooditemcost:foodprices) );
                            }


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
            ),
          )
        ],
      ),
    );
  }

  Future<bool> getvaluesfromdatabase(String date) async{
    try{
      QuerySnapshot querySnapshot =await _firestore.collection('DailyFoodMenu').document(date).collection(_foodcat).getDocuments();
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