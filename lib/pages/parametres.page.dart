import 'package:atelier3/config/global.params.dart';
import 'package:flutter/material.dart';
import '../menu/drawer.widget.dart';
import 'package:firebase_database/firebase_database.dart';


String mode = "Jour";
FirebaseDatabase fire = FirebaseDatabase.instance;
DatabaseReference ref = fire.ref();
class ParametersPage extends StatefulWidget {
  @override
  State<ParametersPage> createState() => ParametersPageState();
}

class ParametersPageState extends State<ParametersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Page Paramètres'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Mode', style: TextStyle(fontSize: 20)),
          ListTile(
            title: Text('Jour'),
            leading: Radio(
              value: 'Jour',
              groupValue: mode,
              onChanged: (value) {
                setState(() {
                  mode = value.toString();
                  GlobalParams.themeActuel.setMode(mode);
                });
              },
            ),
          ),
          ListTile(
            title: Text('Nuit'),
            leading: Radio(
              value: 'Nuit',
              groupValue: mode,
              onChanged: (value) {
                setState(() {
                  mode = value.toString();
                  GlobalParams.themeActuel.setMode(mode);
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: onSaveMode,
            child: Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  onSaveMode() async {
    await ref.set({"mode": mode});
    print("Mode changé");
    Navigator.pop(context);
  }
}
