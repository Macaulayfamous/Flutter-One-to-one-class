// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ConfirmSignupModel {
  final String email;
  final String code;

  ConfirmSignupModel({required this.email, required this.code});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'code': code,
    };
  }

  
  String toJson() => json.encode(toMap());

}
