import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter_build_shopping_card1/card_provider.dart';
import 'package:flutter_build_shopping_card1/widget.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatelessWidget {
   CartScreen({super.key});
  CardProvider cardProvider = CardProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: const Text(
          'My Shooping Cart'
        ),
        actions: [
         badges.Badge(
          badgeContent: Consumer<CardProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                );
              },
          ),
          position: const BadgePosition(start: 25, bottom: 25),
          child: IconButton(
            onPressed: () {
              nextScreen(context,  CartScreen());
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
        const SizedBox(
          width: 10,
        )
        ],
      ),
      

    );
  }
}