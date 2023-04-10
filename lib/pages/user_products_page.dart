import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/products_provider.dart';
import 'package:state_management/widgets/drawer_list.dart';
import 'package:state_management/widgets/user_product_item.dart';

class UserProductsPage extends StatelessWidget {
  static const routeName = "/user-products";
  const UserProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your products"),
      ),
      drawer: const DrawerList(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.products.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                title: productsData.products[i].title,
                imageUrl: productsData.products[i].imageUrl,
              ),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
