// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class BannerModel {
  final String imageUrl;

  BannerModel({required this.imageUrl});
  

 
  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      imageUrl: map['imageUrl'] as String,
    );
  }


  factory BannerModel.fromJson(String source) => BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
