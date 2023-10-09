// ignore_for_file: sized_box_for_whitespace, unnecessary_new, prefer_interpolation_to_compose_strings

import 'dart:math';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
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
                        image: AssetImage("assets/top-news.jpg"),
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
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Center(
                          child: Text(
                            "Noticias de Interés",
                            style: TextStyle(color: Colors.white, fontSize: 25),
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
              child: Column(children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(
                    children: [
                      for (var i = 0; i < 15; i++)
                        _posterVertical("Lorem ipsum the htah dhts")
                    ],
                  ),
                ),
                const SizedBox(height: 50)
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _posterVertical(String title) {
    return Container(
      color: Colors.grey.shade100,
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image(
                image: Image.asset("assets/post/" +
                        (Random().nextInt(4) + 1).toString() +
                        ".jpg")
                    .image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 4),
            width: MediaQuery.of(context).size.width,
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 4),
            margin: const EdgeInsets.only(bottom: 10),
            width: MediaQuery.of(context).size.width,
            child: Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
