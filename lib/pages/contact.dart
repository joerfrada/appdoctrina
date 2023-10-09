// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, sort_child_properties_last

import 'package:appdoctrina/views/webview.dart';
import 'package:appdoctrina/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<StatefulWidget> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with TickerProviderStateMixin {
  double rating = 0;

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/top-contact.jpg"),
                          fit: BoxFit.cover),
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      padding: const EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      curve: Curves.fastOutSlowIn,
                      child: const Text(
                        "¿Te ayudamos?",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 15,
                          ),
                          Text(
                            "Volver",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: GestureDetector(
                          onTap: () => _launchURL("tel:123"),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: MyColors.azul,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.phone,
                                    color: Colors.white, size: 40),
                                SizedBox(height: 10),
                                Text(
                                  "Linea Atención\n123",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: GestureDetector(
                          onTap: () =>
                              _launchURL("mailto:lineadirecta@policia.gov.co"),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: MyColors.azul,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.mail, color: Colors.white, size: 40),
                                SizedBox(height: 10),
                                Text(
                                  "Correo\nLinea Directa",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const WebViewPage(
                                      url: "https://www.policia.gov.co"))),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                                color: MyColors.azul,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.language,
                                    color: Colors.white, size: 40),
                                SizedBox(height: 10),
                                Text(
                                  "Página Web\npolicia.gov.co",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Container(
                child: const Text("Califica nuestro servicio",
                    style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Estimado usuario, agradecemos calificar la plataforma, con el fin de mejorar nuestro servicio y así poder cumplir con las expectativas.",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                child: RatingBar.builder(itemBuilder: (context, _) {
                  return const Icon(
                    Icons.star,
                    color: Colors.amber,
                  );
                }, onRatingUpdate: (rating) {
                  setState(() => rating = rating);
                }),
              ),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Mantente actualizado con\nnuestras redes sociales",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                      onPressed: () => _launchURL(
                          "https://www.facebook.com/Policianacionaldeloscolombianos"),
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: SizedBox(
                          child: Image.asset("assets/social/facebook.png"),
                          width: 40),
                      padding: const EdgeInsets.all(15.0),
                      shape: const CircleBorder(),
                    ),
                    RawMaterialButton(
                      onPressed: () => _launchURL(
                          "https://www.instagram.com/policiadecolombia"),
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: SizedBox(
                          child: Image.asset("assets/social/instagram.png"),
                          width: 40),
                      padding: const EdgeInsets.all(15.0),
                      shape: const CircleBorder(),
                    ),
                    RawMaterialButton(
                      onPressed: () =>
                          _launchURL("whatsapp://send?phone=+573000000000"),
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: SizedBox(
                          child: Image.asset("assets/social/whatsapp.png"),
                          width: 40),
                      padding: const EdgeInsets.all(15.0),
                      shape: const CircleBorder(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
