// ignore_for_file: avoid_unnecessary_containers

import 'package:appdoctrina/models/categoria.dart';
import 'package:appdoctrina/pages/list.dart';
import 'package:appdoctrina/services/api.dart';
import 'package:appdoctrina/services/categorias.dart';
import 'package:appdoctrina/values/colors.dart';
import 'package:flutter/material.dart';

class CatsPage extends StatefulWidget {
  const CatsPage({super.key});

  @override
  State<StatefulWidget> createState() => _CatsPageState();
}

class _CatsPageState extends State<CatsPage>
    with SingleTickerProviderStateMixin {
  late Future<List<Categoria>> cats;

  Future<List<Categoria>> loadCategorias() async {
    CategoriaResponse respuesta = await CategoriaService.getCategorias();
    Future<List<Categoria>> cats = Future.value(respuesta.result);
    return cats;
  }

  @override
  void initState() {
    super.initState();

    cats = loadCategorias().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerRight,
            child: const Icon(Icons.category)),
        elevation: 0.0,
      ),
      body: Container(
        child: FutureBuilder(
            future: cats,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListPage(
                                    categoria_id:
                                        snapshot.data[index].categoria_id,
                                    titulo: snapshot.data[index].nombre))),
                        child: Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            leading: ClipOval(
                              child: Image.asset("assets/cats/1.jpg"),
                            ),
                            title: Text(snapshot.data[index].nombre),
                            trailing: const Icon(Icons.arrow_right),
                          ),
                        ));
                  },
                );
              } else {
                return const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: MyColors.azulclaro,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
