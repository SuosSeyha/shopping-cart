import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  int count=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: const Text(
          'List Product'
        ),
        actions: [
         badges.Badge(
          badgeContent: Text(count.toString()),
          position: const BadgePosition(start: 30, bottom: 30),
          child: IconButton(
            onPressed: () {
              setState(() {
                count++;
              });
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
        ],
      ),
    );
  }
}