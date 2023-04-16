import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:state_management/providers/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  Future<void> loadAndSetProduct() {
    final url = Uri.https(
        "flutterhttprequest-cc84f-default-rtdb.asia-southeast1.firebasedatabase.app",
        "/products.json");

    return http.get(url).then((response) {
      Map<String, dynamic> loadedProducts = json.decode(response.body);
      List<Product> listOfLoadedProducts = [];
      loadedProducts.forEach((productId, product) {
        listOfLoadedProducts.add(Product(
          id: productId,
          title: product["title"],
          description: product["description"],
          price: product["price"],
          imageUrl: product["imageUrl"],
          isFavorite: product["isFavorite"],
        ));
      });
      _products = listOfLoadedProducts;
      notifyListeners();
    });
  }

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favoriteProducts {
    return _products.where((product) => product.isFavorite == true).toList();
  }

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<void> addProduct(Product product) {
    final url = Uri.https(
        "flutterhttprequest-cc84f-default-rtdb.asia-southeast1.firebasedatabase.app",
        "/products.json");

    return http
        .post(url,
            body: json.encode({
              "id": product.id,
              "title": product.title,
              "description": product.description,
              "price": product.price,
              "imageUrl": product.imageUrl,
              "isFavorite": product.isFavorite
            }))
        .then((response) {
      final finalProduct = Product(
          id: DateTime.now().toString(),
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _products.add(finalProduct);
      notifyListeners();
    }).catchError((err) {
      throw err;
    });
  }

  void editProduct(Product product) {
    var index = _products.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _products[index] = Product(
        id: product.id,
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite,
      );
    }
    notifyListeners();
  }

  void deleteById(String id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
