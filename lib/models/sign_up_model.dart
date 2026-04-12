// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUpModel {
  final String email;
  final String fullName;
  final String password;

  SignUpModel({required this.email, required this.fullName, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'fullName': fullName,
      'password': password,
    };
  }

  
  String toJson() => json.encode(toMap());

}
