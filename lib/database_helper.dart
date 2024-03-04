import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_app/contact_model.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database?> get dbMethod async {
     if (_database != null) {
       return _database;
     }
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    // print('Suraj: ${documentDirectory}');
    String path = join(documentDirectory.path, 'contacts_database.db');
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, contactNo TEXT, description TEXT)',
    );
  }

  Future<void> insertContact(Contact contact) async {
    Database? database = await dbMethod;
    if (database != null) {
      await database.insert('contacts', contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
      print("insert Printing ID :  ${contact.toMap()}");
    }
  }

  Future<List<Contact>> getAllContacts() async {
    Database? database = await dbMethod;
    if (database != null) {
      final List<Map<String, dynamic>> maps = await database.query('contacts');
      return maps.map((index) => Contact.fromMap(index)).toList();
      
      // return List.generate(maps.length, (index) {
      //   return Contact(
      //     id: maps[index]['id'],
      //     name: maps[index]['name'],
      //     contactNo: maps[index]['contactNo'],
      //     description: maps[index]['description'],
      //   );
      // });
    }
    return [];
  }

  Future<void> updateContact(Contact contact) async {
    Database? database = await dbMethod;
    if (database != null) {
      await database.update('contacts', contact.toMap(),
        where: 'id = ?',
        whereArgs: [contact.id],
      );
      print("update Printing ID :  ${contact.toMap()}");
    }
  }

  Future<void> deleteContact(int id) async {
    Database? database = await dbMethod;
    if (database != null) {
      await database.delete('contacts',
        where: 'id = ?',
        whereArgs: [id],
      );
    }
  }
}
