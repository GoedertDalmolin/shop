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

 Future addProduct(Product product) async {
    var response = await http.post(Uri.parse('${FirebaseConfig.urlDatabase}/products.json'),
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }));

    final id = jsonDecode(response.body)['name'];

    final productWithId = Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );

    _items.add(productWithId);
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

  Future saveProduct({
    required Map<String, Object> data,
  }) async {
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
      await addProduct(product);
    }
    notifyListeners();
  }
}
