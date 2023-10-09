// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:appdoctrina/services/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ArticuloService {
  static Future<ArticuloResponse> getArticulos() async {
    var url = Uri.parse(baseURL + 'articulo/getArticulos');
    http.Response response = await http.get(url, headers: headers);

    Map<String, dynamic> jsonBody = jsonDecode(response.body);

    return ArticuloResponse.fromJson(jsonBody);
  }

  static Future<ArticuloResponse> fetchArticulos(String categoria_id,
      String featurecat, String feature, String top, String titulo) async {
    var query = baseURL +
        'articulo/getArticulo?categoria_id=' +
        categoria_id +
        "&featurecat=" +
        featurecat +
        "&feature=" +
        feature +
        "&top=" +
        top +
        "&titulo=" +
        titulo;
    var url = Uri.parse(query);
    http.Response response = await http.get(url, headers: headers);

    Map<String, dynamic> jsonBody = jsonDecode(response.body);
    return ArticuloResponse.fromJson(jsonBody);
  }
}
