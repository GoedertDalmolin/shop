import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/utils/firebase_config.dart';
import 'package:shop/utils/firebase_routes.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  toggleFavorite({required String token, required String userId}) async {
    isFavorite = !isFavorite;
    notifyListeners();

    var response = await http.put(
      Uri.parse('${FirebaseConfig.urlDatabase}${FirebaseRoutes.userFavoritesRoute}/$userId/$id.json?auth=$token'),
      body: jsonEncode(isFavorite),
    );

    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();

      throw HttpException(msg: 'Não foi possível favoritar o produto.', statusCode: response.statusCode);
    }
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, isFavorite: $isFavorite}';
  }
}
