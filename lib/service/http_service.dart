import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:login/views/dashboard.dart';

class HttpService {
  static final _client = http.Client();

  static var _loginUrl = Uri.parse(
      'https://flaskflutterlogin.herokuapp.com/login');

  static var _registerUrl = Uri.parse(
      'https://flaskflutterlogin.herokuapp.com/register');

  static login(email, password, context) async {
    http.Response response = await _client.post(_loginUrl, body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      //if (json[0] == 'success') {
      if (email == "new@example.com" && password == "abcd") {
        await EasyLoading.showSuccess(json[0]);
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        EasyLoading.showError(json[0]);
      }
    }
    else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
}