import 'package:appdoctrina/models/articulo.dart';
import 'package:appdoctrina/services/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfViewPage extends StatefulWidget {
  const PdfViewPage({Key? key, required this.data}) : super(key: key);

  final Articulo data;

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.data.titulo,
          ),
        ),
        body: Container(
            child: const PDF().cachedFromUrl(
          pdfURL + widget.data.articulo_id.toString(),
          maxAgeCacheObject: const Duration(days: 30), //duration of cache
          placeholder: (progress) => Center(
              child: Text(
            '$progress %',
            style: const TextStyle(fontSize: 35),
          )),
          errorWidget: (error) => Center(child: Text(error.toString())),
        )));
  }
}
