import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cart_item.dart'; // Reusing CartItem for favorites

class FavoritesProvider with ChangeNotifier {
  final List<CartItem> _favoriteItems = [];
  SharedPreferences? _prefs;
  static const String _favoritesKey = 'favorite_items';
  bool _isInitialized = false;

  // Constructor - initialize favorites when provider is created
  FavoritesProvider() {
    _initializeFavorites();
  }

  List<CartItem> get favoriteItems => List.unmodifiable(_favoriteItems);

  int get favoriteCount => _favoriteItems.length;

  bool get isInitialized => _isInitialized;

  // Initialize favorites by loading from SharedPreferences
  Future<void> _initializeFavorites() async {
    try {
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }

      final favoritesJson = _prefs!.getString(_favoritesKey);
      if (favoritesJson != null && favoritesJson.isNotEmpty) {
        final List<dynamic> favoritesData = json.decode(favoritesJson);
        _favoriteItems.clear();
        _favoriteItems.addAll(
          favoritesData.map((item) => CartItem.fromJson(item)).toList(),
        );
        print(
          'Loaded ${favoritesData.length} favorite items from storage',
        ); // Debug log
      }
      _isInitialized = true;
    } catch (e) {
      print('Error initializing favorites from storage: $e'); // Debug log
      // Clear corrupted data
      await _prefs?.remove(_favoritesKey);
      _isInitialized = true; // Mark as initialized even on error
    }
    notifyListeners(); // Notify listeners that favorites are loaded
  }

  // Save favorites to SharedPreferences
  Future<void> _saveFavoritesToStorage() async {
    try {
      if (_prefs == null || !_isInitialized) return;

      final favoritesData = _favoriteItems
          .map((item) => item.toJson())
          .toList();
      final favoritesJson = json.encode(favoritesData);
      await _prefs!.setString(_favoritesKey, favoritesJson);
      print(
        'Saved ${_favoriteItems.length} favorite items to storage',
      ); // Debug log
    } catch (e) {
      print('Error saving favorites to storage: $e'); // Debug log
    }
  }

  // Add item to favorites
  void addToFavorites(CartItem item) {
    final existingIndex = _favoriteItems.indexWhere(
      (favoriteItem) => favoriteItem.id == item.id,
    );

    if (existingIndex < 0) {
      // Item not in favorites, add it
      _favoriteItems.add(item);
      notifyListeners();
      _saveFavoritesToStorage(); // Save to persistent storage
    }
  }

  // Remove item from favorites
  void removeFromFavorites(String itemId) {
    _favoriteItems.removeWhere((item) => item.id == itemId);
    notifyListeners();
    _saveFavoritesToStorage(); // Save to persistent storage
  }

  // Toggle favorite status
  void toggleFavorite(CartItem item) {
    final existingIndex = _favoriteItems.indexWhere(
      (favoriteItem) => favoriteItem.id == item.id,
    );

    if (existingIndex >= 0) {
      // Item is in favorites, remove it
      removeFromFavorites(item.id);
    } else {
      // Item not in favorites, add it
      addToFavorites(item);
    }
  }

  // Check if item is in favorites
  bool isFavorite(String itemId) {
    return _favoriteItems.any((item) => item.id == itemId);
  }

  // Clear all favorites
  void clearFavorites() {
    _favoriteItems.clear();
    notifyListeners();
    _saveFavoritesToStorage(); // Save empty favorites to persistent storage
  }

  // Clear favorites data from storage (called on logout)
  Future<void> clearFavoritesFromStorage() async {
    try {
      _favoriteItems.clear();
      if (_prefs != null) {
        await _prefs!.remove(_favoritesKey);
        print('Favorites cleared from storage'); // Debug log
      }
      notifyListeners();
    } catch (e) {
      print('Error clearing favorites from storage: $e'); // Debug log
    }
  }

  // Get favorite item by ID
  CartItem? getFavoriteItem(String itemId) {
    try {
      return _favoriteItems.firstWhere((item) => item.id == itemId);
    } catch (e) {
      return null;
    }
  }

  // Initialize the service with SharedPreferences instance and load saved favorites
  Future<void> init() async {
    try {
      if (!_isInitialized) {
        await _initializeFavorites();
      }
      print('FavoritesProvider initialized successfully'); // Debug log
    } catch (e) {
      print('FavoritesProvider initialization error: $e'); // Debug log
    }
  }
}
