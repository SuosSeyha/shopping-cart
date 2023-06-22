import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_build_shopping_card1/card_provider.dart';
import 'package:flutter_build_shopping_card1/cart.dart';
import 'package:flutter_build_shopping_card1/cart_screen.dart';
import 'package:flutter_build_shopping_card1/db_helper.dart';
import 'package:flutter_build_shopping_card1/list_item.dart';
import 'package:flutter_build_shopping_card1/widget.dart';
import 'package:provider/provider.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  
  CardProvider cardProvider = CardProvider();
  DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CardProvider>(context);
    void saveData(int index){
        dbHelper.insert(
          Cart(
            id: index, 
            productId: index.toString(), 
            productName: products[index].name, 
            initialPrice: products[index].price, 
            productPrice: products[index].price, 
            unitTag: products[index].unit, 
            image: products[index].image, 
            quantity: ValueNotifier(1)
            )
        ).then((value){
          cart.addTotolPrice(products[index].price.toDouble());
          cart.addCounter();
          debugPrint(' Product added to cart');
        }).onError((error, stackTrace){
          debugPrint(error.toString());
        });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: const Text(
          'List Product'
        ),
        actions: [
         badges.Badge(
          badgeContent: Text(
            cardProvider.getCounter().toString()
          ),
          position: const BadgePosition(start: 25, bottom: 25),
          child: IconButton(
            onPressed: () {
              nextScreen(context, const CartScreen());
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ),
        const SizedBox(
          width: 10,
        )
        ],
      ),

      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(
                        10
                      )
                    ),
                  ),
                  // image
                  Image.asset(
                    products[index].image,
                    height: 100,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                   Positioned(
                    left: 110,
                    top: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${products[index].name}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                         Text(
                          'Unit: ${products[index].unit}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                         Text(
                          'Price: ${products[index].price}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 50,
                    child: InkWell(
                      onTap: () {
                        saveData(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20
                          ),
                          color: Colors.white,
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold
                            ),
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}