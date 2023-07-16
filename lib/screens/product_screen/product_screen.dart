import 'package:dummy_api/screens/product_details_screen/product_details_screen.dart';
import 'package:dummy_api/screens/product_screen/bloc/products_bloc.dart';
import 'package:dummy_api/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ProductPage {
  getAllProducts,
  searchProductByName,
  searchProductById,
  searchByCategory,
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    super.key,
    required this.productPageType,
    this.category,
    this.query,
  });

  final ProductPage productPageType;
  final String? category;
  final String? query;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductsBloc _productsBloc = ProductsBloc();

  @override
  void initState() {
    switch (widget.productPageType) {
      case ProductPage.getAllProducts:
        _productsBloc.add(ProductIntialEvent());
        break;
      case ProductPage.searchProductByName:
        _productsBloc.add(ProductSearchEvent(query: widget.query!));
        break;
      case ProductPage.searchProductById:
        _productsBloc.add(ProductSearchByIdEvent(id: widget.query!));
      case ProductPage.searchByCategory:
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      bloc: _productsBloc,
      listenWhen: (previous, current) => current is ProductsActionState,
      buildWhen: (previous, current) => current is! ProductsActionState,
      listener: (context, state) {
        if (state is ProductsNavigateToProductsDetailsScreen) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ProductDetailsScreen(
                product: state.productModel,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        Widget? content;

        switch (state.runtimeType) {
          case ProductsLoading:
            content = const Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ProductsLoadingSuccess:
            final successState = state as ProductsLoadingSuccess;
            content = ListView.builder(
              itemCount: successState.products.length,
              itemBuilder: (context, index) => ProductTile(
                productData: successState.products[index],
                productsBloc: _productsBloc,
              ),
            );
            break;
          case ProductsLoadingError:
            final errorState = state as ProductsLoadingError;
            content = Center(
              child: errorState.error is String
                  ? Text(errorState.error as String)
                  : const Text('Some Error Occurred!'),
            );
            break;
          default:
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text('Products'),
          ),
          body: content,
        );
      },
    );
  }
}
