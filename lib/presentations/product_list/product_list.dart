import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myeg_flutter_test/presentations/product_list/components/category_dropdown.dart';
import 'package:myeg_flutter_test/presentations/product_list/components/product_list_item.dart';
import 'package:myeg_flutter_test/providers/product_provider.dart';

class ProductList extends ConsumerStatefulWidget {
  const ProductList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productProvider);
    final filteredProducts = ref.watch(filteredProductsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Badge(
              label: Text('10'),
              isLabelVisible: false,
              offset: const Offset(-5, 5),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                color: Colors.white,
                onPressed: () => (),
              ),
            ),
          ),
        ],
        backgroundColor: Color(0xff002552),
        // Search bar
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: SearchBar(
                    controller: searchController,
                    leading: const Icon(Icons.search),
                    hintText: 'Search',
                    onChanged: (value) {
                      ref.read(searchQueryProvider.notifier).state = value;
                    },

                    // Clear search bar text button
                    trailing: [
                      Consumer(
                        builder: (context, ref, _) {
                          final searchQuery = ref.watch(searchQueryProvider);
                          return searchQuery.isNotEmpty
                              ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  ref.read(searchQueryProvider.notifier).state =
                                      '';
                                  searchController.clear();
                                },
                              )
                              : const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Category dropdown
                CategoryDropdown(),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        // the refresh indicator will keep showing until the new activity is
        // fetched.
        onRefresh: () async => ref.refresh(productProvider.future),
        child: productsAsync.when(
          data:
              (products) => ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder:
                    (context, index) =>
                        ProductListItem(product: filteredProducts[index]),
              ),
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => Center(child: const CircularProgressIndicator()),
        ),
      ),
    );
  }
}
