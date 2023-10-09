// ignore_for_file: non_constant_identifier_names

class Categoria {
  int categoria_id;
  String nombre;

  Categoria({required this.categoria_id, required this.nombre});

  factory Categoria.fromJson(var json) {
    return Categoria(
      categoria_id: json["categoria_id"],
      nombre: json["nombre"],
    );
  }
}
