import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/pages/product_details_page.dart';
import 'package:state_management/providers/models/cart.dart';
import 'package:state_management/providers/models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    ); //set to false beacus don't need to rebuild the whole widget.
    final cartData = Provider.of<Cart>(context, listen: false);
    final themeContext = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: themeContext.colorScheme.secondary,
              ),
            ),
          ), //consumer is used here to rebuild only the dynamic part of the widget
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cartData.addItemToCart(product.id, product.title, product.price);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Added ${product.title} to cart"),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        cartData.removeSingleCartItemByProductId(product.id);
                      }),
                ),
              );
            },
            icon: Icon(
              Icons.shopping_cart,
              color: themeContext.colorScheme.secondary,
            ),
          ),
        ),
        child: productGestureDetector(context, product),
      ),
    );
  }

  GestureDetector productGestureDetector(
      BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetails.routeName,
          arguments: product.id,
        );
      },
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
