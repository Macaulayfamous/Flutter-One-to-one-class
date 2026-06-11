import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:multi_app/models/order_model.dart';

class OrderController {
  Future<String?>placeOrder({
  required String customerId,
  required String vendorId,
  required String productId,
  required String productName,
  required int quantity,
  required double price,
  required String deliveryAddress,
  required String phoneNumber,
  })async{
    try {
      final OrderModel orderModel = OrderModel(
        customerId: customerId,
        vendorId: vendorId,
        productId: productId,
        productName: productName,
        quantity: quantity,
        price: price,
        deliveryAddress: deliveryAddress,
        phoneNumber: phoneNumber,
      );
      http.Response response = await http.post(
        Uri.parse(
          'https://rh3sxn2sz8.execute-api.eu-north-1.amazonaws.com/prod/place-order',
        ),
        body: orderModel.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      
      final data = jsonDecode(response.body);


      if (response.statusCode == 201) {
         return data['id'];
      } else {
        print(data);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>?> createPayPalPayment({
    required String orderId,
    required double amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://rh3sxn2sz8.execute-api.eu-north-1.amazonaws.com/prod/create-paypal-payment',
        ),
        body: jsonEncode({"orderId": orderId, "amount": amount}),
         headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return data;
      } else {
        print(data);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future<bool> capturePayPalPayment({
    required String orderId,
    required String paypalOrderId,
  })async {
    try {
      final response = await http.post(
        Uri.parse('https://rh3sxn2sz8.execute-api.eu-north-1.amazonaws.com/prod/capture-payment',),
         headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },

        body: jsonEncode({
          "orderId": orderId,
          "paypalOrderId": paypalOrderId,
        }),

      );
      final data = jsonDecode(response.body);
      print(data);
      return response.statusCode ==200 && data['status'] == "COMPLETED";
    } catch (e) {
      return false;
    }
  }
}


