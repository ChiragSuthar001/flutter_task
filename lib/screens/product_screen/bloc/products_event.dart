// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class ProductIntialEvent extends ProductsEvent {}

class ProductClickedEvent extends ProductsEvent {
  final ProductModel productClicked;
  ProductClickedEvent({
    required this.productClicked,
  });
}

class ProductSearchEvent extends ProductsEvent {
  final String query;
  ProductSearchEvent({
    required this.query,
  });
}

class ProductSearchByIdEvent extends ProductsEvent {
  final String id;
  ProductSearchByIdEvent({
    required this.id,
  });
}

class ProductSearchCategoryEvent extends ProductsEvent {
  final String category;
  ProductSearchCategoryEvent({
    required this.category,
  });
}
