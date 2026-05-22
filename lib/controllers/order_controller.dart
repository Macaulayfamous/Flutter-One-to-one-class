import 'package:http/http.dart' as http;
import 'package:multi_app/models/order_model.dart';

class OrderController {
  Future<void>placeOrder({
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
      if (response.statusCode == 201) {
        print('Order Placed successfully');
      } else {
        print('Order creation failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

