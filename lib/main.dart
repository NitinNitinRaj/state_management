import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/pages/product_details_page.dart';
import 'package:state_management/pages/products_overview_page.dart';
import 'package:state_management/providers/products_provider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _theme = ThemeData(primarySwatch: Colors.purple, fontFamily: "Lato");

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _theme.copyWith(
          colorScheme: _theme.colorScheme.copyWith(
            secondary: Colors.deepOrange,
          ),
        ),
        routes: {
          ProductDetails.routeName: (context) => const ProductDetails(),
        },
        home: const ProductsOverviewPage(),
      ),
    );
  }
}
