class EntryModel{
   int _id;
   String _MealType;
   String _FoodCat;
   String _Payment;
   double _Amount;
   int _Quantity;
   String _date;

   String get date => _date;

   set date(String value) {
     _date = value;
   }
   EntryModel(this._MealType, this._FoodCat, this._Payment,
       this._Amount, this._Quantity);
   EntryModel.withId(this._id, this._MealType, this._FoodCat, this._Payment,
       this._Amount, this._Quantity);

   int get Quantity => _Quantity;

   set id(int value) {
     _id = value;
   }

   double get Amount => _Amount;

   String get Payment => _Payment;

   String get FoodCat => _FoodCat;

   String get MealType => _MealType;

   int get id => _id;

   set MealType(String value) {
     _MealType = value;
   }

   set Quantity(int value) {
     _Quantity = value;
   }

   set Amount(double value) {
     _Amount = value;
   }

   set Payment(String value) {
     _Payment = value;
   }

   set FoodCat(String value) {
     _FoodCat = value;
   }
  //converting EntryModel Object to Map object
  Map<String,dynamic> toMap(){
    var map = Map<String, dynamic>();
    if(id!=null)
      {
        map['id']=_id;
      }
      map['MealType']=_MealType;
      map['FoodCat']=_FoodCat;
      map['Payment']=_Payment;
      map['Amount']=_Amount;
      map['Quantity']=_Quantity;
      map['date']=_date;
      return map;

  }
    EntryModel.fromMapObject(Map<String,dynamic> map){
      this._id=map['id'];
      this._MealType=map['MealType'];
      this._FoodCat=map['FoodCat'];
      this._Payment=map['Payment'];
      this._Amount=map['Amount'];
      this._Quantity=map['Quantity'];
      this._date=map['date'];
    }
}