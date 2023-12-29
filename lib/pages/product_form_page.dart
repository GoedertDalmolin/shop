import 'package:flutter/material.dart';

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

  @override
  void initState() {
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  _priceFocus.requestFocus();
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) {
                  _descriptionFocus.requestFocus();
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocus,
                onFieldSubmitted: (_) {
                  _imageUrlFocus.requestFocus();
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
                      onFieldSubmitted: (_) {},
                      controller: _imageUrlContrller,
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
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(_imageUrlContrller.text),
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
