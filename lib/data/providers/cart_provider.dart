// cart_provider.dart
import 'package:flutter/material.dart';
import '../models/clothing_item.dart'; // Import your existing model

class CartProvider with ChangeNotifier {
  final List<ClothingItem> _cartItems = [];

  List<ClothingItem> get cartItems => _cartItems;

  void addToCart(ClothingItem product) {
    _cartItems.add(product);
    notifyListeners(); // Notify listeners (UI) when the cart changes
  }

  void removeFromCart(ClothingItem product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void updateItemQuantity(ClothingItem item) {
    notifyListeners(); // Trigger a rebuild when the quantity changes
  }

  int get cartItemCount => _cartItems.length;
}
