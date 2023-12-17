import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InscriptionPage extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController textLogin = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Page d\'inscription',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.deepOrangeAccent[50],
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: textLogin,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.deepOrangeAccent),
                hintText: "Identifiant",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: textPassword,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(
                    Icons.password_outlined, color: Colors.deepOrangeAccent),
                hintText: "Mot de passe",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.black26),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                primary: Colors.deepOrangeAccent,
              ),
              onPressed: () {
                _onInscrire(context);
              },
              child: Text(
                'Inscription',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
          ),
          Container(
            child: TextButton(
              child: Text(
                'J\'ai déjà un compte',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/authentification');
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onInscrire(BuildContext context) async {
    if (textLogin.text.isNotEmpty && textPassword.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: textLogin.text.trim(),
          password: textPassword.text.trim(),
        );
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.code == 'weak-password'
                  ? 'Mot de passe faible'
                  : e.code == 'email-already-in-use'
                  ? 'Email déjà existant'
                  : 'Erreur lors de l\'inscription',
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Identifiant ou mot de passe vides'),
        ),
      );
    }
  }
}