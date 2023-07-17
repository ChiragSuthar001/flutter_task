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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.id,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(
                  product.thumbnail,
                  fit: BoxFit.cover,
                  height: 170,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset("assets/images/placeholder.webp"),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: const Color.fromARGB(255, 189, 68, 68)),
            ),
            const SizedBox(height: 12),
            Text(product.description),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    product.price.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.green,
                          fontSize: 18,
                        ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    'Discount',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "${product.discountPercentage}%",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.green,
                          fontSize: 18,
                        ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    'Rating',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.rating.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.green,
                              fontSize: 18,
                            ),
                      ),
                      const SizedBox(width: 3),
                      Icon(
                        Icons.star_outlined,
                        color: Colors.pinkAccent.shade200,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  flex: 5,
                  child: Text(
                    'Stock',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    product.stock.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.green,
                          fontSize: 18,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
