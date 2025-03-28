import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myeg_flutter_test/models/products.dart';
import 'package:myeg_flutter_test/presentations/product_detail/components/add_to_cart_section.dart';
import 'package:myeg_flutter_test/presentations/product_detail/components/product_detail_section.dart';
import 'package:myeg_flutter_test/widgets/cart_button.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff002552),
        iconTheme: IconThemeData(
          color: Colors.white, // Back button colour
        ),
        actions: [CartButton()],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  // Zoomable Image
                  InkWell(
                    onTap: () {
                      context.pushNamed(
                        'photo-view',
                        extra: widget.product.image,
                      );
                    },
                    child: SizedBox(
                      height: 300,
                      child: Hero(
                        tag: widget.product.image,
                        child: CachedNetworkImage(
                          imageUrl: widget.product.image,
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                        ),
                      ),
                    ),
                  ),

                  ProductDetailSection(widget.product),
                ],
              ),
            ),
          ),
          AddToCartSection(product: widget.product),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}
