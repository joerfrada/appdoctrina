// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:appdoctrina/services/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriaService {
  static Future<CategoriaResponse> getCategorias() async {
    var url = Uri.parse(baseURL + 'categoria/getCategorias');
    http.Response response = await http.get(url, headers: headers);

    Map<String, dynamic> jsonBody = jsonDecode(response.body);

    return CategoriaResponse.fromJson(jsonBody);
  }
}
