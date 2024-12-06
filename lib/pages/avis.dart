import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ligueypro/constants/constants.dart'; // Ensure this file exists
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AvisSuggestionPage(),
    );
  }
}

class AvisSuggestionPage extends StatelessWidget {
  // Fonction pour lancer WhatsApp
  final String phoneNumber = ownerContact;
  final String message = appChatWhatsapp;

  void openWhatsApp() async {
    final Uri whatsappUri = Uri.parse(
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossible d\'ouvrir WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Avis et Suggestions"),
      ),
      body: ListView(
        children: [
          Center(
            child: SizedBox(
                width: 150,
                height: 100,
                child: Image.asset('assets/images/logo_transparent.png')),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Avis des utilisateurs",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                // Affichage des avis ici
                SizedBox(height: 10),
                Text(avisSuggestion,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18)),
                // Formulaire de suggestions ici
              ],
            ),
          ),
        ],
      ),
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openWhatsApp();
        },
        backgroundColor: Colors.green,
        child: const FaIcon(
          FontAwesomeIcons.whatsapp, // Icône WhatsApp
          color: Colors.white,
        ),
      ),
    );
  }
}
