import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/global.params.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    late SharedPreferences prefs;
    return Drawer(
        child: ListView(
          children: [
            DrawerHeader(decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.white, Colors.blue])),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("images/profil.jpg"),
                    radius: 80,
                  ),
                )),

            ...(GlobalParams.menus as List).map((item) {
              return Column(
                children: [
                  ListTile(
                  title: Text(
                    '${item['title']}', style: TextStyle(fontSize: 22),),
                  leading: item['icon'],
                  trailing: Icon(Icons.arrow_right, color: Colors.blue,),
                  onTap: () async {
                    if ('${item[ 'title']}' != "Déconnexion") {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "${item [ 'route']}");
                    }
                    else {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/authentification', (route) => false);
                    }
                  },
                ),
                  Divider(height: 4, color: Colors.blue)
                ],
              );
            })
          ],
        ));

  }}
