import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_build_shopping_card1/cart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
class DBHelper{
  //static Database? _database;
  static const String databaseName="cart.db";
  static const String tbcart="mycart";
  static const String colid='id';
  static const String colproductId='productId';
  static const String colproductName='productName';
  static const String colinitialPrice='initialPrice';
  static const String colproductPrice='productPrice';
  static const String colquantity='quantity';
  static const String colunitTag='unitTag';
  static const String colimage='image';

  Future<Database> database() async{
    Directory directory = await getTemporaryDirectory();
    String directoryTemp = directory.path;
    Directory appDirectory = await getApplicationDocumentsDirectory();
     String appDocPath = appDirectory.path;
    String path = await getDatabasesPath();

    return openDatabase(
      join(path,databaseName),
      version: 1,
      onCreate: (db, version) async{
        return db.execute(
          'CREATE TABLE $tbcart($colid INTEGER PRIMARY KEY,$colproductId VACHAR UNIQUE, $colproductName TEXT, $colinitialPrice INTEGER, $colproductPrice INTEGER, $colunitTag TEXT, $colimage TEXT, $colquantity INTEGER)'
        );
      },
    );
  //   if(_database != null){
  //     return _database;
  //   }
  //   _database = await initDatabase();
  //   return null;
  // }
  // initDatabase() async{
  //   io.Directory directory = await getApplicationDocumentsDirectory();
  //   String path = join(directory.path,mydb);
  //   var db = await openDatabase(path,version: 1,onCreate: _onCreate);
  //   return db;
  // }
  
  // _onCreate(Database db,int version)async{
  //   await db.execute(
  //     'CREATE TABLE $table($colid INTEGER PRIMARY KEY, $colproductId VARCHAR UNIQUE, $colproductName TEXT, $colinitialPrice INTEGER, $colproductPrice INTEGER,$colunitTag TEXT, $colimage TEXT, $colquantity INTEGER)'
  //   );
  }

  Future<Cart> insert(Cart cart)async{
    var dbClient = await database();
    await dbClient.insert(
      tbcart,
      cart.toMap()
      );
      debugPrint('Insert successful');
      return cart;
  }


  Future<List<Cart>> getCartList()async{
    var dbClient = await  database();

    final List<Map<String, Object?>> queryResult =
       await dbClient.query(tbcart);
       return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int> updateQuantity(Cart cart) async{
    var dbClient = await database();
    return await dbClient.update(
      tbcart, 
      cart.quantitityMap(),
      where: colproductId,
      whereArgs: [cart.productId]
      );
  }

  Future <int> deleteCarItem(int id)async{
    var dbClient = await database();
    return await dbClient.delete(
      tbcart,
      where: colid,
      whereArgs: [id]
    );
  }
  


}