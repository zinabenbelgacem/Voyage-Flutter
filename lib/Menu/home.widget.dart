import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/global.params.dart';

class MyHome extends StatelessWidget {
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: (GlobalParams.accueil as List).map((item) {
        return ListTile(
            title: Center(
            child: Image.asset(
            item['Image'] ?? '', // Utilisez le chemin de l'image
            width: 100, // Largeur de l'image (ajustez selon vos besoins)
        ),
            ),
          onTap: () async {
            if (item['title'] != "Déconnexion") {
              Navigator.pop(context);
              Navigator.pushNamed(context, item['route'] ?? "/");
            } else {
              prefs = await SharedPreferences.getInstance();
              prefs.setBool("connecte", false);
              Navigator.pushNamedAndRemoveUntil(
                  context, '/authentification', (route) => false);
            }
          },
        );
      }).toList(),
    );
  }
}
