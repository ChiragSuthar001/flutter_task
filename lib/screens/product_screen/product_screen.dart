import 'package:dummy_api/models/product_model.dart';
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
  final ScrollController scrollController = ScrollController();
  final List<ProductModel> _products = [];
  int pageNumber = 1;
  bool isPageLoading = false;
  bool error = false;

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
    scrollController.addListener(() {
      if ((scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) &&
          (_products.length < 100) &&
          !isPageLoading &&
          !error) {
        isPageLoading = true;
        _productsBloc.add(ProductPageChangedEvent(pageNumber: ++pageNumber));
      }
    });
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
        Widget content = const Center(child: CircularProgressIndicator());

        switch (state.runtimeType) {
          case ProductsLoading:
            isPageLoading = true;
            content = const Center(child: CircularProgressIndicator());
            break;
          case ProductsLoadingSuccess:
            isPageLoading = false;
            final successState = state as ProductsLoadingSuccess;
            _products.addAll(successState.products);
            break;
          case ProductByIdLoadingSuccess:
            isPageLoading = false;
            final successState = state as ProductByIdLoadingSuccess;
            _products.clear();
            _products.add(successState.product);
            break;
          case ProductsLoadingError:
            error = true;
            isPageLoading = false;
            final errorState = state as ProductsLoadingError;
            content = Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                errorState.error is String
                    ? Text(errorState.error as String)
                    : const Text('Some Error Occurred!'),
                TextButton(
                  onPressed: () => _productsBloc.add(
                    ProductPageChangedEvent(pageNumber: pageNumber),
                  ),
                  child: const Text('Retry'),
                ),
              ],
            );
            break;
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: const Text('Products'),
          ),
          body: Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ListView.builder(
              controller: scrollController,
              itemCount: _products.length + 1,
              itemBuilder: (context, index) {
                if (index < _products.length) {
                  return ProductTile(
                    productData: _products[index],
                    productsBloc: _productsBloc,
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: content,
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
