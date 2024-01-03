import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlContrller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _formData = <String, Object>{};

  bool _isLoading = false;

  @override
  void initState() {
    _formData['name'] = '';
    _formData['description'] = '';
    _formData['price'] = '';
    _formData['imageUrl'] = '';

    _imageUrlFocus.addListener(updateImage);

    super.initState();
  }

  @override
  void dispose() {
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();

    super.dispose();
  }

  updateImage() {
    if (isValidImageUrl(_imageUrlContrller.text)) {
      setState(() {});
    }
  }

  onSubmitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<ProductList>(context, listen: false).saveProduct(data: _formData);

      Navigator.pop(context);
    } catch (e) {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Ocorreu um erro!'),
              content: Text('Ocorreu um erro para salvar o produto.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                )
              ],
            );
          });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;

    bool endsWithFile = url.toLowerCase().endsWith('.png') || url.toLowerCase().endsWith('.jpg') || url.toLowerCase().endsWith('.jpeg');

    return isValidUrl && endsWithFile;
  }

  @override
  void didChangeDependencies() {
    if (_formData.isEmpty) {
      var arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlContrller.text = _formData['imageUrl'] as String;
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: onSubmitForm,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['name'] as String,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        _priceFocus.requestFocus();
                      },
                      onSaved: (name) => _formData['name'] = name ?? '',
                      validator: (nameValidator) {
                        final name = nameValidator ?? '';

                        if (name.trim().isEmpty) {
                          return 'Nome é obrigatório';
                        }

                        if (name.trim().length < 3) {
                          return 'O nome precisa no mínimo de 3 letras.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price'].toString(),
                      decoration: const InputDecoration(labelText: 'Preço'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      onFieldSubmitted: (_) {
                        _descriptionFocus.requestFocus();
                      },
                      onSaved: (price) => _formData['price'] = double.parse(((price ?? '').isEmpty ? '0' : price!)),
                      validator: (priceValidator) {
                        final priceString = priceValidator ?? '-1';

                        final price = double.tryParse(priceString) ?? -1;

                        if (price <= 0) {
                          return 'Informe um preço válido!';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description'] as String,
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      focusNode: _descriptionFocus,
                      onFieldSubmitted: (_) {
                        _imageUrlFocus.requestFocus();
                      },
                      onSaved: (description) => _formData['description'] = description ?? '',
                      validator: (descriptionValidator) {
                        final description = descriptionValidator ?? '';

                        if (description.trim().isEmpty) {
                          return 'Descrição é obrigatório';
                        }

                        if (description.trim().length < 10) {
                          return 'A descrição precisa no mínimo de 10 letras.';
                        }

                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(labelText: 'Url da imagem'),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.url,
                            maxLines: 1,
                            focusNode: _imageUrlFocus,
                            onFieldSubmitted: (_) {
                              onSubmitForm();
                            },
                            controller: _imageUrlContrller,
                            onSaved: (imageUrl) => _formData['imageUrl'] = imageUrl ?? '',
                            validator: (imageUrlValidator) {
                              final imageUrl = imageUrlValidator ?? '';

                              if (!isValidImageUrl(imageUrl)) {
                                return 'Informe uma Url Válida!!';
                              }

                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
                          alignment: Alignment.center,
                          child: _imageUrlContrller.text.isEmpty
                              ? Text(
                                  _imageUrlContrller.text.isEmpty ? 'Informe uma URL' : 'Preview da URL',
                                  textAlign: TextAlign.center,
                                )
                              : !isValidImageUrl(_imageUrlContrller.text)
                                  ? const Text(
                                      'Informe uma URL valida!',
                                      textAlign: TextAlign.center,
                                    )
                                  : SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Image.network(_imageUrlContrller.text),
                                      ),
                                    ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
