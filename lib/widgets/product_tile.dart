import 'package:dummy_api/models/product_model.dart';
import 'package:dummy_api/screens/product_screen/bloc/products_bloc.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    super.key,
    required this.productData,
    required this.productsBloc,
  });

  final ProductModel productData;
  final ProductsBloc productsBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 7,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => productsBloc.add(
            ProductClickedEvent(productClicked: productData),
          ),
          child: Column(
            children: [
              Image.network(
                productData.thumbnail,
                fit: BoxFit.cover,
                height: 170,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset("assets/images/placeholder.webp"),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productData.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: const Color.fromARGB(255, 189, 68, 68)),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      productData.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "\$${productData.price}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        const Spacer(),
                        Text(
                          productData.rating.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
