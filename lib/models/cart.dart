import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;

    items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });

    return total;
  }

  addItem(Product product) {
    if (items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          id: existingItem.id,
          productId: existingItem.productId,
          productName: existingItem.productName,
          quantity: existingItem.quantity + 1,
          price: existingItem.price,
        ),
      );
    } else {
      items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          productName: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }

    notifyListeners();
  }

  removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  clear() {
    _items = {};
    notifyListeners();
  }
}
