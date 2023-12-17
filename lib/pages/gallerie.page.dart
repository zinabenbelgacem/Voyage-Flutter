import 'package:flutter/material.dart';

import 'gallerie-details.page.dart';
import 'home.page.dart';

class GalleriePage extends StatelessWidget {
  final TextEditingController pays = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Gallerie'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            ); // Retour à la page précédente (Home)
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.deepOrangeAccent[50],
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: pays,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.image, color: Colors.lightBlue),
                hintText: "",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
              primary: Colors.lightBlue,
            ),
            onPressed: () {
              String selectedCountry = pays.text;
              onGetGallerieDetails(context, selectedCountry); // Appel de la fonction pour afficher les détails météorologiques.
            },
            child: Text('Chercher', style: TextStyle(fontSize: 22, color: Colors.white)),
          ),
          // Vous pouvez ajouter ici les informations météorologiques une fois qu'elles sont récupérées.
        ],
      ),
    );
  }
  void onGetGallerieDetails(BuildContext context, String selectedCountry) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GallerieDetailsPage(pays: TextEditingController(text: selectedCountry)),
      ),
    );
  }


}
