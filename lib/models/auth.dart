import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop/utils/firebase_confg.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static String url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${FirebaseConfig.apiKey}';

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

    debugPrint(jsonDecode(response.body).toString());
  }

  Future signup({required String email, required String password}) async {
    _authenticate(email: email, password: password, urlFragment: 'singnUp');
  }
  Future login({required String email, required String password}) async {
    _authenticate(email: email, password: password, urlFragment: 'signInWithPassword');
  }
}
