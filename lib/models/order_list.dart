import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order.dart';

import 'package:http/http.dart' as http;
import 'package:shop/utils/firebase_confg.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  addOrder(Cart cart) async {
    final date = DateTime.now();

    var response = await http.post(
      Uri.parse('${FirebaseConfig.urlDatabase}${FirebaseConfig.orderRoute}.json'),
      body: jsonEncode({
        'total': cart.totalAmount,
        'date': date.toIso8601String(),
        'products': cart.items.values.map((e) => {
              'id': e.id,
              'productId': e.productId,
              'productName': e.productName,
              'quantity': e.quantity,
              'price': e.price,
            }).toList(),
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );

    notifyListeners();
  }
}
