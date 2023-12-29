import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductList>(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, i) {
              return Column(
                children: [
                  ProductItem(
                    product: products.items[i],
                  ),
                  Divider(),
                ],
              );
            }),
      ),
    );
  }
}
