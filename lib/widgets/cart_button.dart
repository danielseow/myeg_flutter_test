import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myeg_flutter_test/providers/cart_provider.dart';

class CartButton extends ConsumerWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    return IconButton(
      padding: EdgeInsets.only(right: 18),
      onPressed: () => (context.pushNamed('cart')),
      icon: Badge.count(
        count:  cartItems.length,
        isLabelVisible: cartItems.isNotEmpty ? true : false,
        offset: const Offset(3, -6),
        child: Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}
