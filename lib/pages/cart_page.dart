import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(
                    'R\$ ${cart.totalAmount}',
                    style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(color: Colors.black),
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text('Comprar'),
                  style: TextButton.styleFrom(textStyle: TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
