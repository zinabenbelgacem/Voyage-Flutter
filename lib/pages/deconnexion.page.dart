import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeconnexionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Déconnexion'),
        backgroundColor: Colors.indigo,
    leading: IconButton(
    icon: Icon(Icons.arrow_back), // Icône de la flèche de retour
    onPressed: () {
      Navigator.pop(context); // Retour à la page précédente (Home)

    }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Êtes-vous sûr de vouloir vous déconnecter ?',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () async {
                // Effectuez les opérations de déconnexion ici
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('connecte', false);

                // Redirigez l'utilisateur vers la page d'authentification
                Navigator.pushReplacementNamed(context, '/authentification');
              },
              child: Text('Déconnexion'),
            ),
          ],
        ),
      ),
    );
  }
}
