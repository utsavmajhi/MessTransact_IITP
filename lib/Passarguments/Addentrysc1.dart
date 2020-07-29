import 'package:flutter/cupertino.dart';

class Addentrysc1{
  String date;
  String mealtype;
  String workspace;
  List<String> foodlists;
  List<double> fooditemcost;

  Addentrysc1({this.date, this.mealtype,@required this.foodlists,this.fooditemcost,this.workspace});
}