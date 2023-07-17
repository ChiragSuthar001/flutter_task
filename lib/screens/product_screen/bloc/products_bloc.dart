import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dummy_api/models/products_data_response.dart';
import 'package:dummy_api/models/product_model.dart';
import 'package:dummy_api/utils/http_request.dart';
import 'package:flutter/cupertino.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductIntialEvent>(_productsInitialEvent);
    on<ProductClickedEvent>(_productClicked);
    on<ProductSearchEvent>(_productSearchEvent);
    on<ProductSearchByIdEvent>(_productSearchByIdEvent);
    on<ProductSearchCategoryEvent>(_productSearchCategoryEvent);
    on<ProductPageChangedEvent>(_productPageChangedEvent);
  }

  FutureOr<void> _productsInitialEvent(
    ProductIntialEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    late final Map<String, dynamic> res;
    try {
      res = await getData('product');
    } catch (e) {
      emit(ProductsLoadingError(error: e));
      return;
    }
    final List<ProductModel> result = [];
    for (final i in res['products']) {
      result.add(ProductModel.jsonToObject(i));
    }
    emit(ProductsLoadingSuccess(products: result));
  }

  FutureOr<void> _productClicked(
    ProductClickedEvent event,
    Emitter<ProductsState> emit,
  ) {
    emit(
      ProductsNavigateToProductsDetailsScreen(
        productModel: event.productClicked,
      ),
    );
  }

  FutureOr<void> _productSearchEvent(
    ProductSearchEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    late final Map<String, dynamic> res;
    try {
      res = await getData('products/search', query: {"q": event.query});
    } catch (e) {
      emit(ProductsLoadingError(error: e));
      return;
    }

    if (ProductsResponseModel.jsonToObject(res).products.isEmpty) {
      emit(ProductsLoadingError(error: 'Product not Found! 404'));
      return;
    }

    final List<ProductModel> result = [];
    for (final i in res['products']) {
      result.add(ProductModel.jsonToObject(i));
    }
    emit(ProductsLoadingSuccess(products: result));
  }

  FutureOr<void> _productSearchCategoryEvent(
    ProductSearchCategoryEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    late final Map<String, dynamic> res;
    try {
      res = await getData('products/category/${event.category}');
    } catch (e) {
      emit(ProductsLoadingError(error: e));
      return;
    }
    final List<ProductModel> result = [];
    for (final i in res['products']) {
      result.add(ProductModel.jsonToObject(i));
    }
    emit(ProductsLoadingSuccess(products: result));
  }

  FutureOr<void> _productSearchByIdEvent(
      ProductSearchByIdEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    late final Map<String, dynamic> res;
    try {
      res = await getData('products/${event.id}');
    } catch (e) {
      emit(ProductsLoadingError(error: e));
      return;
    }
    emit(ProductByIdLoadingSuccess(product: ProductModel.jsonToObject(res)));
  }

  FutureOr<void> _productPageChangedEvent(
      ProductPageChangedEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    late final Map<String, dynamic> res;
    try {
      res = await getData('product', pageNumber: event.pageNumber);
    } catch (e) {
      emit(ProductsLoadingError(error: e));
      return;
    }
    final List<ProductModel> result = [];
    for (final i in res['products']) {
      result.add(ProductModel.jsonToObject(i));
    }
    emit(ProductsLoadingSuccess(products: result));
  }
}
