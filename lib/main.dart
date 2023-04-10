import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/pages/add_new_product.dart';
import 'package:state_management/pages/cart_page.dart';
import 'package:state_management/pages/order_page.dart';
import 'package:state_management/pages/product_details_page.dart';
import 'package:state_management/pages/products_overview_page.dart';
import 'package:state_management/pages/user_products_page.dart';
import 'package:state_management/providers/models/cart.dart';
import 'package:state_management/providers/order_provider.dart';
import 'package:state_management/providers/products_provider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _theme = ThemeData(primarySwatch: Colors.purple, fontFamily: "Lato");

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _theme.copyWith(
          colorScheme: _theme.colorScheme.copyWith(
            secondary: Colors.deepOrange,
          ),
        ),
        routes: {
          ProductDetails.routeName: (context) => const ProductDetails(),
          CartPage.routeName: (context) => const CartPage(),
          OrderPage.routeName: (context) => const OrderPage(),
          UserProductsPage.routeName: (context) => const UserProductsPage(),
          AddNewProduct.routeName: (context) => const AddNewProduct(),
        },
        home: const ProductsOverviewPage(),
      ),
    );
  }
}
