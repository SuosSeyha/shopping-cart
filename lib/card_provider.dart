import 'package:flutter/material.dart';
import 'package:flutter_build_shopping_card1/cart.dart';
import 'package:flutter_build_shopping_card1/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardProvider with ChangeNotifier{
  DBHelper dbHelper = DBHelper();
  static const String keyCartItem='cart_items';
  static const String keyItemQuantity='item_quantity';
  static const String keyTotalPrice='total_price';
  int _counter =0;
  int _quantity =1;
  double _totalPrice=0.0;
  List<Cart> cart =[];
  int get counter => _counter;
  int get quantity => _quantity;
  double get totalPrice => _totalPrice;

  Future<List<Cart>> getData()async{
    cart = await dbHelper.getCartList();
    notifyListeners();
    return cart;
  }

  void _setPrefsItems() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(keyCartItem, _counter);
    preferences.setInt(keyItemQuantity, _quantity);
    preferences.setDouble(keyTotalPrice, _totalPrice);
  }

  void _getPrefsItem()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _counter = preferences.getInt(keyCartItem) ?? 0;
    _quantity = preferences.getInt(keyItemQuantity) ?? 0;
    _totalPrice = preferences.getDouble(keyTotalPrice) ?? 0.0;
  }

  void addCounter(){
    _counter++;
  _setPrefsItems();
  notifyListeners();
  }

  void removeCounter(){
    _counter++;
    _setPrefsItems();
    notifyListeners();
  }
   
  int getCounter(){
    _getPrefsItem();
    return _counter;
  }

  void addQuantity(int id){
    final index = cart.indexWhere((element) => element.id ==id);
    cart[index].quantity!.value +=1;
    _setPrefsItems();
    notifyListeners();
  }

  void deleteQuantity(int id){
    final index = cart.indexWhere((element) => element.id == id);
    final currentQuantity = cart[index].quantity!.value;

    if(currentQuantity<=1){
      currentQuantity==1;
    }else{
      cart[index].quantity!.value = currentQuantity-1;
    }
    _setPrefsItems();
    notifyListeners();
  }

  void removeItem(int id){
    final index = cart.indexWhere((element) => element.id == id);
    cart.removeAt(index);
    _setPrefsItems();
    notifyListeners();
  }

  int getQuantity(int quantitity){
    _getPrefsItem();
    return _quantity;
  }

  void addTotolPrice(double productPrice){
    _totalPrice += productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice){
    _totalPrice -= productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  double getTotalPrice(){
    _getPrefsItem();
    return _totalPrice;
  }
}