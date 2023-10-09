// ignore_for_file: no_leading_underscores_for_local_identifiers, deprecated_member_use, sized_box_for_whitespace, prefer_const_constructors

import 'package:appdoctrina/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

setDataShared(bool b) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('sessionStart', b);
}

class UtilsCore {
  static void launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  static Widget loader(context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Container(
      height: MediaQuery.of(context).size.height / 2.1,
      child: const Center(
        heightFactor: 3,
        child: CircularProgressIndicator(
          color: MyColors.azulclaro,
        ),
      ),
    );
  }

  static Widget generalLoader(context) {
    return Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: MyColors.azulclaro,
        ),
      ),
    );
  }

  static Widget errorBuilderImage(context, error, stackTrace) {
    return Image(image: Image.network("assets/default.jpg").image);
  }
}
