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
                CartButton(cart: cart),
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

class CartButton extends StatefulWidget {
  const CartButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading ? CircularProgressIndicator() : TextButton(
      onPressed: widget.cart.itemsCount == 0
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<OrderList>(context, listen: false).addOrder(widget.cart);

              widget.cart.clear();

              setState(() {
                _isLoading = false;
              });
            },
      style: TextButton.styleFrom(textStyle: TextStyle(color: Theme.of(context).primaryColor)),
      child: const Text('COMPRAR'),
    );
  }
}
