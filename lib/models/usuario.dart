// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Usuario {
  late int usuario_id;
  late String usuario;
  late String email;
  late int consecutivo;
  late int undeconsecutivo;
  late int undefuerza;
  late int identificacion;
  late String unidad_fisica;
  late String descripcion_unidad_dependencia;
  late int undeconsecutivo_laborando;
  late String grado;
  late String unidad_papa;

  Map<String, dynamic> toJson() => {
        'usuario_id': usuario_id,
        'usuario': usuario,
        'email': email,
        'consecutivo': consecutivo,
        'undeconsecutivo': undeconsecutivo,
        'undefuerza': undeconsecutivo,
        'identificacion': identificacion,
        'unidad_fisica': unidad_fisica,
        'descripcion_unidad_dependencia': descripcion_unidad_dependencia,
        'undeconsecutivo_laborando': undeconsecutivo_laborando,
        'grado': grado,
        'unidad_papa': unidad_papa
      };

  Future<Usuario> loadUsuario() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap =
        json.decode(shared_User.getString('usuario')!);
    Usuario user = Usuario();
    user.usuario_id = userMap['usuario_id'];
    user.usuario = userMap['usuario'];
    user.email = userMap['email'];
    user.consecutivo = userMap['consecutivo'];
    user.undeconsecutivo = userMap['undeconsecutivo'];
    user.undefuerza = userMap['undefuerza'];
    user.identificacion = userMap['identificacion'];
    user.unidad_fisica = userMap['unidad_fisica'] ?? "N/A";
    user.descripcion_unidad_dependencia =
        userMap['descripcion_unidad_dependencia'] ?? "N/A";
    user.undeconsecutivo_laborando = userMap['undeconsecutivo_laborando'];
    user.grado = userMap['grado'] ?? "N/A";
    user.unidad_papa = userMap['unidad_papa'] ?? "N/A";

    return user;
  }
}
