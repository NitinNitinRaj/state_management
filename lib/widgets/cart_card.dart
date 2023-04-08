import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/models/cart.dart';

class CartCard extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String productId;
  const CartCard({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItemFromCart(productId);
      },
      background: Container(
        padding: const EdgeInsets.only(right: 8),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text("\$$price "),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text("Total: \$${quantity * price}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
