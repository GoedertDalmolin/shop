import 'package:flutter/material.dart';
import 'package:shop/pages/product_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
      ),
      body: ProductGrid(),
    );
  }
}

