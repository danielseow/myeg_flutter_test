import 'package:go_router/go_router.dart';
import 'package:myeg_flutter_test/models/products.dart';
import 'package:myeg_flutter_test/presentations/full_screen_image.dart';
import 'package:myeg_flutter_test/presentations/product_detail/product_detail.dart';
import 'package:myeg_flutter_test/presentations/product_list/product_list.dart';
import 'package:myeg_flutter_test/presentations/shopping_cart/shopping_cart.dart';

final goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'product-list',
      builder: (context, state) => const ProductList(),
      routes: [
        GoRoute(
          path: 'product-detail',
          name: 'product-detail',
          builder: (context, state) {
            final product = state.extra as Product;
            return ProductDetailScreen(product: product);
          },
        ),
        GoRoute(
          path: 'cart',
          name: 'cart',
          builder: (context, state) => const ShoppingCart(),
        ),
      ],
    ),
    GoRoute(
      path: '/photo-view',
      name: 'photo-view',
      builder: (context, state) {
        final imageUrl = state.extra as String;
        return FullScreenImageScreen(imageUrl: imageUrl);
      },
    ),
  ],
);
