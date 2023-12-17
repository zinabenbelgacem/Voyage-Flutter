import 'package:flutter/material.dart';
import 'home.page.dart';
import 'meteo-details.page.dart';


class MeteoPage extends StatelessWidget {
  final TextEditingController pays = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Météo'),
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
                prefixIcon: Icon(Icons.account_balance_rounded, color: Colors.lightBlue),
                hintText: "Saisir un pays",
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
              onGetMeteoDetails(context, selectedCountry); // Appel de la fonction pour afficher les détails météorologiques.
            },
            child: Text('Rechercher', style: TextStyle(fontSize: 22, color: Colors.white)),
          ),
          // Vous pouvez ajouter ici les informations météorologiques une fois qu'elles sont récupérées.
        ],
      ),
    );
  }

  void onGetMeteoDetails(BuildContext context, String selectedCountry) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeteoDetailsPage(selectedCountry),
      ),
    );
    pays.text = ""; // Efface le champ de saisie après la recherche.
  }
}
