import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Providers/CartProvider.dart';
import 'CheckoutScreen.dart';
import 'LoginScreen.dart';

class CartScreen extends StatefulWidget{
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    final provider = CartProvider.of(context, listen: false);
    provider.loadCart(); // Load the cart data when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;

    buildProductQuantity(IconData icon,int index){
      return GestureDetector(
        onTap: (){
          setState(() {
            icon==Icons.add
            ? provider.incrementQuantity(index)
            : provider.decrementQuantity(index);

          });
        },
        child: Container(
           decoration: BoxDecoration(
             shape: BoxShape.circle,
             color: Colors.red.shade100,
           ),
             child:Icon(
         icon,
         size: 20,
             )
        ),
      );
    }

 return Scaffold(
   appBar:AppBar(
     title: const Text('My Cart'),
     centerTitle: true,
     backgroundColor: Colors.red,
   ),
   body: Column(
     children: [
    Expanded(
    child: ListView.builder(
    itemCount: finalList.length,
    itemBuilder: (context, index) {
      return  Padding(
        padding: const EdgeInsets.all(8.0),
      child: Slidable(
      endActionPane: ActionPane(
      motion: const ScrollMotion(),
      children: [
      SlidableAction(
      onPressed: (context) {
        provider.cart.removeAt(index);
        provider.saveCart(); // Save the updated cart to SharedPreferences
        setState(() {});
      },
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'delete',
      ),
      ],
      ),
        child: ListTile(
          title: Text(
            finalList[index].name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle:
              Text(
                '\$${finalList[index].price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
          leading: CircleAvatar(
            backgroundImage: AssetImage(finalList[index].image),
            radius: 30,
            backgroundColor: Colors.red.shade100,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildProductQuantity(Icons.remove, index),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  finalList[index].quantity.toString(),
                  style: const TextStyle(
                    fontSize: 14, // Keep the font size readable
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              buildProductQuantity(Icons.add, index),
            ],
          ),
          tileColor: Colors.blueGrey.shade100,
        ),
      ),
      );
    }
       )
    ),
       Container(
          padding:EdgeInsets.symmetric(horizontal: 20) ,
         height: 90,
         width: double.infinity,
         decoration: BoxDecoration(
           color: Colors.red.shade400,
           borderRadius: const BorderRadius.only(
             topRight: Radius.circular(10),
             topLeft: Radius.circular(10),
            // bottomLeft:  Radius.circular(15),
            // bottomRight:  Radius.circular(15),
           )
         ),
         child:  Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text('\$${provider.getTotalPrice()}',
             style: const TextStyle(
               fontSize: 15,fontWeight: FontWeight.bold,
             ),
             ),
             ElevatedButton.icon(

    onPressed: (){
      // Check if the user is logged in
      navigateBasedOnLoginStatus(context);
           },
                 label: const Text('Proceed to checkout'),
                 icon: const Icon(Icons.send),
                 style: ElevatedButton.styleFrom(
                 foregroundColor: Colors.black,
                 backgroundColor: Colors.red,
               ),
             ),

           ],

         ),
       )
     ],
   ),
 );
  }

  Future<void> navigateBasedOnLoginStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Ensure that the widget is still mounted before using the context
    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CheckoutScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

}