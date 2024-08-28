import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';  // Import to handle JSON conversion

import '../model/Product.dart';

class FavouriteProvider extends ChangeNotifier {
  List<Product> favourite = [];
  List<Product> get favourites => favourite;

  static const String FAVOURITE_KEY = 'favourite_products';

  FavouriteProvider() {
    loadFavorites();  // Load favorites when the provider is initialized
  }

  void toggleFavourite(Product product) async {
    if (favourite.contains(product)) {
      favourite.remove(product);
    } else {
      favourite.add(product);
    }
    saveFavorites();  // Save favorites after every change
    notifyListeners();
  }

  bool isExist(Product product) {
    return favourite.contains(product);
  }

  void saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> productList = favourite.map((product) => jsonEncode(product.toJson())).toList();
    await prefs.setStringList(FAVOURITE_KEY, productList);
  }

  void loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? productList = prefs.getStringList(FAVOURITE_KEY);
    if (productList != null) {
      favourite = productList.map((product) => Product.fromJson(jsonDecode(product))).toList();
    }
    notifyListeners();
  }

  void removeFromFavorites(Product product) {
    favourite.remove(product);
    saveFavorites();
    notifyListeners();  // Notify listeners so UI can update
  }
  static FavouriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavouriteProvider>(context, listen: listen);
  }
}
