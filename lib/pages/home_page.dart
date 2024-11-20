import 'package:flutter/material.dart';
import 'package:ligueypro/constants/constants.dart';
import 'package:ligueypro/pages/dashboard.dart';
import 'package:ligueypro/pages/aide.dart';
import 'package:ligueypro/pages/apropos.dart';
import 'package:ligueypro/pages/charte.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int pageIndex = 0;
  late final TabController tabController;

  final List<Widget> _pages = const [
    AccueilPage(),
    AproposPage(),
    ChartePage(),
    AidePage(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
  assert(tabController != null, 'tabController non initialisé');
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 241, 234, 226),
      foregroundColor: const Color(0xFF24353F),
      title: Image.asset("assets/images/logo_transparent.png", height: 65, width: 300),
      elevation: 12,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
      ],
      bottom: TabBar(
        controller: tabController, // Assurez-vous que cette ligne est bien après `initState`.
        tabs: const [
          Tab(icon: Icon(Icons.directions_car)),
          Tab(icon: Icon(Icons.directions_transit)),
          Tab(icon: Icon(Icons.directions_bike)),
        ],
      ),
    ),
    body: TabBarView(
      controller: tabController,
      children: const [
        Icon(Icons.directions_car),
        Icon(Icons.directions_transit),
        Icon(Icons.directions_bike),
      ],
    ),
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
              title: const Text('Rechercher un Professionnel '),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/professionnel');
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_document),
              trailing: const Icon(Icons.chevron_right_rounded),
              title: const Text('Nos Services'),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/services');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              trailing: const Icon(Icons.chevron_right_rounded),
              title: const Text('Publier une Demande'),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/demande');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              trailing: const Icon(Icons.chevron_right_rounded),
              title: const Text('Aide et Assistance'),
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
      )
    
    
    ),
  );
}


  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 241, 234, 226),
      foregroundColor: const Color(0xFF24353F),
      title: Image.asset("assets/images/logo_transparent.png", height: 65, width: 300),
      elevation: 12,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
      ],
      bottom: TabBar(
        controller: tabController,
        tabs: const [
          Tab(icon: Icon(Icons.directions_car)),
          Tab(icon: Icon(Icons.directions_transit)),
          Tab(icon: Icon(Icons.directions_bike)),
        ],
      ),
    );
  }

}