import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_app/models/confirm_signup_model.dart';
import 'package:multi_app/models/sign_in_model.dart';
import 'package:multi_app/models/sign_up_model.dart';
import 'package:multi_app/views/auth/confirm_sign_up_screen.dart';
import 'package:multi_app/views/auth/sign_in_screen.dart';
import 'package:multi_app/views/main/main_screen.dart';

class AuthController {
  Future<void> signUpUsers({
    required String email,
    required String fullName,
    required String password,
    required context,
  }) async {
    try {
      SignUpModel signUpModel = SignUpModel(
        email: email,
        fullName: fullName,
        password: password,
      );

      http.Response response = await http.post(
        Uri.parse(
          'https://3x84d3v64f.execute-api.eu-north-1.amazonaws.com/prod/signup',
        ),
        body: signUpModel.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 201) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ConfirmSignUpScreen(email: email);
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(response.body)['message'])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(response.body)['details'])),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong')));
    }
  }

  Future<void> confirmSignUp({
    required String email,
    required String code,
    required context,
  }) async {
    try {
      ConfirmSignupModel confirmSignupModel = ConfirmSignupModel(
        email: email,
        code: code,
      );
      http.Response response = await http.post(
        Uri.parse(
          'https://3x84d3v64f.execute-api.eu-north-1.amazonaws.com/prod/confirm-signup',
        ),
        body: confirmSignupModel.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SignInScreen();
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(response.body)['message'])),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(response.body)['detail'])),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong')));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
    required context,
  }) async {
    try {
      SignInModel signInModel = SignInModel(email: email, password: password);
      http.Response response = await http.post(
        Uri.parse(
          'https://3x84d3v64f.execute-api.eu-north-1.amazonaws.com/prod/signin',
        ),
        body: signInModel.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        //Navigate user to main screen where they can buy products
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(response.body)['message'])),
        );

        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MainScreen();
            },
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonDecode(response.body)['details'])),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong')));
    }
  }
}
