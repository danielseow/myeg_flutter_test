import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myeg_flutter_test/models/cart_item.dart';
import 'package:myeg_flutter_test/providers/cart_provider.dart';

class CartItemTile extends ConsumerStatefulWidget {
  final CartItem cartItem;

  const CartItemTile({super.key, required this.cartItem});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartItemTileState();
}

class _CartItemTileState extends ConsumerState<CartItemTile> {
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(
      text: widget.cartItem.quantity.toString(),
    );
  }

  @override
  void didUpdateWidget(covariant CartItemTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cartItem.quantity != widget.cartItem.quantity) {
      _quantityController.text = widget.cartItem.quantity.toString();
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.cartItem.product;
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Slidable(
        key: Key(product.id.toString()),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                ref.read(cartProvider.notifier).removeItem(product);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          leading: CachedNetworkImage(imageUrl: product.image, width: 50),
          title: Text(product.title),
          subtitle: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  ref.read(cartProvider.notifier).decrementItem(product);
                },
              ),
              SizedBox(
                width: 60,
                child: TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(6),
                  ),
                  onChanged: (value) {
                    final newQuantity = int.tryParse(value);
                    if (newQuantity != null) {
                      ref
                          .read(cartProvider.notifier)
                          .updateItemQuantity(product, newQuantity);
                    }
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  ref.read(cartProvider.notifier).addItem(product, 1);
                },
              ),
            ],
          ),
          trailing: Text(
            '\$${(product.price * widget.cartItem.quantity).toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
