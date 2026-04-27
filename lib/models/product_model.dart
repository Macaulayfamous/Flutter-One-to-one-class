import 'dart:convert';

class ProductModel {
  final String id;
  final String category;
  final String productName;
  final double productPrice;
  final String description;
  final String vendor;
  final bool approved;
  final String imageUrl;
  final String createdAt;

  ProductModel({
    required this.id,
    required this.category,
    required this.productName,
    required this.productPrice,
    required this.description,
    required this.vendor,
    required this.approved,
    required this.imageUrl,
    required this.createdAt,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] is Map ? map['id']['S'] : map['id'],
      category: map['category'] is Map ? map['category']['S'] : map['category'],
      productName: map['productName'] is Map
          ? map['productName']['S']
          : map['productName'],
      productPrice: double.tryParse(map['productPrice'].toString()) ?? 0,
      description: map['description'] is Map
          ? map['description']['S']
          : map['description'],
      vendor: map['vendor'] == null
          ? ''
          : (map['vendor'] is Map ? map['vendor']['S'] : map['vendor']),
      approved: map['approved'] ?? false,
      imageUrl: map['imageUrl'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
