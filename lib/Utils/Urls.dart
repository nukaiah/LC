import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Urls {
  static String baseUrl = "https://node-mongo-seven.vercel.app/api/";
}

class ApiMethods {
  static const jsonHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };

  static headers1({required usertoken}) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $usertoken',
  };

  static var token;
  static var userId;
  static var roleId;

  static Future<void> getKeys() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    userId = sharedPreferences.getString("userId");
    roleId = sharedPreferences.getString("roleId");
  }

  static getMethod({required endpoint}) async {
    try {
      Uri url = Uri.parse(Urls.baseUrl + endpoint);
      final response = await http.get(url, headers: headers1(usertoken: token));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      }
    } on Exception {
      return null;
    }
  }

  static postMethod({required endpoint, required postJson}) async {
    try {
      Uri url = Uri.parse(Urls.baseUrl + endpoint);
      final response = await http.post(url,
          headers: headers1(usertoken: token), body: jsonEncode(postJson));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      }
    } on Exception {
      return null;
    }
  }

  static loginMethod({required postJson}) async {
    try {
      Uri url = Uri.parse(Urls.baseUrl + "users/login");
      final response = await http.post(url,
          body: json.encode(postJson), headers: jsonHeaders);
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData;
      }
    } on Exception {
      return null;
    }
  }
}