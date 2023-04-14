import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/models/product.dart';
import 'package:state_management/providers/products_provider.dart';

class AddNewProduct extends StatefulWidget {
  static const routeName = "/add-new-product";
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  bool _isUrlValid = false;
  bool _isInitialized = false;
  bool _isLoading = false;
  final _priceFocusNode = FocusNode();
  final _desciptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusedNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  Product _editingProduct =
      Product(id: '', title: '', description: '', price: 0.0, imageUrl: '');

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _desciptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusedNode.dispose();
  }

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      final routeArgument = ModalRoute.of(context)!.settings.arguments;
      if (routeArgument != null) {
        String productId = routeArgument as String;
        _editingProduct =
            Provider.of<ProductsProvider>(context).findById(productId);
        _imageUrlController.text = _editingProduct.imageUrl;
      }
    }
    _isInitialized = true;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusedNode.addListener(_updateImageChange);
  }

  void _updateImageChange() {
    final value = _imageUrlController.text;
    if ((value.startsWith("http://") || value.startsWith("https://")) &&
        (value.endsWith(".jpg") ||
            value.endsWith(".jpeg") ||
            value.endsWith("png"))) {
      setState(() {
        _isUrlValid = true;
      });
    } else {
      setState(() {
        _isUrlValid = false;
      });
    }
  }

  void _saveFormData() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editingProduct.id == '') {
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_editingProduct)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    } else {
      Provider.of<ProductsProvider>(context, listen: false)
          .editProduct(_editingProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        actions: [
          IconButton(onPressed: _saveFormData, icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _editingProduct.title,
                        decoration: const InputDecoration(label: Text("Title")),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) return "Please enter a value";
                          return null;
                        },
                        onSaved: (title) {
                          _editingProduct = Product(
                              id: _editingProduct.id,
                              title: title!,
                              description: _editingProduct.description,
                              price: _editingProduct.price,
                              imageUrl: _editingProduct.imageUrl,
                              isFavorite: _editingProduct.isFavorite);
                        },
                      ),
                      TextFormField(
                        initialValue: _editingProduct.price.toString(),
                        decoration: const InputDecoration(label: Text("Price")),
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_desciptionFocusNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) return "Please enter a price";
                          if (double.tryParse(value) == null) {
                            return "Price must be a number";
                          }
                          if (double.parse(value) <= 0) {
                            return "Price must be a greater number than zero";
                          }
                          return null;
                        },
                        onSaved: (price) {
                          _editingProduct = Product(
                              id: _editingProduct.id,
                              title: _editingProduct.title,
                              description: _editingProduct.description,
                              price: double.parse(price!),
                              imageUrl: _editingProduct.imageUrl,
                              isFavorite: _editingProduct.isFavorite);
                        },
                      ),
                      TextFormField(
                        initialValue: _editingProduct.description,
                        decoration:
                            const InputDecoration(label: Text("Description")),
                        focusNode: _desciptionFocusNode,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Please enter a description";
                          if (value.length < 10) {
                            return "Description must be at least 10 characters";
                          }
                          return null;
                        },
                        onSaved: (description) {
                          _editingProduct = Product(
                              id: _editingProduct.id,
                              title: _editingProduct.title,
                              description: description!,
                              price: _editingProduct.price,
                              imageUrl: _editingProduct.imageUrl,
                              isFavorite: _editingProduct.isFavorite);
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20, right: 15),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: (_imageUrlController.text.isEmpty ||
                                    !_isUrlValid)
                                ? const Text(
                                    "Enter Image Url",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 11),
                                  )
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                label: Text("Image URL"),
                              ),
                              keyboardType: TextInputType.url,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusedNode,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a image URL";
                                }
                                if (!value.startsWith("http://") &&
                                        !value.startsWith("https://") ||
                                    (!value.endsWith(".jpg") &&
                                        !value.endsWith(".jpeg") &&
                                        !value.endsWith("png"))) {
                                  return "Please enter a valid image URL";
                                }

                                return null;
                              },
                              textInputAction: TextInputAction.done,
                              onSaved: (imageUrl) {
                                _editingProduct = Product(
                                    id: _editingProduct.id,
                                    title: _editingProduct.title,
                                    description: _editingProduct.description,
                                    price: _editingProduct.price,
                                    imageUrl: imageUrl!,
                                    isFavorite: _editingProduct.isFavorite);
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )),
    );
  }
}
