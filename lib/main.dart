
import 'package:flutter/material.dart';
import 'package:ligueypro/pages/aide.dart';
import 'package:ligueypro/pages/apropos.dart';
import 'package:ligueypro/pages/charte.dart';
import 'package:ligueypro/pages/home_page.dart';
import 'package:ligueypro/pages/login.dart';
import 'package:ligueypro/pages/profile.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
      colorSchemeSeed: const Color.fromARGB(255, 241, 234, 226)
      ),
      // home: HomePage(),
      initialRoute: '/login',
      routes: {
        '/' : (context) => const HomePage(email: '',),
        '/profile' : (context) => ProfilePage(),
        '/apropos' : (context) => const AproposPage(),
        '/annonce' : (context) => const LoginPage(),
        '/offre' : (context) => const LoginPage(),
        '/charte' : (context) => const ChartePage(),
        '/login' : (context) => const LoginPage(),
        '/aide' : (context) => const AidePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

