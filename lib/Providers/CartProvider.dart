import 'dart:convert'; // Add this for JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _cart = [];

  List<Product> get cart => _cart;

  // Save the cart to SharedPreferences
  Future<void> saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartItems = _cart.map((product) => json.encode(product.toMap())).toList();
    await prefs.setStringList('cart', cartItems);
  }

  // Load the cart from SharedPreferences
  Future<void> loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cartItems = prefs.getStringList('cart');
    if (cartItems != null) {
      _cart = cartItems.map((item) => Product.fromMap(json.decode(item))).toList();
      notifyListeners();
    }
  }

  void toggleProduct(Product product) {
    if (_cart.contains(product)) {
      _cart.remove(product);
    } else {
      _cart.add(product);
    }
    notifyListeners();
    saveCart(); // Save cart whenever it is updated
  }


  void incrementQuantity(int index) {
    _cart[index].quantity++;
    notifyListeners();
    saveCart(); // Save cart whenever it is updated
  }

  void decrementQuantity(int index) {
    if (_cart[index].quantity > 1) {
      _cart[index].quantity--;
      notifyListeners();
      saveCart(); // Save cart whenever it is updated
    }
  }

  double getTotalPrice() {
    double total = 0.0;
    for (Product product in _cart) {
      total += product.price * product.quantity;
    }
    return total;
  }

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(context, listen: listen);
  }
}
