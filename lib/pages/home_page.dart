import 'package:ligueypro/constants/constants.dart';
import 'package:ligueypro/pages/accueil.dart';
import 'package:ligueypro/pages/aide.dart';
import 'package:ligueypro/pages/apropos.dart';
import 'package:ligueypro/pages/charte.dart';
import 'package:flutter/material.dart';

/*
*  Stateful widget prend en charge les événements comme les cliques
*/
class HomePage extends StatefulWidget{
  final String? email;

  const HomePage({super.key, required this.email });
 
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

// Widgets for each segment's content
class Segment1Content extends StatelessWidget {
  const Segment1Content({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Content for Segment 1'),
    );
  }
}

class Segment2Content extends StatelessWidget {
  const Segment2Content({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Content for Segment 2'),
    );
  }
}


class HomePageState extends State<HomePage>{
  int counter = 0;
  int pageIndex = 0;
  final pages = [
    const AccueilPage(),
    const AproposPage(),
    const ChartePage(),
    const AidePage()
  ];

  @override
  Widget build(BuildContext context) {
    int page = 0; 
  
   return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 241, 234, 226), // const Color(0xFF24353F), // Theme.of(context).colorScheme.inversePrimary,
      foregroundColor: const Color(0xFF24353F),
      title: Image.asset("assets/images/logo_transparent.png", height: 65, width: 300,), 
      elevation: 12,
      actions: [
        IconButton(onPressed: (){

        }, 
        icon: const Icon(Icons.search)
        ),
        IconButton(onPressed: (){

        }, 
        icon: const Icon(Icons.notifications)
        ),
      ]
    ),
    body: pages[pageIndex],
    drawer: Theme(data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
          primaryColor: Colors.transparent,
        ), 
      child: Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset('assets/images/logo_transparent.png', width: 400, height: 200,),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              trailing: const Icon(Icons.chevron_right_rounded),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_document),
              trailing: const Icon(Icons.chevron_right_rounded),
              title: const Text('Poster offre de livraison'),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/offre');
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_document),
              trailing: const Icon(Icons.chevron_right_rounded),
              title: const Text('Publier une annonce'),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/annonce');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              trailing: const Icon(Icons.chevron_right_rounded),
              title: const Text('A Propos'),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/apropos');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              trailing: const Icon(Icons.chevron_right_rounded),
              title: const Text('Aide'),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/aide');
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_present),
              trailing: const Icon(Icons.chevron_right_rounded),
              title: const Text('Charte'),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/charte');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              trailing: const Icon(Icons.chevron_right_rounded),
              title: const Text('Se Déconnecter'),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/login');
              },
            ),
            const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                verticalDirection: VerticalDirection.down, 
                children: [
                  SizedBox(height: 230),
                  Text("Version $appVersion  ", 
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:  Color(0xFFBB8547), )
                  )
                ],
              ),
        ],
      ),
    ),
    ),
    bottomNavigationBar: Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
          color: Color(0xFF24353F), 
          width: 0.3
        )
        ),
        
      ),
      child: NavigationBar(
      backgroundColor: Colors.white,
      selectedIndex: pageIndex,
      onDestinationSelected: (int index){
        setState(() {
          pageIndex = index;
        });
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Accueil'),
        NavigationDestination(icon: Icon(Icons.info_sharp), label: 'A propos'),
        NavigationDestination(icon: Icon(Icons.note_alt_rounded), label: 'Charte'),
        NavigationDestination(icon: Icon(Icons.help), label: 'Aide')
      ]
      ),
    )
   );
  }
}
