import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/models/cart.dart';
import 'package:state_management/widgets/cart_card.dart';

class CartPage extends StatelessWidget {
  static const routeName = "/cart";
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    final themeContext = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 24),
                ),
                const Spacer(),
                Chip(
                    label: Text(
                      cartData.getTotalPrice.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: themeContext.primaryColor),
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Order Now",
                      style: TextStyle(fontSize: 22),
                    ))
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cartData.cartSize,
            itemBuilder: (_, index) => CartCard(
              id: cartData.cartItems.values.toList()[index].id,
              title: cartData.cartItems.values.toList()[index].title,
              price: cartData.cartItems.values.toList()[index].price,
              quantity: cartData.cartItems.values.toList()[index].quantity,
              productId: cartData.cartItems.keys.toList()[index],
            ),
          ),
        )
      ]),
    );
  }
}
