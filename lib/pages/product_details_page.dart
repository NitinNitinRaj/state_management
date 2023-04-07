import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/products_provider.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = "/product-details";

  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
