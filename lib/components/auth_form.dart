import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth.dart';

enum AuthMode {
  singUp,
  login,
}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with SingleTickerProviderStateMixin {
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

  AnimationController? _controller;
  Animation<Size>? _heightAnimation;

  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _heightAnimation = Tween(
      begin: const Size(double.infinity, 350),
      end: const Size(double.infinity, 400),
    ).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.linear),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.linear),
    );

    _slideAnimation = Tween(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.linear),
    );

    super.initState();
  }

  @override
  dispose() {
    _controller?.dispose();

    super.dispose();
  }

  _submit() async {
    bool isValidForm = _form.currentState?.validate() ?? false;

    if (!isValidForm) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _form.currentState?.save();

    try {
      var auth = Provider.of<Auth>(context, listen: false);

      if (_isLogin()) {
        await auth.login(
          email: _authData['email']!,
          password: _authData['password']!,
        );
      } else {
        await auth.signup(
          email: _authData['email']!,
          password: _authData['password']!,
        );
      }
    } on AuthException catch (e) {
      _showErrorDialog(e.toString());
    } catch (e) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() {
      _isLoading = false;
    });
  }

  _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Ocorreu um Erro'),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Fechar'),
              )
            ],
          );
        });
  }

  _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.singUp;
        _controller?.forward();
      } else if (_isSigup()) {
        _authMode = AuthMode.login;
        _controller?.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return Card(
      surfaceTintColor: Colors.transparent,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AnimatedBuilder(
        animation: _heightAnimation!,
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
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
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
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
                    ),
                  ],
                ),
                if (_isSigup())
                  AnimatedContainer(
                    constraints: BoxConstraints(
                      minHeight: _isLogin() ? 0 : 60,
                      maxHeight: _isLogin() ? 0 : 4120,
                    ),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                    child: FadeTransition(
                      opacity: _opacityAnimation!,
                      child: Row(
                        children: [
                          Expanded(
                            child: SlideTransition(
                              position: _slideAnimation!,
                              child: TextFormField(
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
                            ),
                          ),
                        ],
                      ),
                    ),
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
                const SizedBox(
                  height: 12,
                ),
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
        builder: (ctx, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            //height: deviceSize.height * 0.50,
            height: _heightAnimation?.value.height ?? (_isLogin() ? 310 : 500),
            width: deviceSize.width * 0.75,
            child: child,
          );
        },
      ),
    );
  }
}
