
import 'package:appli01/pages/aide.dart';
import 'package:appli01/pages/apropos.dart';
import 'package:appli01/pages/charte.dart';
import 'package:appli01/pages/home_page.dart';
import 'package:appli01/pages/login.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
      colorSchemeSeed: const Color(0xFFBB8547)
      ),
      // home: HomePage(),
      initialRoute: '/login',
      routes: {
        '/' : (context) => const HomePage(email: '',),
        '/profile' : (context) => const HomePage(email: '',),
        '/apropos' : (context) => const AproposPage(),
        '/annonce' : (context) => const LoginPage(),
        '/offre' : (context) => const LoginPage(),
        '/charte' : (context) => const ChartePage(),
        '/login' : (context) => const LoginPage(),
        '/aide' : (context) => AidePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

