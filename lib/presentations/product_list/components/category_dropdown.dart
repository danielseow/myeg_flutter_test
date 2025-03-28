import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myeg_flutter_test/providers/product_provider.dart';
import 'package:myeg_flutter_test/utils/string_extensions.dart';

class CategoryDropdown extends ConsumerWidget {
  const CategoryDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return DropdownButton<String>(
      value: selectedCategory,
      dropdownColor: Colors.white,
      icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      underline: const SizedBox(),
      items:
          categories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(
                category.capitalizeFirst(),
                style: TextStyle(
                  color:
                      category == ref.watch(selectedCategoryProvider)
                          ? const Color(0xff002552)
                          : Colors.grey.shade700,
                  fontWeight:
                      category == ref.watch(selectedCategoryProvider)
                          ? FontWeight.w600
                          : FontWeight.normal,
                ),
              ),
            );
          }).toList(),
      onChanged:
          (value) =>
              ref.read(selectedCategoryProvider.notifier).state =
                  value ?? 'All',
      selectedItemBuilder: (BuildContext context) {
        return categories.map((String value) {
          return Container(
            width: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              value == 'All'
                  ? 'Category' // Display "Category" when "All" is selected, so that users know they can select a category when first opening the app
                  : value.capitalizeFirst(),

              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }).toList();
      },
    );
  }
}
