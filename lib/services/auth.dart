// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:appdoctrina/services/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<UsuarioResponse> login(String usuario, String password) async {
    Map params = {
      "usuario": usuario,
      "password": password,
    };
    var body = json.encode(params);
    var url = Uri.parse(baseURL + 'login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    Map<String, dynamic> jsonBody = jsonDecode(response.body);

    return UsuarioResponse.fromJson(jsonBody);
  }
}
