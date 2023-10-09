// ignore_for_file: unused_element, prefer_is_empty, non_constant_identifier_names

import 'package:appdoctrina/components/componentes.dart';
import 'package:appdoctrina/models/articulo.dart';
import 'package:appdoctrina/pages/detail.dart';
import 'package:appdoctrina/services/api.dart';
import 'package:appdoctrina/services/articulos.dart';
import 'package:appdoctrina/values/colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  TextEditingController controller = TextEditingController();
  late Future<List<Articulo>> search;
  String searchtext = "";

  Future<List<Articulo>> fetchArticulos(String categoria_id, String featurecat,
      String feature, String top, String titulo) async {
    ArticuloResponse response = await ArticuloService.fetchArticulos(
        categoria_id, featurecat, feature, top, titulo);
    Future<List<Articulo>> arts = Future.value(response.result);
    return arts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerRight,
          child: const Text(
            "145 elementos encontrados",
            style: TextStyle(fontSize: 12),
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [MyColors.azul, MyColors.azulclaro],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.search),
                    title: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                          hintText: 'Buscar documento, video, podcast, etc',
                          border: InputBorder.none),
                      onChanged: (value) {},
                      onSubmitted: (value) {
                        setState(() {
                          searchtext = value;
                          search = fetchArticulos("0", "0", "0", "0", value);
                        });
                      },
                    ),
                    trailing: IconButton(
                      icon: searchtext.length > 0
                          ? const Icon(Icons.cancel)
                          : const Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          if (searchtext.length > 0) {
                            searchtext = "";
                            controller.clear();
                          } else {}
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            if (searchtext.length == 0)
              Expanded(
                child: Center(
                  child: Image(
                    image: Image.asset("assets/background-search.jpg").image,
                    width: 200,
                  ),
                ),
              ),
            if (searchtext.length > 0)
              FutureBuilder(
                  future: search,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(child: UtilsCore.generalLoader(context));
                    } else {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                            padding: const EdgeInsets.all(20),
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      data: snapshot.data[index],
                                    ),
                                  ),
                                ),
                                child: Card(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  shadowColor: MyColors.azul,
                                  color: Colors.grey.shade50,
                                  elevation: 2,
                                  child: ListTile(
                                    trailing: const Icon(Icons.arrow_right),
                                    horizontalTitleGap: 1,
                                    title: Text(
                                      snapshot.data[index].titulo,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle:
                                        Text(snapshot.data[index].subtitulo),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return const Expanded(
                            child: Center(child: Text("Sin resultados")));
                      }
                    }
                  }),
          ],
        ),
      ),
    );
  }
}
