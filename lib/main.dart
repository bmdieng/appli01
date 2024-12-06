import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ligueypro/pages/aide.dart';
import 'package:ligueypro/pages/annonce.dart';
import 'package:ligueypro/pages/apropos.dart';
import 'package:ligueypro/pages/avis.dart';
import 'package:ligueypro/pages/charte.dart';
import 'package:ligueypro/pages/geoloc.dart';
import 'package:ligueypro/pages/home_page.dart';
import 'package:ligueypro/pages/login.dart';
import 'package:ligueypro/pages/professionnel.dart';
import 'package:ligueypro/pages/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ligueypro/pages/register.dart';
import 'package:ligueypro/pages/reset_password.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      theme:
          ThemeData(colorSchemeSeed: const Color.fromARGB(255, 241, 234, 226)),
      // home: HomePage(),
      initialRoute: user == null ? '/' : '/home',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/register': (context) => const RegisterPage(),
        '/profile': (context) => const ProfilePage(),
        '/apropos': (context) => const AproposPage(),
        '/annonce': (context) => const AnnoncePage(),
        '/offre': (context) => const ProfessionalPage(),
        '/charte': (context) => const ChartePage(),
        '/aide': (context) => const AidePage(),
        '/reset_password': (context) => const ResetPasswordPage(),
        '/avis': (context) => AvisSuggestionPage(),
        '/geoloc': (context) => MapScreen()
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('fr'), // Francais
      ],
    );
  }
}
