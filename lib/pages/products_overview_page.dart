import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/pages/cart_page.dart';
import 'package:state_management/providers/models/cart.dart';
import 'package:state_management/providers/products_provider.dart';
import 'package:state_management/widgets/drawer_list.dart';
import 'package:state_management/widgets/products_grid.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _selectFavorites = false;
  bool _isInit = false;
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    if (!_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).loadAndSetProduct().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MyShop",
        ),
        actions: [
          Consumer<Cart>(
            builder: (_, cartData, child) => Container(
              margin: const EdgeInsets.only(top: 5),
              child: Badge(
                label: Text(cartData.cartSize.toString()),
                alignment: const AlignmentDirectional(24, 4),
                child: child,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartPage.routeName);
              },
            ),
          ),
          buildFilterPopUpMenu(themeContext),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(selectFavorites: _selectFavorites),
      drawer: const DrawerList(),
    );
  }

  PopupMenuButton<FilterOptions> buildFilterPopUpMenu(ThemeData themeContext) {
    return PopupMenuButton(
      onSelected: (FilterOptions value) {
        setState(() {
          if (value == FilterOptions.all) {
            _selectFavorites = false;
          } else {
            _selectFavorites = true;
          }
        });
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text(
            "Favorites",
            style: TextStyle(
              color: _selectFavorites
                  ? themeContext.colorScheme.secondary
                  : Colors.black,
            ),
          ),
        ),
        PopupMenuItem(
          value: FilterOptions.all,
          child: Text(
            "All",
            style: TextStyle(
              color: !_selectFavorites
                  ? themeContext.colorScheme.secondary
                  : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
