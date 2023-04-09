import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/order_provider.dart';
import 'package:state_management/widgets/drawer_list.dart';
import 'package:state_management/widgets/order_card.dart';

class OrderPage extends StatelessWidget {
  static const routeName = "/order-page";
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      drawer: const DrawerList(),
      body: ListView.builder(
        itemCount: orderData.orderItems.length,
        itemBuilder: (context, index) => OrderCard(
          orderItem: orderData.orderItems[index],
        ),
      ),
    );
  }
}
