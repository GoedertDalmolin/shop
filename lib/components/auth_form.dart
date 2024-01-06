import 'package:flutter/material.dart';

enum AuthMode {
  singUp,
  login,
}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  var _authMode = AuthMode.login;

  bool _isLoading = false;

  final _authData = <String, String>{
    'email': '',
    'password': '',
  };

  final _form = GlobalKey<FormState>();

  bool _isLogin() => _authMode == AuthMode.login;

  bool _isSigup() => _authMode == AuthMode.singUp;

  _submit() {
    bool isValidForm = _form.currentState?.validate() ?? false;

    if (!isValidForm) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _form.currentState?.save();

    if(_isLogin()) {

    } else {

    }

    setState(() {
      _isLoading = false;
    });
  }

  _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.singUp;
      } else if (_isSigup()) {
        _authMode = AuthMode.login;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: deviceSize.height * 0.50,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = (email ?? ''),
                validator: (email) {
                  final inputEmail = email ?? '';

                  if (inputEmail.length < 5) {
                    return 'O email informado deve ser maior que 4 caracteres!';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                onSaved: (password) => _authData['password'] = (password ?? ''),
                controller: _passwordController,
                validator: (password) {
                  final inputPassword = password ?? '';

                  if (inputPassword.length < 5) {
                    return 'A senha informada deve ser maior que 4 caracteres!';
                  }

                  return null;
                },
              ),
              if (_isSigup())
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  validator: (confirmPassword) {
                    final inputConfigPassword = confirmPassword ?? '';

                    if (inputConfigPassword != _passwordController.text) {
                      return 'A senha informada não é equivalente  a anterior!';
                    }

                    return null;
                  },
                ),
              const SizedBox(
                height: 20,
              ),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    _isLogin() ? "Login" : "Submit",
                  ),
                ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  _switchAuthMode();
                },
                child: Text(
                  _isLogin() ? 'Registrar-se' : 'Voltar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
