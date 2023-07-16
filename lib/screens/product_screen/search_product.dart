import 'package:dummy_api/screens/product_screen/product_screen.dart';
import 'package:flutter/material.dart';

class SearchProduct extends StatelessWidget {
  SearchProduct({super.key, this.searchByName = true});
  final formKey = GlobalKey<FormState>();
  final bool searchByName;

  @override
  Widget build(BuildContext context) {
    String query = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Actions on Products'),
        shadowColor: const Color.fromARGB(160, 0, 106, 96),
        elevation: 7,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Row(
            children: [
              Expanded(
                child: searchByName
                    ? TextFormField(
                        maxLength: 50,
                        initialValue: query,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty ||
                              value.trim().length <= 1) {
                            return 'Must be a valid input';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Search Product Name'),
                        ),
                        onSaved: (value) => query = value!,
                        autofocus: true,
                      )
                    : TextFormField(
                        maxLength: 50,
                        initialValue: query,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Must be valid Positive Number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Enter Product Id'),
                        ),
                        onSaved: (value) => query = value!,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                      ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ProductsScreen(
                          productPageType: searchByName
                              ? ProductPage.searchProductByName
                              : ProductPage.searchProductById,
                          query: query,
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
