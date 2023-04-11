import 'package:flutter/material.dart';

class AddNewProduct extends StatefulWidget {
  static const routeName = "/add-new-product";
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final _priceFocusNode = FocusNode();
  final _desciptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusedNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _desciptionFocusNode.dispose();
    _imageUrlController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _imageUrlFocusedNode.addListener(_updateImageChange);
  }

  void _updateImageChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: Form(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text("Title")),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Price")),
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_desciptionFocusNode);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Description")),
                focusNode: _desciptionFocusNode,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
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
                    child: _imageUrlController.text.isEmpty
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
                      onEditingComplete: () {
                        setState(() {});
                      },
                      textInputAction: TextInputAction.done,
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
