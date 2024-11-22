import 'package:flutter/material.dart';

class AnnoncePage extends StatefulWidget{
  const AnnoncePage({super.key});

 @override
  State<AnnoncePage> createState() {
    return AnnoncePageState();
  }
}
class AnnoncePageState extends State<AnnoncePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Proposez vos services en toute simplicité "), elevation: 18),
      body: ListView()
     );
  }
}