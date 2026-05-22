// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderModel {
  final String customerId;
  final String vendorId;
  final String productId;
  final String productName;
  final int quantity;
  final double price;
  final String deliveryAddress;
  final String phoneNumber;

  OrderModel({
    required this.customerId,
    required this.vendorId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.deliveryAddress,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerId': customerId,
      'vendorId': vendorId,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'price': price,
      'deliveryAddress': deliveryAddress,
      'phoneNumber': phoneNumber,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      customerId: map['customerId'] as String,
      vendorId: map['vendorId'] as String,
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      quantity: map['quantity'] as int,
      price: map['price'] as double,
      deliveryAddress: map['deliveryAddress'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
