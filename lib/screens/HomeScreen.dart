import 'package:ecommerce_app/model/MyProduct.dart';
import 'package:ecommerce_app/screens/DetailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/ProductCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int isSelected = 0;


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Our Products',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              buildProductCategory(index: 0, name: 'All Products'),
              buildProductCategory(index: 1, name: 'Jackets'),
              buildProductCategory(index: 2, name: 'Sneakers'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: isSelected == 0
                ? buildAllProducts()
                : isSelected == 1
                    ? buildjackets()
                    : buildsneakers(),
            // Call the buildAllProducts method here
          ),
        ],
      ),
    );
  }

  buildProductCategory({required int index, required String name}) =>
      GestureDetector(
        onTap: () => setState(() => isSelected = index),
        child: Container(
          width: 100,
          height: 40,
          margin: const EdgeInsets.only(top: 10, right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected == index ? Colors.red : Colors.red.shade300,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            name,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  buildAllProducts() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0, // Horizontal spacing between items
          mainAxisSpacing: 10.0, // Vertical spacing between items
          childAspectRatio: 0.75, // Aspect ratio for each item
        ),
        scrollDirection: Axis.vertical,
        itemCount: MyProduct.allProducts.length,
        itemBuilder: (BuildContext context, int index) {
          final allProducts = MyProduct.allProducts[index];
          return GestureDetector(
            onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailsScreen(product: allProducts))),
              child: ProductCard(
            product: allProducts,
          ));
        },
      );

  buildjackets() => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 10.0, // Horizontal spacing between items
        mainAxisSpacing: 10.0, // Vertical spacing between items
        childAspectRatio: 0.75, // Aspect ratio for each item
      ),
      scrollDirection: Axis.vertical,
      itemCount: MyProduct.jackets.length,
      itemBuilder: (BuildContext context, int index) {
        final jackets = MyProduct.jackets[index];
        return GestureDetector(
            onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailsScreen(product: jackets))),
            child: ProductCard(
              product: jackets,
            ));
      });

  buildsneakers() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10.0, // Horizontal spacing between items
          mainAxisSpacing: 10.0, // Vertical spacing between items
          childAspectRatio: 0.75, // Aspect ratio for each item
        ),
        scrollDirection: Axis.vertical,
        itemCount: MyProduct.sneakers.length,
        itemBuilder: (BuildContext context, int index) {
          final sneakers = MyProduct.sneakers[index];
          return GestureDetector(
              onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>DetailsScreen(product: sneakers))),
              child: ProductCard(
                product: sneakers,
              ));
        },
      );
}
