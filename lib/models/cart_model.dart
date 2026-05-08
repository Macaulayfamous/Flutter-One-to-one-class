class CartModel {
  final String id;
  final String productName;
  final String category;
  final double productPrice;
  final String imageUrl;
  final String description;
  final String vendor;
   int quantity;

  CartModel({required this.id, required this.productName, required this.category, required this.productPrice, required this.imageUrl, required this.description, required this.vendor, required this.quantity});

}