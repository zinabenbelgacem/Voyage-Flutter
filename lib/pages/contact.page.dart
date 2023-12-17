import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import '../model/contact.model.dart';
import '../services/contact.service.dart';
import 'ajout_modif_contact.page.dart';
import 'home.page.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ContactService contactService = ContactService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Contact'),
        actions: [
          // Aucun bouton ici, car le bouton "Ajouter" est maintenant dans le corps de la page
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Aucun bouton ici, car le bouton "Ajouter" est maintenant dans le corps de la page
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Alignement vertical en haut
          crossAxisAlignment: CrossAxisAlignment.end, // Alignement horizontal à droite
          children: [
            ElevatedButton(
              onPressed: () {
                // Logique du bouton "Ajouter" ici
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AjoutModifContactPage(),
                  ),
                ).then((value) {
                  // Mettez à jour l'état si nécessaire après le retour de la page AjoutModifContactPage
                  setState(() {
                    // Code de mise à jour ici
                  });
                });
              },
              child: Text('Ajouter'),
            ),
            SizedBox(height: 16.0), // Espace entre le bouton et le tableau (ajustez selon vos besoins)
            fetchData(), // Affichage du tableau
          ],
        ),
      ),
    );
  }

  fetchData() {
    return FutureBuilder<List<Contact>>(
      future: contactService.listeContacts(),
      builder: (BuildContext context, AsyncSnapshot<List<Contact>> contacts) {
        if (contacts.hasData) {
          return buildDataTable(contacts.data!);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  buildDataTable(List<Contact> listContacts) {
    return ListUtils.buildDataTable(
      context,
      ["Nom", "Téléphone", "Action"],
      ["nom", "tel", ""],
      false,
      0,
      listContacts,
          (Contact c) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AjoutModifContactPage(
                  modifMode: true,
                  contact: c,
                ),
              ),
            ).then((value) {
              setState(() {
                // Code de mise à jour ici
              });
            });

          },
          (Contact c) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Supprimer Contact"),
                  content: const Text("Êtes-vous sûr de vouloir supprimer ce contact?"),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FormHelper.submitButton(
                          "Oui",
                              () {
                            contactService.supprimerContact(c).then((value) {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            });
                          },
                          width: 100,
                          borderRadius: 5,
                          btnColor: Colors.green,
                          borderColor: Colors.green,
                        ),
                        const SizedBox(width: 20),
                        FormHelper.submitButton(
                          "Non",
                              () {
                            Navigator.of(context).pop();
                          },
                          width: 100,
                          borderRadius: 5,
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
      // ... (autres paramètres de la fonction buildDataTable)

      headingRowColor: Colors.orangeAccent,
      isScrollable: true,
      columnTextFontSize: 20,
      columnTextBold: false,
      columnSpacing: 20,
      onSort: (columnIndex, columnName, asc) {
        // Mettez ici le code pour trier les contacts
      },
    );
  }
}
