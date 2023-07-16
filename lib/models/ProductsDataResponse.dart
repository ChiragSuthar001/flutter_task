import 'package:dummy_api/models/product_model.dart';

class ProductsResponseModel {
  final List<ProductModel> products = [];
  final int total;
  final int skip;
  final int limit;

  ProductsResponseModel.jsonToObject(Map<String, dynamic> jsonObject)
      : total = jsonObject['total'],
        skip = jsonObject['skip'],
        limit = jsonObject['limit'] {
    List<dynamic> productMap = jsonObject['products'];
    products
        .addAll(productMap.map((e) => ProductModel.jsonToObject(e)).toList());
  }
}
