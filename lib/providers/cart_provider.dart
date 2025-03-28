import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myeg_flutter_test/models/cart_item.dart';
import 'package:myeg_flutter_test/models/products.dart';
import 'package:myeg_flutter_test/repositories/cart_storage_repository.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(CartStorage()),
);

class CartNotifier extends StateNotifier<List<CartItem>> {
  final CartStorage cartStorage;

  CartNotifier(this.cartStorage) : super([]) {
    _loadCart();
  }
  // Loads the current cart from shared preferences into the state.
  Future<void> _loadCart() async {
    state = await cartStorage.loadCart();
  }

  // Saves the current cart to shared preferences
  Future<void> _saveCart() async {
    await cartStorage.saveCart(state);
  }

  // Add an item to the cart
  void addItem(Product product, int quantity) {
    final index = state.indexWhere((item) => item.product.id == product.id);

    if (index == -1) {
      // Not in cart, add it with the selected quantity
      state = [...state, CartItem(product: product, quantity: quantity)];
    } else {
      // Already in cart, increment by the new quantity
      final existingItem = state[index];
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + quantity,
      );

      final updatedList = [...state];
      updatedList[index] = updatedItem;
      state = updatedList;
    }

    _saveCart();
  }

  // Remove an item from the cart entirely
  void removeItem(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
    _saveCart();
  }

  // Decrement quantity or remove if quantity <= 1
  void decrementItem(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index == -1) return;

    final existingItem = state[index];
    if (existingItem.quantity > 1) {
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity - 1,
      );
      final updatedList = [...state];
      updatedList[index] = updatedItem;
      state = updatedList;
    } else {
      // If quantity = 1, removing or decrementing goes to 0, so remove item from cart
      removeItem(product);
    }
    _saveCart();
  }
  
  void updateItemQuantity(Product product, int newQuantity) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index == -1) return;
    if (newQuantity <= 0) {
      removeItem(product);
    } else {
      final updatedItem = state[index].copyWith(quantity: newQuantity);
      final updatedList = [...state];
      updatedList[index] = updatedItem;
      state = updatedList;
    }
    _saveCart();
  }

  // Clear the entire cart
  void clearCart() {
    state = [];
    _saveCart();
  }
}
