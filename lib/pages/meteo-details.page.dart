import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Importez le package intl pour le formatage de la date et de l'heure.

class MeteoDetailsPage extends StatefulWidget {
  final String ville;

  MeteoDetailsPage(this.ville);

  @override
  _MeteoDetailsPageState createState() => _MeteoDetailsPageState();
}

class _MeteoDetailsPageState extends State<MeteoDetailsPage> {
  var meteoData;

  @override
  void initState() {
    super.initState();
    getMeteoData(widget.ville);
  }

  void getMeteoData(String ville) {
    print("Météo de la ville de " + ville);
    String apiKey = '56de4ad882013baa0a9991afefcfead6';
    String url = "https://api.openweathermap.org/data/2.5/forecast?q=sfax&appid=c109c07bc4df77a88c923e6407aef864";

    http.get(Uri.parse(url)).then((resp) {
      if (resp.statusCode == 200) {
        setState(() {
          meteoData = json.decode(resp.body);
          print(meteoData);/// fi console
        });
      } else {
        print("Erreur de requête: ${resp.statusCode}");
      }
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Meteo Details ${widget.ville}'),
      ),
      body: meteoData == null
          ? Center(
        child: CircularProgressIndicator(), // Affichez une indication de chargement en attendant les données.
      )
          : ListView.builder(
        itemCount: meteoData['list'].length,
        itemBuilder: (context, index) {
          final item = meteoData['list'][index];
          final temperature = item['main']['temp'] - 273.15; // Conversion de Kelvin à Celsius
          final dateTime = DateTime.fromMicrosecondsSinceEpoch(item['dt'] * 1000000);
          final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
          final formattedTime = DateFormat('HH:mm').format(dateTime);

          return Card(
            color: Colors.blue,
            child: Row(   // b row  les mots bejnab baathhom yjiw
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("images/${item['weather'][0]['main'].toString().toLowerCase()}.png"),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(formattedDate, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Text("$formattedTime - ${item['weather'][0]['main']}", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                Text("${temperature.toStringAsFixed(1)}°C"), // Affichez la température avec une décimale.
              ],
            ),
          );
        },
      ),
    );
  }
}
