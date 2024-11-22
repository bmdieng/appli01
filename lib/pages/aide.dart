import 'package:flutter/material.dart';

class AidePage extends StatefulWidget{
  const AidePage({super.key});

 @override
  State<AidePage> createState() {
    return AidePageState();
  }
}
class AidePageState extends State<AidePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aide et Assistance'), elevation: 18),
      body: ListView()
     );
  }
}