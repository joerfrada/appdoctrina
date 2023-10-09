// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_returning_null_for_void, non_constant_identifier_names

import 'dart:convert';
import 'package:appdoctrina/models/articulo.dart';
import 'package:appdoctrina/pages/pdf.dart';
import 'package:appdoctrina/services/api.dart';
import 'package:appdoctrina/values/colors.dart';
import 'package:appdoctrina/views/videoview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.data});

  final Articulo data;

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  double rating = 0;
  List keys = [];
  bool loadingrating = false;

  loadVideo(BuildContext context, Articulo data) {
    print(data.ruta_video);
    if (data.ruta_video == "N/A") {
      showDialog(
        context: context,
        builder: (BuildContext context) => MensajeDialog(context),
      );
    } else {
      setState(() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoView(data: data),
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    keys = jsonDecode(widget.data.keywords) as List;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/background-login.png"),
                            fit: BoxFit.cover),
                      ),
                      padding: const EdgeInsets.only(top: 80, bottom: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(
                                      0, 6), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 320,
                                width: 200,
                                child: Image(
                                  image: Image.network(coverURL +
                                          widget.data.articulo_id.toString())
                                      .image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              widget.data.titulo,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 22),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              widget.data.subtitulo,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w100),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios,
                          size: 20, color: Colors.white),
                    ),
                  ),
                  const Positioned(
                    top: 20,
                    right: 20,
                    child: Icon(Icons.star, size: 20, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF02244a),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewPage(data: widget.data),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.article,
                                      color: Colors.white, size: 18),
                                  Text(" Leer",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12))
                                ],
                              ),
                            ),
                          ),
                          // Container(color: Colors.white, width: 1),
                          // Expanded(
                          //   child: GestureDetector(
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Icon(Icons.podcasts,
                          //             color: Colors.white, size: 18),
                          //         Text(" Escuchar",
                          //             style: TextStyle(
                          //                 color: Colors.white, fontSize: 12))
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Container(color: Colors.white, width: 1),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => loadVideo(context, widget.data),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.play_circle,
                                      color: Colors.white, size: 18),
                                  Text(" Video",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                margin: const EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Calificar este documento'),
                            content: Container(
                              height: 100,
                              child:
                                  RatingBar.builder(itemBuilder: (context, _) {
                                return const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                );
                              }, onRatingUpdate: (rating) {
                                setState(() => rating = rating);
                              }),
                            ),
                            actions: <Widget>[
                              OutlinedButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              OutlinedButton(
                                child: const Text('Enviar'),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        child: const Column(
                          children: [
                            Text("Calificación",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black)),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.black,
                                  size: 12,
                                ),
                                Text("0",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("Páginas",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                          const SizedBox(height: 4),
                          Text(widget.data.num_pagina.toString() + " Pag",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("Audio",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                          const SizedBox(height: 4),
                          Text(widget.data.audiol,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("Video",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                          const SizedBox(height: 4),
                          Text(widget.data.videol,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: const Text(
                  "Acerca de",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  widget.data.descripcion,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                PdfViewPage(data: widget.data),
                          ),
                        ),
                        icon: const Icon(Icons.download, size: 18),
                        label: const Text("Descargar"),
                      ),
                    ),
                    Container(
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(MyColors.azulclaro)),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Reportar Documento'),
                            content: Container(
                              child: const TextField(
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                minLines: 1,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Escribe tu reporte aquí',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              OutlinedButton(
                                child: const Text('Cancelar'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              OutlinedButton(
                                child: const Text('Reportar'),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        icon: const Icon(Icons.flag,
                            size: 18, color: Colors.white),
                        label: const Text(
                          "Reportar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: const Text(
                  "Etiquetas",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Wrap(
                spacing: 6.0,
                runSpacing: 0.0,
                alignment: WrapAlignment.center,
                children: [
                  for (var i = 0; i < keys.length; i++)
                    ActionChip(
                      label: Text(keys[i]),
                    ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: const Text(
                  "Versión",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: const Text(
                  "16 de Noviembre 2021 Actualizado.",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xffdddddd)))),
                margin: const EdgeInsets.only(top: 50, bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: const Text(
                  "Contenido de Editorial Ficticia Copyright 2012, prohibido su reproducción parcial o total de este documento.",
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget MensajeDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Advertencia'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("No hay video."),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
