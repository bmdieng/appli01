import 'package:appli01/pages/accueil.dart';
import 'package:appli01/pages/aide.dart';
import 'package:appli01/pages/apropos.dart';
import 'package:appli01/pages/charte.dart';
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


class HomePageState extends State<HomePage>{
  int counter = 0;
  int pageIndex = 0;
  List images = [
        'https://www.lyonresto.com/contenu/photo_restaurant/0_photo_automatique_big/lyon_dakar/Lyon_Dakar_-_12-selection.jpg',
        'https://i0.wp.com/afriseries.com/wp-content/uploads/2021/08/Thiebou-yapp.jpg?fit=1600%2C1067&ssl=1',
        'https://i.ytimg.com/vi/o9v9co-ohWc/maxresdefault.jpg',
        'https://i.ytimg.com/vi/4iXUqwYjzes/sddefault.jpg',
        'https://i0.wp.com/afriseries.com/wp-content/uploads/2021/08/Thiebou-yapp.jpg?fit=1600%2C1067&ssl=1',
  ];

  final pages = [
    const AccueilPage(),
    const AproposPage(),
    const ChartePage(),
    const AidePage()
  ];

  @override
  Widget build(BuildContext context) {
  print(widget.email);
   return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color(0xFF24353F), // Theme.of(context).colorScheme.inversePrimary,
      foregroundColor: const Color(0xFFE0AE7D),
      title: Text('Title : ${widget.email}'), 
      elevation: 12,
      // leading: IconButton(onPressed: (){

      //   }, 
      //   icon: Icon(Icons.menu),
      // ),
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
    drawer: Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              accountName: Text("Momoo DIENG"), 
              accountEmail: Text("momodieng00@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://media.licdn.com/dms/image/v2/D4E03AQFJp2zRCOCPvA/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1718283063562?e=2147483647&v=beta&t=v1Sy5cN3CJCCUS0xsK-dNc2nMRXbgw1VPITQUW66y04'),
                ),
              ),
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
            )
        ],
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
