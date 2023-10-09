// ignore_for_file: avoid_print, unused_local_variable, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'package:appdoctrina/components/componentes.dart';
import 'package:appdoctrina/models/articulo.dart';
import 'package:appdoctrina/models/usuario.dart';
import 'package:appdoctrina/pages/cats.dart';
import 'package:appdoctrina/pages/detail.dart';
import 'package:appdoctrina/pages/download.dart';
import 'package:appdoctrina/pages/search.dart';
import 'package:appdoctrina/services/api.dart';
import 'package:appdoctrina/services/articulos.dart';
import 'package:appdoctrina/values/colors.dart';
import 'package:appdoctrina/views/sidemenu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Usuario usuario = Usuario();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          Usuario user = Usuario();
          Future<Usuario> f_user = user.loadUsuario();
          f_user.then((value) => usuario = value);
        }));
  }

  Future<List<Articulo>> getArticulos() async {
    ArticuloResponse response = await ArticuloService.getArticulos();
    Future<List<Articulo>> arts = Future.value(response.result);
    return arts;
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
      key: _scaffoldKey,
      drawer: SideMenuDrawer(
        user: usuario,
      ),
      body: SafeArea(
          child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            expandedHeight: MediaQuery.of(context).size.height * 0.60,
            flexibleSpace: FlexibleSpaceBar(
              background: FlexibleSpaceBar(
                  background: FutureBuilder(
                      future: fetchArticulos("0", "0", "0", "1", "0"),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  data: snapshot.data[0],
                                ),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Image(
                                    image: Image.network(coverURL +
                                            snapshot.data[0].articulo_id
                                                .toString())
                                        .image,
                                    fit: BoxFit.cover,
                                    loadingBuilder: UtilsCore.loader,
                                    errorBuilder: UtilsCore.errorBuilderImage,
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(220, 0, 0, 0),
                                        Color.fromARGB(180, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0),
                                        Color.fromARGB(180, 0, 0, 0),
                                        Color.fromARGB(225, 0, 0, 0),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    snapshot.data[0].subtitulo,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 11),
                                  ),
                                ),
                                Positioned(
                                  bottom: 70,
                                  left: 20,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Text(
                                    snapshot.data[0].titulo,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Container(
                                    height: 100,
                                    padding: const EdgeInsets.all(10),
                                    child: barProfile()),
                                Positioned(
                                  bottom: 20,
                                  right: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: const Row(
                                      children: [
                                        Text("Ver",
                                            style: TextStyle(
                                                color: MyColors.azul,
                                                fontSize: 15)),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Icon(Icons.visibility)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      })),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(children: <Widget>[
              const SizedBox(height: 10),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              padding: const EdgeInsets.all(4),
                              height: 80,
                              decoration: BoxDecoration(
                                  color: MyColors.azulclaro,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Documentos Leídos",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                    SizedBox(height: 5),
                                    Text("0",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25))
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              padding: const EdgeInsets.all(4),
                              height: 80,
                              decoration: BoxDecoration(
                                  color: MyColors.azulclaro,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Documentos Descargados",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                    SizedBox(height: 5),
                                    Text("0",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25))
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              padding: const EdgeInsets.all(4),
                              height: 80,
                              decoration: BoxDecoration(
                                  color: MyColors.azulclaro,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Calificaciones Hechas",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                    SizedBox(height: 5),
                                    Text("0",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 25))
                                  ]),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              sectionItems("Recomendados",
                  fetchArticulos("0", "0", "1", "0", "0"), true),
              sectionItems(
                  "Públicos", fetchArticulos("15", "1", "0", "0", "0"), false),
              sectionItems(
                  "Manuales", fetchArticulos("3", "1", "0", "0", "0"), false),
              sectionItems("Buenas Prácticas",
                  fetchArticulos("6", "1", "0", "0", "0"), false),
              const SizedBox(height: 50)
            ]),
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.azul,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.roofing), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Buscar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favoritos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Documentos ")
        ],
        selectedItemColor: MyColors.verde,
        unselectedItemColor: Colors.white,
        unselectedIconTheme: const IconThemeData(color: MyColors.verde),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) async {
          if (index == 1) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SearchPage()));
          }
          if (index == 2) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const DownloadPage()));
          }
          if (index == 3) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CatsPage()));
          }
        },
      ),
    );
  }

  Widget barProfile() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          RawMaterialButton(
            constraints: const BoxConstraints(minWidth: 0),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            child: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 35,
            ),
          ),
          Expanded(
              child: Center(
            child: Container(
              width: 100,
              child: Image.asset(
                'assets/logo.png',
                alignment: Alignment.centerLeft,
              ),
            ),
          )),
          Container(
            width: 35,
            child: ClipOval(
              child: Image(image: Image.asset("assets/avatar.jpg").image),
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionItems(title, Future articles, bool fs) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: fs ? 20 : 50,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/damero.png"), fit: BoxFit.cover),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 300,
            width: double.infinity,
            child: FutureBuilder(
                future: articles,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return posterVertical(snapshot.data[index]);
                        },
                      );
                    } else {
                      return const Center(
                          child: Text("Sin articulos disponibles"));
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
                }),
          ),
        ],
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
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
        width: 150,
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
              height: 70,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                data.titulo,
                style: const TextStyle(color: Colors.black, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
