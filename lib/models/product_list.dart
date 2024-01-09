import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/firebase_confg.dart';

class ProductList with ChangeNotifier {
  String _token;
  var _items = <Product>[];

  ProductList(this._token, this._items);

  List<Product> get items => [..._items];

  List<Product> get favoriteItems => _items.where((element) => element.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  Future addProduct(Product product) async {
    var response = await http.post(Uri.parse('${FirebaseConfig.urlDatabase}${FirebaseConfig.productRoute}.json?auth=$_token'),
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

  updateProduct(Product product) async {
    int index = _items.indexWhere((e) => e.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${FirebaseConfig.urlDatabase}${FirebaseConfig.productRoute}/${product.id}.json?auth=$_token'),
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        },),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future removeProduct(Product product) async {
    int index = _items.indexWhere((e) => e.id == product.id);

    if (index >= 0) {
      _items.removeAt(index);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${FirebaseConfig.urlDatabase}${FirebaseConfig.productRoute}/${product.id}.json?auth=$_token'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();

        throw HttpException(msg: 'Não foi possível excluir o produto.', statusCode: response.statusCode);
      }
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
      await updateProduct(product);
    } else {
      await addProduct(product);
    }
    notifyListeners();
  }

  Future loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${FirebaseConfig.urlDatabase}${FirebaseConfig.productRoute}.json?auth=$_token'),
    );

    var body = response.body;

    if (body.isNotEmpty && body != 'null') {
      Map<String, dynamic> data = jsonDecode(body);

      try {
        data.forEach((productId, productData) {
          _items.add(
            Product(
                id: productId,
                name: productData['name'],
                description: productData['description'],
                price: productData['price'],
                imageUrl: productData['imageUrl'],
                isFavorite: productData['isFavorite']),
          );
        });
      } catch (e) {
        debugPrint(e.toString());
      }
      notifyListeners();
    }
  }
}
