import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/firebase_confg.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  // https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[API_KEY]

  Future _authenticate({
    required String email,
    required String password,
    required String urlFragment,
  }) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=${FirebaseConfig.apiKey}';

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(key: body['error']['message']);
    }

    debugPrint(body.toString());
  }

  Future signup({required String email, required String password}) async {
    return await _authenticate(email: email, password: password, urlFragment: 'signUp');
  }

  Future login({required String email, required String password}) async {
    return await _authenticate(email: email, password: password, urlFragment: 'signInWithPassword');
  }
}
