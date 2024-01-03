import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final _items = dummyProdcts;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems => _items.where((element) => element.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  addProductFromData({
    required Map<String, Object> formData,
  }) {
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: formData['name'] as String,
      description: formData['description'] as String,
      price: formData['price'] as double,
      imageUrl: formData['imageUrl'] as String,
    );

    _items.add(newProduct);
    notifyListeners();
  }
}
