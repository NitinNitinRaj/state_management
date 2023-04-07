import 'package:flutter/material.dart';
import 'package:state_management/widgets/products_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MyShop",
        ),
      ),
      body: const ProductsGrid(),
    );
  }
}
