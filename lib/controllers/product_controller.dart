import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:multi_app/models/product_model.dart';


class ProductController {
  static const String productUrl = 'https://7rcweclw4e.execute-api.eu-north-1.amazonaws.com/dev/products';

  Future<List<ProductModel>> getProducts() async{
    final response  = await http.get(Uri.parse(productUrl));

    final data = jsonDecode(response.body);

    if(response.statusCode==200){
      final List products = data['products'] ?? [];

      return products.map((product) =>ProductModel.fromJson(product)).toList();
    }else{
      throw Exception(data['details']?? "Something wrong");
    }
  }
}
