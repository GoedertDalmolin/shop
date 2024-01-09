import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/firebase_config.dart';
import 'package:shop/utils/firebase_routes.dart';

class ProductList with ChangeNotifier {
  final String token;
  final String userId;
  final List<Product> productItems;

  ProductList({this.token = '', this.userId = '', this.productItems = const []});

  List<Product> get items => [...productItems];

  List<Product> get favoriteItems => productItems.where((element) => element.isFavorite).toList();

  int get itemsCount {
    return productItems.length;
  }

  Future addProduct(Product product) async {
    var response = await http.post(
      Uri.parse('${FirebaseConfig.urlDatabase}${FirebaseRoutes.productRoute}.json?auth=$token'),
      body: jsonEncode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
      }),
    );

    final id = jsonDecode(response.body)['name'];

    final productWithId = Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );

    items.add(productWithId);
    notifyListeners();
  }

  updateProduct(Product product) async {
    int index = items.indexWhere((e) => e.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${FirebaseConfig.urlDatabase}${FirebaseRoutes.productRoute}/${product.id}.json?auth=$token'),
        body: jsonEncode(
          {
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          },
        ),
      );

      productItems[index] = product;
      notifyListeners();
    }
  }

  Future removeProduct(Product product) async {
    int index = productItems.indexWhere((e) => e.id == product.id);

    if (index >= 0) {
      productItems.removeAt(index);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${FirebaseConfig.urlDatabase}${FirebaseRoutes.productRoute}/${product.id}.json?auth=$token'),
      );

      if (response.statusCode >= 400) {
        productItems.insert(index, product);
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
    productItems.clear();

    final response = await http.get(
      Uri.parse('${FirebaseConfig.urlDatabase}${FirebaseRoutes.productRoute}.json?auth=$token'),
    );

    if (response.body == 'null') {
      return;
    }

    var favResponse = await http.get(
      Uri.parse('${FirebaseConfig.urlDatabase}${FirebaseRoutes.userFavoritesRoute}/$userId.json?auth=$token'),
    );

    Map<String, dynamic> favData = favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    var body = response.body;

    if (body.isNotEmpty && body != 'null') {
      Map<String, dynamic> data = jsonDecode(body);

      try {
        data.forEach((productId, productData) {
          var isFavorite = favData[productId] ?? false;

          productItems.add(
            Product(
              id: productId,
              name: productData['name'],
              description: productData['description'],
              price: productData['price'],
              imageUrl: productData['imageUrl'],
              isFavorite: isFavorite,
            ),
          );
        });
      } catch (e) {
        debugPrint(e.toString());
      }
      notifyListeners();
    }
  }
}
