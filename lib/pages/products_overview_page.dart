import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/badgee.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/product_grid.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    final pvProductList = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
        actions: [
          Consumer<Cart>(
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.cart);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              builder: (ctx, cart, chld) {
                return Badgee(
                  value: cart.itemsCount.toString(),
                  child: chld!,
                );
              }),
          PopupMenuButton(
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  showFavoriteOnly = true;
                } else {
                  showFavoriteOnly = false;
                }
              });
            },
          ),
        ],
      ),
      body: ProductGrid(
        showFavoriteOnly: showFavoriteOnly,
      ),
    );
  }
}
