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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "\$${loadedProduct.price}",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }
}
