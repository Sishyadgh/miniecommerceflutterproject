import 'package:ecommerce_app/Providers/CartProvider.dart';
import 'package:ecommerce_app/screens/CartScreen.dart';
import 'package:ecommerce_app/screens/FavouriteScreen.dart';
import 'package:ecommerce_app/screens/HomeScreen.dart';
import 'package:ecommerce_app/screens/LoginScreen.dart';
import 'package:ecommerce_app/screens/ProfileScreen.dart';
import 'package:ecommerce_app/screens/SearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/FavouriteProvider.dart';

void main() {
  runApp(
      MultiProvider(
          providers:[
            ChangeNotifierProvider(create: (_)=> FavouriteProvider()),
            ChangeNotifierProvider(create: (_) => CartProvider()),
          ],
      child:const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
      )
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0; //here i put 0 so by default home screen is visible when app runs, if i set it to 1 search screen will display
  List screens=[
    const HomeScreen(),
    const SearchScreen(),
    const FavouriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ecommerce-app",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          // Conditionally show the Login button if HomeScreen is active
          if (currentIndex == 0)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                textStyle: const TextStyle(fontSize: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Login'),
            ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
              if (cartProvider.cart.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      cartProvider.cart.length.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white70,
        onTap: (value) {
          setState(() => currentIndex = value);
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "search", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "favourites", icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(label: "profile", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}


