part of 'products_bloc.dart';

@immutable
abstract class ProductsState {}

abstract class ProductsActionState extends ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoadingSuccess extends ProductsState {
  final List<ProductModel> products;
  ProductsLoadingSuccess({
    required this.products,
  });
}

class ProductByIdLoadingSuccess extends ProductsState {
  final ProductModel product;
  ProductByIdLoadingSuccess({
    required this.product,
  });
}

class ProductsLoadingError extends ProductsState {
  final Object error;
  ProductsLoadingError({required this.error}) {
    debugPrint(error.toString());
  }
}

class ProductsNavigateToProductsDetailsScreen extends ProductsActionState {
  final ProductModel productModel;
  ProductsNavigateToProductsDetailsScreen({
    required this.productModel,
  });
}
