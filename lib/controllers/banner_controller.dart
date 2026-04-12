import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:multi_app/models/banner_model.dart';

class BannerController {
  Future<List<BannerModel>> fetchBaners () async{
  final response =  await http.get(Uri.parse('https://avseti1xg8.execute-api.eu-north-1.amazonaws.com/dev/get-ads'));

  if(response.statusCode==200){
    final body = json.decode(response.body);
    final List data = body['data'];

    return data.map((e) => BannerModel.fromMap(e)).toList();
  }else{
     throw Exception('Failed to load banners');
  }
  }
}

