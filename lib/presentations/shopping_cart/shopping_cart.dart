import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myeg_flutter_test/models/cart_item.dart';
import 'package:myeg_flutter_test/presentations/shopping_cart/components/cart_item_tile.dart';
import 'package:myeg_flutter_test/providers/cart_provider.dart';

class ShoppingCart extends ConsumerWidget {
  const ShoppingCart({super.key});

  double _calculateTotal(List<CartItem> cartItems) {
    return cartItems.fold(
      0.0,
      (total, item) => total + item.product.price * item.quantity,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = _calculateTotal(cartItems);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff002552),
        iconTheme: IconThemeData(
          color: Colors.white, //back button colour
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            cartItems.isEmpty
                ? Expanded(
                  child: const Center(child: Text('Your cart is empty')),
                )
                : Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return CartItemTile(cartItem: item);
                    },
                  ),
                ),
            // Total price and checkout section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xfff7f9ff),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, -2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff002552),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Proceeding to checkout...'),
                          ),
                        );
                      },
                      child: const Text(
                        'Checkout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.paddingOf(context).bottom),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
