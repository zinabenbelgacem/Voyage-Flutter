import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Menu/drawer.widget.dart';
import '../Menu/home.widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('Page Home'), backgroundColor: Colors.blue),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: Text("Utilisateur: ${user?.email}", style: TextStyle(fontSize: 13)),
          ),
          Center(
            child: MyHome(), // Appel de MyHome ici
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _deconnexion(context);
        },
        child: Icon(Icons.logout),
      ),
    );
  }

  Future<void> _deconnexion(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, '/authentification', (route) => false);
  }
}
