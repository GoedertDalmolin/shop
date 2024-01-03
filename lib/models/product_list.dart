import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/firebase_confg.dart';

class ProductList with ChangeNotifier {
  final _items = dummyProdcts;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems => _items.where((element) => element.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  addProduct(Product product) async {
    await http.post(
      Uri.parse('${FirebaseConfig.urlDatabase}/products.json'),
      body: jsonEncode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavorite': product.isFavorite,
      })
    );

    _items.add(product);
    notifyListeners();
  }

  updateProduct(Product product) {
    int index = _items.indexWhere((e) => e.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  removeProduct(Product product) {
    int index = _items.indexWhere((e) => e.id == product.id);

    if (index >= 0) {
      _items.removeAt(index);

      notifyListeners();
    }
  }

  saveProduct({
    required Map<String, Object> data,
  }) {
    bool hasId = data['id'] != null ? (data['id'] as String).isNotEmpty : false;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

      if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
    notifyListeners();
  }
}
