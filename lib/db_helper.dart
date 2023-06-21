import 'package:flutter_build_shopping_card1/cart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
class DBHelper{
  static Database? _database;
  static const String mydb="cart.db";
  static const String table="tbcart";
  static const String colid='id';
  static const String colproductId='productId';
  static const String colproductName='productName';
  static const String colinitialPrice='initialPrice';
  static const String colquantity='quantity';
  static const String colunitTag='unitTag';
  static const String colimage='image';
  Future<Database?> get database async{
    if(_database != null){
      return _database;
    }
    _database = await initDatabase();
    return null;
  }
  initDatabase() async{
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,mydb);
    var db = await openDatabase(path,version: 1,onCreate: _onCreate);
  }
  
  _onCreate(Database db,int version)async{
    await db.execute(
      'CREATE TABLE $table($colid PRIMARY KEY, $colproductId VARCHAR UNIQUE, $colproductName TEXT, $colinitialPrice INTEGER, $colquantity INTEGER, $colunitTag TEXT)'
    );
  }

  Future<List<Cart>> getCartList()async{
    var dbClient = await database;

    final List<Map<String, Object?>> queryResult =
       await dbClient!.query(table);
       return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int> updateQuantity(Cart cart) async{
    var dbClient = await database;
    return await dbClient!.update(
      table, 
      cart.quantitityMap(),
      where: colproductId,
      whereArgs: [cart.productId]
      );
  }

  Future <int> deleteCarItem(int id)async{
    var dbClient = await database;
    return await dbClient!.delete(
      table,
      where: colid,
      whereArgs: [id]
    );
  }
  


}