import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:messtransacts/models/EntryModel.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String entryTable = 'entry_table';
  String colId = 'id';
  String colMealType = 'MealType';
  String colFoodCat = 'FoodCat';
  String colPayment = 'Payment';
  String colAmount = 'Amount';
  String colQuantity = 'Quantity';
  String colDate = 'date';
  String nullColumnHack="nullColumnHack";
  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper
  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }
  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'entry.db';

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 2, onCreate: _createDb);
    return notesDatabase;
  }
  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $entryTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colMealType TEXT, '
        '$colFoodCat TEXT, $colPayment TEXT, $colAmount REAL, $colQuantity INTEGER, $colDate TEXT )');
  }
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(entryTable, orderBy: '$colFoodCat ASC');
    return result;
  }
  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(EntryModel entry) async {
    Database db = await this.database;
    var result = await db.insert(entryTable, entry.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(EntryModel entry) async {
    var db = await this.database;
    var result = await db.update(entryTable, entry.toMap(), where: '$colId = ?', whereArgs: [entry.id]);
    return result;
  }
  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $entryTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $entryTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<EntryModel>> getNoteList() async {

    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count = noteMapList.length;         // Count the number of map entries in db table

    List<EntryModel> noteList = List<EntryModel>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(EntryModel.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

}