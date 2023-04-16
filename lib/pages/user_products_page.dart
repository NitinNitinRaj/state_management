import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/pages/add_new_product.dart';
import 'package:state_management/providers/products_provider.dart';
import 'package:state_management/widgets/drawer_list.dart';
import 'package:state_management/widgets/user_product_item.dart';

class UserProductsPage extends StatelessWidget {
  static const routeName = "/user-products";
  const UserProductsPage({super.key});

  Future<void> _loadUserProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .loadAndSetProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddNewProduct.routeName);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      drawer: const DrawerList(),
      body: RefreshIndicator(
        onRefresh: () => _loadUserProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.products.length,
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                  id: productsData.products[i].id,
                  title: productsData.products[i].title,
                  imageUrl: productsData.products[i].imageUrl,
                ),
                const Divider()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
