import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthentificationPage extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController textLogin = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Page d\'authentification',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.pinkAccent[50],
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: textLogin,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.abc_rounded, color: Colors.pinkAccent),
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
                  prefixIcon: Icon(Icons.password_outlined, color: Colors.pinkAccent),
                  hintText: "Mot de passe",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.black26),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  primary: Colors.pinkAccent,
                ),
                onPressed: () {
                  _authentifier(context);
                },
                child: Text('Connexion', style: TextStyle(fontSize: 22, color: Colors.white)),
              ),
            ),
            Container(
              child: TextButton(
                child: Text('Je n\'ai pas de compte', style: TextStyle(fontSize: 20, color: Colors.black)),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/inscription');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _authentifier(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: textLogin.text.trim(),
        password: textPassword.text.trim(),
      );
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      SnackBar snackBar = SnackBar(content: Text(""));
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        snackBar = SnackBar(
          content: Text('Identifiant ou mot de passe incorrect'),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
