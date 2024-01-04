import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Chip(
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(
                    'R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                    style: Theme.of(context).primaryTextTheme.bodyLarge!.copyWith(color: Colors.white),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    await Provider.of<OrderList>(context, listen: false).addOrder(cart);

                    cart.clear();
                  },
                  style: TextButton.styleFrom(textStyle: TextStyle(color: Theme.of(context).primaryColor)),
                  child: const Text('COMPRAR'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (ctx, index) {
                  return CartItemWidget(
                    cartItem: items[index],
                  );
                }),
          )
        ],
      ),
    );
  }
}
