import 'package:flutter/material.dart';

class ProfessionalPage extends StatefulWidget{
  const ProfessionalPage({super.key});

 @override
  State<ProfessionalPage> createState() {
    return ProfessionalPageState();
  }
}
class ProfessionalPageState extends State<ProfessionalPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Offre d'emploi pour ouvrier spécialité"), elevation: 18),
      body: ListView()
     );
  }
}