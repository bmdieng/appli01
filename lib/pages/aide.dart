import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AidePage extends StatefulWidget{
  const AidePage({super.key});


 @override
  State<AidePage> createState() {
    return AidePageState();
  }
  
}




class AidePageState extends State<AidePage>{

  final dio = Dio();
  List countrieList = [];

  @override
  Widget build(BuildContext context) {
    getCountries();
    return Scaffold(
      appBar: AppBar(title: const Text("Digitrest Consulting"), elevation: 18),
      body: ListView.builder(
        itemCount: countrieList.length,
        itemBuilder: (context, index) {
          return ListTile( 
            leading: Text(countrieList[index]['flag'], style: const TextStyle(fontSize: 25)),
            title: Text(countrieList[index]['name']['common']),
            subtitle: Text(countrieList[index]['capital'][0]),
            onTap: (){
              print('-------- CHOIX DU PAYS ${countrieList[index]['name']['common']} --------');
              Navigator.pop(context);
            },
          );
        },
     )
  );
}

void getCountries() async {
  final response = await dio.get('https://restcountries.com/v3.1/all');
     setState(() {
       countrieList = response.data;
     });
  }
}