import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myeg_flutter_test/models/products.dart';
import 'package:myeg_flutter_test/providers/api_provider.dart';
import 'package:myeg_flutter_test/repositories/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(ref.read(apiServiceProvider));
});

final productProvider = FutureProvider<List<Product>>((ref) async {
  return ref.watch(productRepositoryProvider).getProducts();
});

final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

// retrieve list of categories from products
final categoriesProvider = Provider<List<String>>((ref) {
  final products = ref.watch(productProvider).value ?? [];
  final categories = products.map((p) => p.category).toSet().toList();
  return ['All', ...categories];
});

final filteredProductsProvider = Provider<List<Product>>((ref) {
  final products = ref.watch(productProvider).value ?? [];
  final searchQuery = ref.watch(searchQueryProvider);
  final category = ref.watch(selectedCategoryProvider);

  return products.where((product) {
    final matchesSearch = product.title.toLowerCase().contains(
      searchQuery.toLowerCase(),
    );
    final matchesCategory =
        category == 'All' ||
        product.category.toLowerCase() == category.toLowerCase();
    return matchesSearch && matchesCategory;
  }).toList();
});
