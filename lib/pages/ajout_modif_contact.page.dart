import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../model/contact.model.dart';
import '../services/contact.service.dart';

class AjoutModifContactPage extends StatefulWidget {
  final Contact? contact;
  final bool modifMode;

  AjoutModifContactPage({this.contact, this.modifMode = false});

  @override
  _AjoutModifContactPageState createState() => _AjoutModifContactPageState();
}

class _AjoutModifContactPageState extends State<AjoutModifContactPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ContactService contactService = ContactService();
  Contact _contact = Contact();

  // Contrôleurs pour les champs de formulaire
  TextEditingController _nomController = TextEditingController();
  TextEditingController _telController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialisez _contact avec les valeurs du contact existant lors de la modification
    if (widget.modifMode && widget.contact != null) {
      _contact = widget.contact!;
      // Initialisez les contrôleurs avec les valeurs existantes
      _nomController.text = _contact.nom ?? "";
      _telController.text = _contact.tel.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.modifMode
            ? 'Page Modifier Contact'
            : ' Page Ajouter Contact'),
      ),
      body: Form(
        key: _formKey,
        child: formUI(),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FormHelper.submitButton(
              widget.modifMode ? "Modifier" : "Ajouter",
                  () {
                if (validateAndSave()) {
                  if (widget.modifMode) {
                    contactService.modifierContact(_contact).then((value) {
                      Navigator.pop(context);
                    });
                  } else {
                    contactService.ajouterContact(_contact).then((value) {
                      Navigator.pop(context);
                    });
                  }
                }
              },
            ),
            FormHelper.submitButton(
              'Annuler',
                  () {
                Navigator.pop(context);
              },
              borderRadius: 10,
              btnColor: Colors.grey,
              borderColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      return true;
    }
    return false;
  }

  Widget formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "Nom",
              "Entrez le nom",
              _nomController.text,
                  (value) {
                if (value.isEmpty) {
                  return "Required";
                }
                return null;
              },
                  (value) {
                _nomController.text = value.toString().trim();
                _contact.nom = _nomController.text;
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.text_fields),
              borderRadius: 10,
              contentPadding: 15,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              prefixIconPaddingLeft: 10,
            ),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "Téléphone",
              "Entrez le numéro de téléphone",
              _telController.text,
                  (value) {
                if (value.isEmpty) {
                  return "Required";
                }
                return null;
              },
                  (value) {
                _telController.text = value.toString().trim();
                _contact.tel = int.tryParse(_telController.text) ?? 0;
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.phone),
              borderRadius: 10,
              contentPadding: 15,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              prefixIconPaddingLeft: 10,
              isNumeric: true,
            ),
            // Ajoutez d'autres champs de formulaire selon vos besoins
          ],
        ),
      ),
    );
  }
}
