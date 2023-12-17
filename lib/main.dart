import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'config/global.params.dart';
import 'firebase_options.dart';
import 'pages/authentification.page.dart';
import 'pages/contact.page.dart';
import 'pages/deconnexion.page.dart';
import 'pages/gallerie.page.dart';
import 'pages/home.page.dart';
import 'pages/inscription.page.dart';
import 'pages/meteo.page.dart';
import 'pages/parametres.page.dart';
import 'pages/pays.page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GlobalParams.themeActuel.setMode(await getInitialMode());

  runApp(MyApp());
}

Future<String> getInitialMode() async {
  final snapshot = await FirebaseDatabase.instance.reference().child('mode').get();
  if (snapshot.exists) {
    return snapshot.value.toString();
  } else {
    return 'Jour';
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomePage(),
        '/inscription': (context) => InscriptionPage(),
        '/authentification': (context) => AuthentificationPage(),
        '/contact': (context) => ContactPage(),
        '/gallerie': (context) => GalleriePage(),
        '/deconnexion': (context) => DeconnexionPage(),
        '/meteo': (context) => MeteoPage(),
        '/parametres': (context) => ParametersPage(),
        '/pays': (context) => PaysPage(),
      },
      theme: GlobalParams.themeActuel.getTheme(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return AuthentificationPage();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    GlobalParams.themeActuel.addListener(() {
      setState(() {});
    });
  }
}
