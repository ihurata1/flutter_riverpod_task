// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:root/models/user/login/response.dart';
import 'package:root/models/user/response.dart';
import 'package:http/http.dart' as http;

class Service {
  static Future<UserResponseModel?> fetch() async {
    var url = Uri.parse("https://reqres.in/api/users?page=2");
    var response;
    try {
      response = await http.get(url);

      if (response.statusCode == 200) {
        return UserResponseModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<UserLoginResponseModel?> postEmailAndPassword(String email, String password) async {
    final url = Uri.parse('https://reqres.in/api/login');

    final body = {'email': email, 'password': password};

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return UserLoginResponseModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
