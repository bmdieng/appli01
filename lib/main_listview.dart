import 'package:flutter/material.dart';

void main(){
  // print('Bonjour à tous');
  runApp(MaterialApp(
    // home: HomePage(),
  ));
}

/*
*  Stateful widget prend en charge les événements comme les cliques
*/
class HomePage extends StatefulWidget{
  const HomePage({super.key, required String email});


  @override
  State<HomePage> createState() {
    // TODO: implement createState
    return HomePageState();
  }
  
}


class HomePageState extends State<HomePage>{
  int counter = 0;
  List images = [
        'https://www.lyonresto.com/contenu/photo_restaurant/0_photo_automatique_big/lyon_dakar/Lyon_Dakar_-_12-selection.jpg',
        'https://i0.wp.com/afriseries.com/wp-content/uploads/2021/08/Thiebou-yapp.jpg?fit=1600%2C1067&ssl=1',
        'https://i.ytimg.com/vi/o9v9co-ohWc/maxresdefault.jpg',
        'https://i.ytimg.com/vi/4iXUqwYjzes/sddefault.jpg',
        'https://i0.wp.com/afriseries.com/wp-content/uploads/2021/08/Thiebou-yapp.jpg?fit=1600%2C1067&ssl=1',
  ];

  @override
  Widget build(BuildContext context) {
   
   return Scaffold(
    appBar: AppBar(title: const Text("Digitrest Consulting"), elevation: 12),
    // Utilisation de Container permet de 
    body: ListView.separated(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(5),
          child: Image.network(images[index], width: 400, height: 280)
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
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