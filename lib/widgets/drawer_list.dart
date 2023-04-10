import 'package:flutter/material.dart';
import 'package:state_management/pages/order_page.dart';
import 'package:state_management/pages/user_products_page.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 270,
      backgroundColor: Colors.grey.shade300,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            AppBar(
              title: const Text("Keep Shopping"),
              automaticallyImplyLeading: false,
            ),
            const SizedBox(
              height: 10,
            ),
            drawerTile(
              "Shop",
              () {
                Navigator.of(context).pushReplacementNamed("/");
              },
              Icons.shopify,
            ),
            const Divider(),
            drawerTile(
              "Orders",
              () {
                Navigator.of(context).pushReplacementNamed(OrderPage.routeName);
              },
              Icons.shopping_bag_rounded,
            ),
            const Divider(),
            drawerTile(
              "Manage Products",
              () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductsPage.routeName);
              },
              Icons.settings,
            )
          ],
        ),
      ),
    );
  }

  ListTile drawerTile(String title, VoidCallback function, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Colors.purple,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: "Anton",
          color: Colors.purple,
        ),
      ),
      onTap: function,
    );
  }
}
