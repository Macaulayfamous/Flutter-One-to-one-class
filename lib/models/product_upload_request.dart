class ProductUploadRequest {
  final String fileName;
  final String fileType;
  final String category;
  final String productName;
  final String description;
  final int quantity;
  final int instock;
  final double productPrice;
  final String vendorId;

  ProductUploadRequest({
    required this.fileName,
    required this.fileType,
    required this.category,
    required this.productName,
    required this.description,
    required this.quantity,
    required this.instock,
    required this.productPrice,
    required this.vendorId,
  });

  Map<String, dynamic> toJson() {
    return {
      'fileName': fileName,
      'fileType': fileType,
      'category': category,
      'productName': productName,
      'description': description,
      'quantity': quantity,
      'instock': instock,
      'productPrice': productPrice,
      'vendorId': vendorId,
    };
  }
}
