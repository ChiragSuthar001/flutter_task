import 'package:dummy_api/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Products'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          Text('Title: ${product.title}'),
          Text('Brand: ${product.brand}'),
          Text('Category: ${product.category}'),
          Text('Description: ${product.description}'),
          Text('DiscountPercentage: ${product.discountPercentage}'),
          Text('Rating: ${product.rating}'),
          Text('Stock: ${product.stock}'),
          for (final i in product.images) Text('Image: $i'),
        ],
      ),
    );
  }
}
