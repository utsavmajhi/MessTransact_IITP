import 'package:flutter/material.dart';
import 'package:messtransacts/Screens/AddEntryScreens/AEdatefoodtype.dart';
import 'package:messtransacts/Screens/WillyHome.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messtransacts/Screens/AllLogData.dart';
import 'package:intl/intl.dart';
import 'package:messtransacts/Passarguments/Addentrysc1.dart';
import 'package:messtransacts/utils/roundedbuttonsmall.dart';
import 'package:messtransacts/models/EntryModel.dart';
import 'package:messtransacts/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';



class AddEntryFinal extends StatefulWidget {

  static String id='addentryfinal_screen';
  @override
  _AddEntryFinalState createState() => _AddEntryFinalState();
}

class _AddEntryFinalState extends State<AddEntryFinal> {
  List<int> itemquan=List<int>();
  DatabaseHelper databaseHelper = DatabaseHelper();
  int selectradio;
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  _showSnackBar(@required String message, @required Color colors) {
    if(_scaffoldKey!=null)
    {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: colors,
          content: new Text(message,
          style: TextStyle(
            color: Colors.white,
          ),),
          duration: new Duration(seconds: 1),
        ),
      );
    }

  }
//RADIO BUTTONS DESCRIPSTION: 1-Cash 2-Gpay 3-Khata
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectradio=0;

    Future.delayed(Duration.zero,(){
      Addentrysc1 addentrysc1Data=ModalRoute.of(context).settings.arguments;
      setState(() {
        for(int i=0;i<addentrysc1Data.foodlists.length;i++)
        {
          itemquan.add(0);
        }
      });

    });
  }


  setSelectedRadio(int val){
  setState(() {
    selectradio=val;
  });
  }

  @override
  Widget build(BuildContext context) {
    Addentrysc1 addentrysc1Data=ModalRoute.of(context).settings.arguments;
    if(itemquan.isEmpty)
      {
        return Text('Loading');
      }else{
      return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(left: 8  ),
                    iconSize: 18,
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, AEdatefoodtype.id);
                    },
                  ) ,
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.red[500],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              addentrysc1Data.date,
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),

                          ],
                        ),
                        Column(
                          children: <Widget>[
                            CircleAvatar(
                              child:Icon(Icons.fastfood),
                            ),
                            Text(
                              addentrysc1Data.mealtype,
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              addentrysc1Data.workspace+"    ",
                              style: GoogleFonts.montserrat(

                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.red,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text('Select the Mode of Payment',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                        ),),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                value:1,
                                groupValue: selectradio,
                                activeColor: Colors.white,
                                onChanged: (value){
                                  print(value);
                                  setSelectedRadio(value);
                                },
                              ),
                              Text(
                                'Cash',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                value:2,
                                groupValue: selectradio,
                                activeColor: Colors.white,
                                onChanged: (value){
                                  print(value);
                                  setSelectedRadio(value);
                                },
                              ),
                              Text(
                                'GPay',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                value:3,
                                groupValue: selectradio,
                                activeColor: Colors.white,
                                onChanged: (value){
                                  print(value);
                                  setSelectedRadio(value);
                                },
                              ),
                              Text(
                                'Khaata',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MediaQuery.removePadding(
                  removeBottom: true,
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      itemCount: addentrysc1Data.foodlists.length,
                      itemBuilder: (context,index){
                        String itemname=addentrysc1Data.foodlists[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 0),
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                        itemname,
                                      style: GoogleFonts.droidSans(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right:60),
                                    child: Text(
                                      'Quantity: '+itemquan[index].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      InkWell(
                                        onTap:(){

                                          setState(() {
                                            itemquan[index]=itemquan[index]+1;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(

                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap:(){
                                          setState(() {
                                            if(itemquan[index]!=0){
                                              itemquan[index]=itemquan[index]-1;
                                            }

                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(

                                            child: Icon(Icons.remove),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0,bottom: 20,left: 8,right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                    RoundedButtonSmall(title: 'Submit',colour: Colors.deepOrange,onPressed: (){
                      //click on submit button
                      String checks=checkConditions(addentrysc1Data.mealtype, selectradio,itemquan);
                      if(checks=="Passed")
                        {
                          for(int i=0;i<addentrysc1Data.foodlists.length;i++)
                          {
                            if(itemquan[i]!=0)
                            {
                              EntryModel entryitem=new EntryModel(addentrysc1Data.mealtype, addentrysc1Data.foodlists[i],radiobutton(selectradio), addentrysc1Data.fooditemcost[i], itemquan[i],addentrysc1Data.date);
                              try {
                                if(_save(entryitem)=="Success"){


                                }
                              }catch (e) {
                                _showSnackBar(e.message,Colors.black);
                              }
                            }

                          }
                          _showSnackBar("Successfully Submitted",Colors.green);
                          setState(() {
                            //default states
                            selectradio=0;
                            for(int i=0;i<itemquan.length;i++){
                              itemquan[i]=0;
                            }

                          });
                        }else{
                        _showSnackBar(checks,Colors.black);
                      }






                    },),
                    RoundedButtonSmall(title: 'Reset',colour: Colors.black,onPressed: (){
                      //click on reset button
                      setState(() {
                        //default states
                        selectradio=0;
                        for(int i=0;i<itemquan.length;i++){
                          itemquan[i]=0;
                        }

                      });
                    },),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

  }
  Future<String> _save(@required EntryModel entryItem) async {

    int result;
      result = await databaseHelper.insertNote(entryItem);


    if(await result!=0)
    {
      print("success");
      print(entryItem);
      return "Success";
    }

  }
  String radiobutton(@required int value){
    switch(value){
      case 1:return "Cash";
      case 2:return "GPay";
      case 3:return "Khaata";
      default:return "Cash";
    }
  }

  String checkConditions(@required String Mealtype,int radiobutton, List<int> itemquan){
    if(radiobutton==0){
      return "Please Select Payment Mode!";
    }
    else
      {
        if(Mealtype.isEmpty){
          return "Please reset and retry!";
        }else{
          int temp=0;
          for(int i=0;i<itemquan.length;i++)
            {
              temp=temp+itemquan[i];
            }
          if(temp==0)
            {
              return "No Quantity has been defined";
            }else{
            return "Passed";
          }


        }
      }

  }
}
