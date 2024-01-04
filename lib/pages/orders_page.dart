import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/order.dart';
import 'package:shop/models/order_list.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // bool _isLoading = true;
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   Provider.of<OrderList>(context, listen: false).loadOrders().then((value) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final OrderList orders = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Meus Pedidos'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<OrderList>(context, listen: false).loadOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.error != null) {
              return const Center(
                child: Text('Erro'),
              );
            } else {
              return Consumer<OrderList>(
                builder: (context, orders, _) {
                  return ListView.builder(
                      itemCount: orders.itemsCount,
                      itemBuilder: (ctx, index) {
                        return OrderWidget(order: orders.items[index]);
                      });
                },
              );
            }
          },
        )

        // _isLoading
        //     ? const Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : ListView.builder(
        //         itemCount: orders.itemsCount,
        //         itemBuilder: (ctx, index) {
        //           return OrderWidget(order: orders.items[index]);
        //         }),
        );
  }
}
