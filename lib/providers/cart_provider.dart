import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  int get cartItemCount => _cartItems.length;

  int get totalQuantity =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  // Add item to cart
  void addToCart(CartItem item) {
    final existingIndex = _cartItems.indexWhere(
      (cartItem) => cartItem.id == item.id,
    );

    if (existingIndex >= 0) {
      // Item already exists, increase quantity
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + 1,
      );
    } else {
      // New item, add to cart
      _cartItems.add(item);
    }

    notifyListeners();
  }

  // Remove item from cart
  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  // Update item quantity
  void updateQuantity(String itemId, int quantity) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      if (quantity <= 0) {
        removeFromCart(itemId);
      } else {
        _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
        notifyListeners();
      }
    }
  }

  // Increase quantity by 1
  void increaseQuantity(String itemId) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      _cartItems[index] = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity + 1,
      );
      notifyListeners();
    }
  }

  // Decrease quantity by 1
  void decreaseQuantity(String itemId) {
    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      final newQuantity = _cartItems[index].quantity - 1;
      if (newQuantity <= 0) {
        removeFromCart(itemId);
      } else {
        _cartItems[index] = _cartItems[index].copyWith(quantity: newQuantity);
        notifyListeners();
      }
    }
  }

  // Check if item is in cart
  bool isInCart(String itemId) {
    return _cartItems.any((item) => item.id == itemId);
  }

  // Get quantity of specific item
  int getItemQuantity(String itemId) {
    final item = _cartItems.firstWhere(
      (item) => item.id == itemId,
      orElse: () =>
          CartItem(id: '', name: '', description: '', price: 0, image: ''),
    );
    return item.id.isEmpty ? 0 : item.quantity;
  }

  // Clear entire cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Get cart item by ID
  CartItem? getCartItem(String itemId) {
    try {
      return _cartItems.firstWhere((item) => item.id == itemId);
    } catch (e) {
      return null;
    }
  }
}
