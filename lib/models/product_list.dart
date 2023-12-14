import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final _items = dummyProdcts;

  List<Product> get items => [..._items];

  addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
