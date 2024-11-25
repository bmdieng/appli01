import 'package:flutter/material.dart';
import 'package:ligueypro/constants/constants.dart';

class AidePage extends StatefulWidget {
  const AidePage({super.key});

  @override
  State<AidePage> createState() {
    return AidePageState();
  }
}

class AidePageState extends State<AidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Aide et Assistance'), elevation: 18),
        body: ListView(
          children: [
            Center(
              child: SizedBox(
                  width: 150,
                  height: 100,
                  child: Image.asset('assets/images/colab1.png')),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Text(
                  aideAssistance,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ));
  }
}
