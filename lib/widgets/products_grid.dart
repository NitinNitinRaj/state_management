import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/models/product.dart';
import 'package:state_management/providers/products_provider.dart';
import 'package:state_management/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    List<Product> products = productData.products;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: const ProductItem(),
      ),
    );
  }
}
