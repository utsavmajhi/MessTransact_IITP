import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messtransacts/Passarguments/Addentrysc1.dart';
import 'package:messtransacts/Screens/AddEntryScreens/AddEntryFinal.dart';
import 'package:messtransacts/Passarguments/LogdataDateargs.dart';
import 'package:messtransacts/Screens/LogDataAnalysis.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AllLogDataDateSelec extends StatefulWidget {
  static String id='alllogdatadate_screen';
  @override
  _AllLogDataDateSelecState createState() => _AllLogDataDateSelecState();
}

class _AllLogDataDateSelecState extends State<AllLogDataDateSelec> {
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
      backgroundColor:Colors.red[600],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
            'Log Data'
        ),

      ),
      body: Column(
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
                          backgroundColor: Colors.transparent,
                          radius: 45,
                          child: SvgPicture.asset('images/result.svg',fit: BoxFit.contain,),
                        ),
                      ),
                      Text(
                        "Log Entries",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Select Entry Date',
                        style: TextStyle(
                            fontSize: 19,
                          fontWeight: FontWeight.bold
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
                          Navigator.pushNamed(context,LogDataAnalysis.id,arguments: LogdataDateargs(changetimeformat(_dateTime)));
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
    );
  }
}
//for formatting date
changetimeformat(@required DateTime datetimepicked)
{
  String formattedDate = DateFormat('dd-MM-yyyy').format(datetimepicked);

  return formattedDate;

}