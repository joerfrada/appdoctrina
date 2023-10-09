// ignore_for_file: avoid_unnecessary_containers, avoid_print, sized_box_for_whitespace, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'package:appdoctrina/pages/contact.dart';
import 'package:appdoctrina/pages/home.dart';
import 'package:appdoctrina/pages/list.dart';
import 'package:appdoctrina/pages/news.dart';
import 'package:appdoctrina/pages/texts.dart';
import 'package:appdoctrina/views/webview.dart';
import 'package:appdoctrina/services/api.dart';
import 'package:appdoctrina/services/auth.dart';
import 'package:appdoctrina/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  String usuario = '';
  String password = '';
  bool initSesionVar = false;
  bool sessionStart = false;

  final TextEditingController userField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();

  void showError(BuildContext context, String titulo, String mensaje) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: [
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: MyColors.azul),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Aceptar',
                  )),
            ],
          );
        });
  }

  login() async {
    usuario = userField.text;
    password = passwordField.text;

    initSesionVar = true;

    UsuarioResponse respuesta = await LoginService.login(usuario, password);

    if (respuesta.tipo == 0) {
      SharedPreferences shared_User = await SharedPreferences.getInstance();
      Map<String, dynamic> usuarioDecode = respuesta.result.toJson();
      shared_User.setString('usuario', json.encode(usuarioDecode));

      Future.delayed(const Duration(seconds: 1), () {
        initSesionVar = false;
        setDataShared(true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      });
    } else {
      initSesionVar = false;
      showError(context, 'Error', respuesta.mensaje!);
      passwordField.text = '';
    }
  }

  getDataShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessionStart = prefs.getBool('sessionStart') ?? false;
    print("Session: $sessionStart");

    if (sessionStart == true) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      });
    }
  }

  setDataShared(bool b) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('sessionStart', b);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          getDataShared();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background-login.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 10),
                      decoration: const BoxDecoration(color: MyColors.azul),
                      child: Image.asset(
                        'assets/logo.png',
                        alignment: Alignment.center,
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Text("Iniciar Sesión",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    const SizedBox(height: 50),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: userField,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Usuario',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: passwordField,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Contraseña',
                              prefixIcon: Icon(Icons.lock),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          login();
                        });
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.azul),
                          child: initSesionVar
                              ? Container(
                                  width: 25,
                                  height: 25,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text("Ingresar",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))),
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      ),
                      child: const Text("¡Tengo problemas para ingresar!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              decoration: TextDecoration.underline)),
                    ),
                    const SizedBox(height: 50),
                    GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TextsPage())),
                        child: const Text("Términos y condiciones",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                decoration: TextDecoration.underline))),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        )),
        bottomNavigationBar: Container(
          color: MyColors.azul,
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ListPage(
                                  categoria_id: 15,
                                  titulo: "Documentos de \nConsulta"))),
                      child: const Column(children: [
                        Icon(Icons.article, color: MyColors.verde),
                        Text("Documentos de \nConsulta",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10, color: Colors.white))
                      ]))),
              Expanded(
                  child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewsPage())),
                      child: const Column(children: [
                        Icon(Icons.public, color: MyColors.verde),
                        Text("Noticias de\nInterés",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10, color: Colors.white))
                      ]))),
              Expanded(
                  child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WebViewPage(
                                  url: "https://www.policia.gov.co"))),
                      child: const Column(children: [
                        Icon(Icons.language, color: MyColors.verde),
                        Text("Página Web\nPolicia Nacional",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10, color: Colors.white))
                      ]))),
              Expanded(
                  child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactPage())),
                      child: const Column(children: [
                        Icon(Icons.help, color: MyColors.verde),
                        Text("Contacto\ny Soporte",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10, color: Colors.white))
                      ]))),
            ],
          ),
        ));
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Ayuda: Acceso a este equipo'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Asegúrate deque no estás agregando un espacio en blanco antes o después de la contraseña y del usuario.\nDe lo contrario solicita ayuda en los canales de soporte y contacto."),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ContactPage())),
          child: const Text('Ir a contacto'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
