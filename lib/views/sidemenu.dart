// ignore_for_file: avoid_print, must_be_immutable

import 'package:appdoctrina/models/usuario.dart';
import 'package:appdoctrina/pages/contact.dart';
import 'package:appdoctrina/pages/login.dart';
import 'package:appdoctrina/pages/news.dart';
import 'package:appdoctrina/views/webview.dart';
import 'package:appdoctrina/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenuDrawer extends StatelessWidget {
  const SideMenuDrawer({super.key, required this.user});

  final Usuario user;

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: MyColors.azul,
        padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 52,
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
            const SizedBox(height: 12),
            Text(user.usuario,
                style: const TextStyle(fontSize: 28, color: Colors.white)),
            const SizedBox(height: 12),
            Text(user.descripcion_unidad_dependencia,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(5),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.article, color: MyColors.azul),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.public, color: MyColors.azul),
            title: const Text('Noticias de Interés'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewsPage())),
          ),
          ListTile(
            leading: const Icon(Icons.language, color: MyColors.azul),
            title: const Text('Página Web Policia Nacional'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const WebViewPage(url: "https://www.policia.gov.co"))),
          ),
          ListTile(
            leading: const Icon(Icons.help, color: MyColors.azul),
            title: const Text('Contacto y Soporte'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ContactPage())),
          ),
          const Divider(color: Colors.black87),
          ListTile(
            leading: const Icon(Icons.logout, color: MyColors.azul),
            title: const Text('Cerrar Sesión'),
            onTap: () {
              logout();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ));

  void logout() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.remove('usuario');
    sharedPrefs.remove('sessionStart');
  }
}
