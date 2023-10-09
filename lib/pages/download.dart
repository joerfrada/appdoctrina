// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<StatefulWidget> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerRight,
          child: const Text(
            "12 elementos descargados",
            style: TextStyle(fontSize: 12),
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        // child: ListView(
        //   children: [
        //     for (var i = 0; i < 5; i++)
        //       Card(
        //         child: ListTile(
        //           leading: i == 1
        //               ? Icon(Icons.play_circle, size: 50)
        //               : i == 2
        //                   ? Icon(Icons.podcasts, size: 50)
        //                   : Icon(Icons.picture_as_pdf, size: 50),
        //           title: Text('Documento ' + i.toString()),
        //           subtitle: Text('Curabitur imperdiet convallis nisl, sed consequat enim finibus'),
        //           trailing: GestureDetector(
        //             onTap: () => null,
        //             child: Icon(Icons.delete),
        //           ),
        //           isThreeLine: true,
        //         ),
        //       ),
        //   ],
        // ),
        child: const Center(
          child: Text("Sin descargas"),
        ),
      ),
    );
  }
}
