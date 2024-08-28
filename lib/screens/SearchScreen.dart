import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:ecommerce_app/model/MyProduct.dart';
import 'package:ecommerce_app/screens/DetailsScreen.dart';
import '../model/Product.dart';
import '../widgets/ProductCard.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";
  List<Product> filteredProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchQuery = value.toLowerCase(); // Convert to lowercase for case-insensitive search
              filteredProducts = MyProduct.allProducts.where((product) {
                return product.name.toLowerCase().contains(searchQuery);
              }).toList();
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search Products',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: filteredProducts.isEmpty
            ? const Center(child: Text("No products found"))
            : GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.75,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (BuildContext context, int index) {
            final product = filteredProducts[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(product: product),
                ),
              ),
              child: ProductCard(product: product),
            );
          },
        ),
      ),
    );
  }
}
