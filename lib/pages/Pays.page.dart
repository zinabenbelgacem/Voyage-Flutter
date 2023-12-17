import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.page.dart';

class PaysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pays'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                builder: (context) => HomePage()
                ));// Retour à la page précédente (Home)
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Informations sur les pays',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Ajoutez ici des informations sur les pays
          ],
        ),
      ),
    );
  }
}
