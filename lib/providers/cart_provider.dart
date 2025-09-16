import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  SharedPreferences? _prefs;
  static const String _cartItemsKey = 'cart_items';
  bool _isInitialized = false;

  // Constructor - initialize cart when provider is created
  CartProvider() {
    _initializeCart();
  }

  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  int get cartItemCount => _cartItems.length;

  int get totalQuantity =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool get isInitialized => _isInitialized;

  // Initialize SharedPreferences and load saved cart
  Future<void> init() async {
    try {
      if (!_isInitialized) {
        await _initializeCart();
      }
      print('CartProvider initialized successfully'); // Debug log
    } catch (e) {
      print('CartProvider initialization error: $e'); // Debug log
    }
  }

  // Initialize cart by loading from SharedPreferences
  Future<void> _initializeCart() async {
    try {
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }

      final cartJson = _prefs!.getString(_cartItemsKey);
      if (cartJson != null && cartJson.isNotEmpty) {
        final List<dynamic> cartData = json.decode(cartJson);
        _cartItems.clear();
        _cartItems.addAll(
          cartData.map((item) => CartItem.fromJson(item)).toList(),
        );
        print('Loaded ${cartData.length} items from storage'); // Debug log
      }
      _isInitialized = true;
    } catch (e) {
      print('Error initializing cart from storage: $e'); // Debug log
      // Clear corrupted data
      await _prefs?.remove(_cartItemsKey);
      _isInitialized = true; // Mark as initialized even on error
    }
    notifyListeners(); // Notify listeners that cart is loaded
  }

  // Save cart items to SharedPreferences
  Future<void> _saveCartToStorage() async {
    try {
      if (_prefs == null || !_isInitialized) return;

      final cartData = _cartItems.map((item) => item.toJson()).toList();
      final cartJson = json.encode(cartData);
      await _prefs!.setString(_cartItemsKey, cartJson);
      print('Saved ${_cartItems.length} items to storage'); // Debug log
    } catch (e) {
      print('Error saving cart to storage: $e'); // Debug log
    }
  }

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
    _saveCartToStorage(); // Save to persistent storage
  }

  // Remove item from cart
  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    notifyListeners();
    _saveCartToStorage(); // Save to persistent storage
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
        _saveCartToStorage(); // Save to persistent storage
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
      _saveCartToStorage(); // Save to persistent storage
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
        _saveCartToStorage(); // Save to persistent storage
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
    _saveCartToStorage(); // Save empty cart to persistent storage
  }

  // Clear cart data from storage (called on logout)
  Future<void> clearCartFromStorage() async {
    try {
      _cartItems.clear();
      if (_prefs != null) {
        await _prefs!.remove(_cartItemsKey);
        print('Cart cleared from storage'); // Debug log
      }
      notifyListeners();
    } catch (e) {
      print('Error clearing cart from storage: $e'); // Debug log
    }
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
