import 'dart:convert';
import 'package:myeg_flutter_test/models/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartStorage {
  static const String cartKey = 'cart';

  final Future<SharedPreferencesWithCache> _prefsWithCache =
      SharedPreferencesWithCache.create(
        cacheOptions: const SharedPreferencesWithCacheOptions(
          allowList: <String>{cartKey},
        ),
      );

  // Save cart items (List<CartItem>) as JSON string
  Future<void> saveCart(List<CartItem> cartItems) async {
    final prefs = await _prefsWithCache;
    final jsonString = json.encode(
      cartItems.map((item) => item.toJson()).toList(),
    );
    await prefs.setString(cartKey, jsonString);
  }

  // Load cart items from JSON string
  Future<List<CartItem>> loadCart() async {
    final prefs = await _prefsWithCache;

    final jsonString = prefs.getString(cartKey);
    if (jsonString == null) return [];
    try {
      final List<dynamic> decoded = json.decode(jsonString);
      return decoded.map((e) => CartItem.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  // Clear cart data
  Future<void> clearCart() async {
    final prefs = await _prefsWithCache;
    await prefs.remove(cartKey);
  }
}
