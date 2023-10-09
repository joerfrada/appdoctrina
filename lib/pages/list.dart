// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, prefer_interpolation_to_compose_strings

import 'package:appdoctrina/components/componentes.dart';
import 'package:appdoctrina/models/articulo.dart';
import 'package:appdoctrina/pages/detail.dart';
import 'package:appdoctrina/services/api.dart';
import 'package:appdoctrina/services/articulos.dart';
import 'package:appdoctrina/values/colors.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key, required this.categoria_id, required this.titulo});

  final int categoria_id;
  final String titulo;

  @override
  State<StatefulWidget> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with TickerProviderStateMixin {
  late Future<List<Articulo>> public;

  @override
  void initState() {
    super.initState();
    public = fetchArticulos(widget.categoria_id.toString(), "0", "0", "0", "0")
        .whenComplete(() {
      setState(() {});
    });
  }

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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/top-documents.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 45,
                        left: 20,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Center(
                          child: Text(
                            widget.titulo,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                child: FutureBuilder(
                  future: public,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        return Wrap(
                          spacing: 8.0,
                          runSpacing: 20.0,
                          children: [
                            for (var i = 0; i < snapshot.data.length; i++)
                              posterVertical(snapshot.data[i])
                          ],
                        );
                      } else {
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: const Center(
                                child: Text("Sin articulos disponibles")));
                      }
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget posterVertical(Articulo data) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailPage(
            data: data,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.grey.shade100),
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Container(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image(
                      image:
                          Image.network(coverURL + data.articulo_id.toString())
                              .image,
                      fit: BoxFit.cover,
                      loadingBuilder: UtilsCore.loader,
                      errorBuilder: UtilsCore.errorBuilderImage,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(80, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0),
                          Color.fromARGB(80, 0, 0, 0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 4),
              height: 100,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                data.titulo,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
