import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;

  const OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final double itemsHeight = (widget.order.products.length * 25) + 10;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _expanded ? itemsHeight + 85 : 80,
      curve: Curves.linear,
      child: Card(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
                subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date)),
                trailing: IconButton(
                  icon: const Icon(Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),
              ),
              if (_expanded)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: _expanded ? itemsHeight : 0 ,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 4,
                  ),
                  child: ListView(
                    children: widget.order.products.map((product) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.productName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' ${product.quantity}x R\$ ${product.price}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
