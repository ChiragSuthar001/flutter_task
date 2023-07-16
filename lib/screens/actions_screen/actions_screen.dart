import 'package:dummy_api/screens/product_screen/product_screen.dart';
import 'package:dummy_api/screens/product_screen/search_product.dart';
import 'package:dummy_api/utils/screen_navigator.dart';
import 'package:dummy_api/widgets/grid_item.dart';
import 'package:flutter/material.dart';

class ActionsScreen extends StatelessWidget {
  const ActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Actions on Products'),
        shadowColor: const Color.fromARGB(160, 0, 106, 96),
        elevation: 7,
      ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          GridItem(
            gridTitle: 'Get All Products',
            changeScreen: () => navigateScreen(
              context,
              const ProductsScreen(
                productPageType: ProductPage.getAllProducts,
              ),
            ),
          ),
          GridItem(
            gridTitle: 'Search Products',
            changeScreen: () => navigateScreen(
              context,
              SearchProduct(),
            ),
          ),
          GridItem(
            gridTitle: 'Get a Product',
            changeScreen: () => navigateScreen(
              context,
              SearchProduct(searchByName: false),
            ),
          ),
          GridItem(
            gridTitle: 'Add a Products',
            changeScreen: () {},
          ),
          GridItem(
            gridTitle: 'Edit a Products',
            changeScreen: () {},
          ),
        ],
      ),
    );
  }
}
