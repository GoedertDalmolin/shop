import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/utils/firebase_config.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;

    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _uid : null;
  }

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
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['localId'];

      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );
      notifyListeners();
    }
  }

  Future signup({required String email, required String password}) async {
    return await _authenticate(email: email, password: password, urlFragment: 'signUp');
  }

  Future login({required String email, required String password}) async {
    return await _authenticate(email: email, password: password, urlFragment: 'signInWithPassword');
  }
}
