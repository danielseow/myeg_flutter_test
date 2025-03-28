import 'package:flutter/material.dart';
import 'package:myeg_flutter_test/models/products.dart';
import 'package:myeg_flutter_test/presentations/product_detail/components/rating_star.dart';

class ProductDetailSection extends StatelessWidget {
  final Product product;
  const ProductDetailSection( this.product,{super.key,});

  @override
  Widget build(BuildContext context) {
    // Product Details
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Name
          Text(
            product.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Price and Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              RatingStar(product.rating.rate, product.rating.count),
            ],
          ),
          const SizedBox(height: 16),

          // Category Chip
          Chip(
            label: Text(
              product.category.toUpperCase(),
              style: const TextStyle(
                color: Color(0xff002552),
                fontWeight: FontWeight.bold,
              ),
            ),
            side: const BorderSide(color: Color(0xff002552)),
            backgroundColor: const Color(0xffe7efff),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 2,
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            product.description,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
