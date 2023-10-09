// ignore_for_file: non_constant_identifier_names, unnecessary_null_in_if_null_operators

class Articulo {
  int articulo_id;
  int feature;
  int categoria_id;
  String titulo;
  String subtitulo;
  String descripcion;
  String keywords;
  int num_pagina;
  String videol;
  String audiol;
  String ruta_cover;
  String ruta_doc;
  String ruta_audio;
  String ruta_video;

  Articulo(
      {required this.articulo_id,
      required this.feature,
      required this.categoria_id,
      required this.titulo,
      required this.subtitulo,
      required this.descripcion,
      required this.keywords,
      required this.num_pagina,
      required this.videol,
      required this.audiol,
      required this.ruta_cover,
      required this.ruta_doc,
      required this.ruta_audio,
      required this.ruta_video});

  factory Articulo.fromJson(var json) {
    return Articulo(
        articulo_id: json['articulo_id'],
        feature: json['feature'],
        categoria_id: json["categoria_id"],
        titulo: json["titulo"],
        subtitulo: json['subtitulo'],
        descripcion: json['descripcion'],
        keywords: json['keywords'],
        num_pagina: json['num_pagina'],
        videol: json['videol'],
        audiol: json['audiol'],
        ruta_cover: json['ruta_cover'],
        ruta_doc: json['ruta_doc'],
        ruta_audio: json['ruta_audio'],
        ruta_video: json['ruta_video']);
  }
}
