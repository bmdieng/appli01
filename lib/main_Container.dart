import 'package:flutter/material.dart';

void main(){
  // print('Bonjour à tous');
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

/*
*  Stateful widget prend en charge les événements comme les cliques
*/
class HomePage extends StatefulWidget{
  const HomePage({super.key});


  @override
  State<HomePage> createState() {
    // TODO: implement createState
    return HomePageState();
  }
  
}


class HomePageState extends State<HomePage>{
  int counter = 0;

  @override
  Widget build(BuildContext context) {
   
   return Scaffold(
    appBar: AppBar(title: const Text("Digitrest Consulting"), elevation: 12),
    // Utilisation de Container permet de 
    body: Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      height: 200,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Text('Bienvenue sur Digitrest Consulting $counter')),
      floatingActionButton: FloatingActionButton(
      onPressed: (){
        // Demande à DART de raffraichir l'interface utilisateur 
        setState(() {
          counter += 1;
        });
      },
      child: const Icon(Icons.add),
      ),
   );
  }
}


/*
*  Stateless widget ne prend pas en charge les événements comme les cliques
*  utilisé à la place Stateful widget
*/

// class HomePage extends StatelessWidget{
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
   
//    return Scaffold(
//     appBar: AppBar(title: Text("Digitrest Consulting"), elevation: 12),
//     body: Center(child: Text('Bienvenue sur Digitrest Consulting')),
//     floatingActionButton: FloatingActionButton(
//       onPressed: (){},
//       child: const Icon(Icons.add),
//       ),
//    );
//   }
// }