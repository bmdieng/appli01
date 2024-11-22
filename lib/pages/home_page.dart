import 'package:flutter/material.dart';
import 'package:ligueypro/constants/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int pageIndex = 0;
  late final TabController tabController;
  String profile = "recruteur";

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  assert(tabController != null, '');
  return Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 241, 234, 226),
      foregroundColor: const Color(0xFF24353F),
      title: Image.asset("assets/images/logo_transparent.png", height: 55, width: 300),
      elevation: 12,
      actions: [
        // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
      ],
      bottom: TabBar(
        controller: tabController, // Assurez-vous que cette ligne est bien après `initState`.
        tabs: const [
          Text("Suivi Offres d’Emploi", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFBB8547)
                ), 
                textAlign: TextAlign.center
              ),
          Text("Suivi de Candidatures ", style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFBB8547)
                ), 
                textAlign: TextAlign.center
              ),
        ],
      ),
    ),
    body: TabBarView(
      controller: tabController,
      children: [
            // Tab 1 Content
            SingleChildScrollView(
              child: Column(
                children: List.generate(
                  30,
                  growable: true,
                  (index) => 
                      ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                        // side:const BorderSide(color: Color(0xFFBB8547), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                        leading:  CircleAvatar(
                        backgroundImage: profile == 'administrateur' ? const AssetImage('assets/images/colab1.png') : const AssetImage('assets/images/colab2.png'),
                          ),
                          title: const Text('Administrateur ®'),
                          subtitle: const Text("Je suis à la recherche d'un electricien sur Mariste \nDate publication: 21-nov-2024 12h30"),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            print('ListTile tapped');
                          }, 
                        ),
                      ),
                  ),
              ),
            // Tab 2 Content
            SingleChildScrollView(
              child: Column(
                children: List.generate(
                  30,
                  (index) => ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/engineer.png'),
                            ),
                            title: const Text('Abdou DIOP '),
                            subtitle: const Text("Plombier professionnel\nDate publication: 21-nov-2024 12h30"),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              print('ListTile tapped');
                            },
                        ),
                ),
              ),
            ),
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
              leading: const Icon(Icons.home, color: Color(0xFFBB8547),),
              title: const Text('Accueil', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color:  Color(0xFFBB8547))),
              trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFBB8547),),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Color(0xFFBB8547),),
              trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFBB8547),),
              title: const Text('Profile', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color:  Color(0xFFBB8547))),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_document, color: Color(0xFFBB8547),),
              trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFBB8547),),
              title: const Text('Poster Offres d’Emploi ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color:  Color(0xFFBB8547))),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/offre');
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit_note_rounded, color: Color(0xFFBB8547),),
              trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFBB8547),),
              title: const Text('Proposer mes services', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color:  Color(0xFFBB8547))),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/annonce');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle, color: Color(0xFFBB8547),),
              trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFBB8547),),
              title: const Text('Nos Services', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color:  Color(0xFFBB8547))),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/services');
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.help, color: Color(0xFFBB8547),),
              trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFBB8547),),
              title: const Text('Aide et Assistance', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color:  Color(0xFFBB8547))),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/aide');
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_present, color: Color(0xFFBB8547),),
              trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFBB8547),),
              title: const Text('Charte', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color:  Color(0xFFBB8547))),
              onTap: () {
                Navigator.pushNamed(
                  context, 
                  '/charte');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFFBB8547),),
              trailing: const Icon(Icons.chevron_right_rounded, color: Color(0xFFBB8547),),
              title: const Text('Se Déconnecter', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color:  Color(0xFFBB8547))),
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
}