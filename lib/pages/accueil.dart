import 'package:flutter/material.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  
  @override
  State<AccueilPage> createState() {
    return AccueilPageState();
  }
}

class AccueilPageState extends State<AccueilPage>{
  // AccueilPage({super.key});
  Color bg = Colors.white;
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
      backgroundColor: bg,
    );
  }
  

}