import 'package:flutter/material.dart';
class Cart {
 late final int? id;
 final String? productId;
 final String? productName;
 final int? initialPrice;
 final int? productPrice;
 final ValueNotifier<int>? quantity;
 final String? unitTag;
 final String? image;

 Cart({
  required this.id,
  required this.productId,
  required this.productName,
  required this.initialPrice,
  required this.productPrice,
  required this.unitTag,
  required this.image,
  required this.quantity,
 });

 Map<String,dynamic> toMap(){
  return {
    'id': id,
    'productId': productId,
    'productName': productName,
    'initialPrice': initialPrice,
    'productPrice': productPrice,
    'unitTag': unitTag,
    'image': image,
    'quantity': quantity!.value
  };
 }

 Map<String,dynamic> quantitityMap(){
  return {
    'quantity':quantity
  };
 }

 Cart.fromMap(Map<String,dynamic> data) 
  : id = data['id'],
    productId = data['productId'],
    productName = data['productName'],
    initialPrice = data['initialPrice'],
    productPrice = data['productPrice'],
    unitTag = data['unitTag'],
    image = data['image'],
    quantity = ValueNotifier(data['quantity']);
}