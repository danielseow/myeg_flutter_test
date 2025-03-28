import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myeg_flutter_test/models/products.dart';
import 'package:myeg_flutter_test/providers/cart_provider.dart';

class AddToCartSection extends ConsumerStatefulWidget {
  final Product product;

  const AddToCartSection({super.key, required this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddToCartSectionState();
}

class _AddToCartSectionState extends ConsumerState<AddToCartSection> {
  final TextEditingController _quantityController = TextEditingController(
    text: '1',
  );

  /// Returns a valid integer quantity (defaults to 1 if invalid)
  int get currentQuantity {
    final value = int.tryParse(_quantityController.text);
    return (value != null && value > 0) ? value : 1;
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Quantity
          Row(
            children: [
              const Text("Quantity: ", style: TextStyle(fontSize: 16)),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  final qty = currentQuantity;
                  if (qty > 1) {
                    _quantityController.text = (qty - 1).toString();
                  }
                },
              ),
              SizedBox(
                width: 40,
                child: TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.all(6),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  final qty = currentQuantity + 1;
                  _quantityController.text = qty.toString();
                },
              ),
            ],
          ),

          // Add to Cart button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                backgroundColor: const Color(0xff002552),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 24,
              ),
              label: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () {
                ref
                    .read(cartProvider.notifier)
                    .addItem(widget.product, currentQuantity);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Added to cart')));
              },
            ),
          ),
        ],
      ),
    );
  }
}
