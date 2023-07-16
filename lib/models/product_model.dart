class ProductModel {
  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  ProductModel.jsonToObject(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        price = json['price'],
        discountPercentage = json['discountPercentage'],
        rating = json['rating'] + 0.00,
        stock = json['stock'],
        brand = json['brand'],
        category = json['category'],
        thumbnail = json['thumbnail'],
        images = json['images'];

  final int id;
  final String title;
  final String description;
  final int price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<dynamic> images;
}
