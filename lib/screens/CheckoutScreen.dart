import 'package:flutter/material.dart';
import '../Providers/CartProvider.dart';
import 'OrderConfirmationScreen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;
    final subtotal = provider.getTotalPrice();
    final taxRate = 0.1; // Assuming a 10% tax rate
    final taxes = subtotal * taxRate;
    final total = subtotal + taxes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: finalList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(finalList[index].image),
                    ),
                    title: Text(finalList[index].name),
                    subtitle: Text(
                        '\$${finalList[index].price} x ${finalList[index].quantity}'),
                    trailing: Text(
                        '\$${(finalList[index].price * finalList[index].quantity).toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            const Divider(),
            Text('Subtotal: \$${subtotal.toStringAsFixed(2)}'),
            Text('Taxes: \$${taxes.toStringAsFixed(2)}'),
            Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Credit Card'),
              leading: Radio(
                value: 'Credit Card',
                groupValue: 'payment', // Set this to the selected payment method
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: const Text('PayPal'),
              leading: Radio(
                value: 'Paytm',
                groupValue: 'payment', // Set this to the selected payment method
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the Order Confirmation Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderConfirmationScreen()),
                  );
                },
                child: const Text('Confirm Order'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
