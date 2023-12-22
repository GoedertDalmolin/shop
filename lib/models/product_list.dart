import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final _items = dummyProdcts;
  bool _showFavoritesOnly = false;

  List<Product> get items {
    if (_showFavoritesOnly) {
      return _items.where((element) => element.isFavorite).toList();
    }

    return [..._items];
  }

  showFavoriteOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  showFavoriteAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }

  addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
