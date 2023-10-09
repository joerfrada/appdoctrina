// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:appdoctrina/models/usuario.dart';
import 'package:appdoctrina/models/categoria.dart';
import 'package:appdoctrina/models/articulo.dart';

// const String kURL = "http://192.168.1.171/doctrina/";
const String kURL = "https://apiadenunciarrnmc.policia.gov.co/doctrina/";
const String baseURL = kURL + "api/";
const String coverURL = kURL + "preview/cover/";
const String pdfURL = kURL + "preview/doc/";
const String mediaURL = kURL + "media/";
const Map<String, String> headers = {"Content-Type": "application/json"};

class ApiResponse {
  late int tipo;
  String? mensaje;

  ApiResponse({required this.tipo, required this.mensaje});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(tipo: json['tipo'], mensaje: json['mensaje']);
  }
}

class UsuarioResponse extends ApiResponse {
  Usuario result;

  UsuarioResponse(
      {required super.tipo, required super.mensaje, required this.result});

  factory UsuarioResponse.fromJson(Map<String, dynamic> json) {
    Usuario user = Usuario();

    if (json['tipo'] == 0) {
      dynamic mapUser = json['user']['result'];
      user.usuario_id = mapUser['usuario_id'];
      user.usuario = mapUser['usuario'];
      user.email = mapUser['email'];
      user.consecutivo = mapUser['consecutivo'];
      user.undeconsecutivo = mapUser['undeconsecutivo'];
      user.undefuerza = mapUser['undefuerza'];
      user.identificacion = mapUser['identificacion'];
      user.unidad_fisica = mapUser['unidad_fisica'] ?? "N/A";
      user.descripcion_unidad_dependencia =
          mapUser['descripcion_unidad_dependencia'] ?? "N/A";
      user.undeconsecutivo_laborando = mapUser['undeconsecutivo_laborando'];
      user.grado = mapUser['grado'] ?? "N/A";
      user.unidad_papa = mapUser['unidad_papa'] ?? "N/A";
    } else {
      user = Usuario();
    }

    return UsuarioResponse(
        tipo: json['tipo'], mensaje: json['mensaje'], result: user);
  }
}

class CategoriaResponse extends ApiResponse {
  List<Categoria> result;

  CategoriaResponse(
      {required super.tipo, required super.mensaje, required this.result});

  factory CategoriaResponse.fromJson(Map<String, dynamic> json) {
    List<Categoria> cat = [];

    if (json['tipo'] == 0) {
      var mapCat = json['result'] as List;
      cat = List.from(mapCat.map((e) => Categoria.fromJson(e)));
    } else {
      cat = [];
    }

    return CategoriaResponse(
        tipo: json['tipo'], mensaje: json['mensaje'] ?? "N/A", result: cat);
  }
}

class ArticuloResponse extends ApiResponse {
  List<Articulo> result;

  ArticuloResponse(
      {required super.tipo, required super.mensaje, required this.result});

  factory ArticuloResponse.fromJson(Map<String, dynamic> json) {
    List<Articulo> art = [];

    if (json['tipo'] == 0) {
      var mapArt = json['result'] as List;
      art = List.from(mapArt.map((e) => Articulo.fromJson(e)));
    } else {
      art = [];
    }

    return ArticuloResponse(
        tipo: json['tipo'], mensaje: json['mensaje'] ?? "N/A", result: art);
  }
}
