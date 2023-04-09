import 'package:flutter/material.dart';
import 'package:state_management/providers/models/cart.dart';
import 'package:state_management/providers/models/order_item.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderItem> _orderItems = [];
  List<OrderItem> get orderItems {
    return [..._orderItems];
  }

  void addOrderItem(double totalAmount, List<CartItem> products) {
    _orderItems.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: totalAmount,
        products: products,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
