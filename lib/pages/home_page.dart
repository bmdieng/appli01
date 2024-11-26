import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ligueypro/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int pageIndex = 0;
  late final TabController tabController;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  Map<dynamic, dynamic> userData = {};
  String name = '';
  String profile = '';
  String call = '';
  String email = '';
  String address = '';
  String date = '';
  String description = '';
  String search_Offer = '';
  List<dynamic> _offerList = [];

  @override
  void initState() {
    super.initState();
    // User? user = FirebaseAuth.instance.currentUser;
    _fetchOfferData();
    tabController = TabController(length: 2, vsync: this);
  }

  void _fetchOfferData() {
    _database.child('offres_emploi').onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      // Get the current date and time, and subtract 30 days from it
      DateTime now = DateTime.now();
      DateTime thirtyDaysAgo = now.subtract(Duration(days: 30));

      // Convert to timestamp for comparison
      int timestamp = thirtyDaysAgo.millisecondsSinceEpoch;
      DateFormat dateFormat = DateFormat("dd-MMM-yyyy HH:mm");
      if (data != null) {
        // Convert the data into a List
        setState(() {
          data.forEach((key, value) {
            // Parse the string into a DateTime object
            DateTime parsedDate = dateFormat.parse(value['date_pub']);

            // Convert the DateTime to a timestamp (milliseconds since epoch)
            int timestampDatePub = parsedDate.millisecondsSinceEpoch;
            if (timestampDatePub != null && timestampDatePub >= timestamp) {
              _offerList.add(value);
            }
          });
          // print('****************** $_offerList');
          _offerList.sort((a, b) {
            String timestampA = a['date_pub']; // Assuming date is a timestamp
            String timestampB = b['date_pub'];
            return timestampB.compareTo(timestampA); // For descending order
          });
        });
      } else {}
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _fetchUserData(user!);
    assert(tabController != null, '');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 234, 226),
        foregroundColor: const Color(0xFF24353F),
        title: Image.asset("assets/images/logo_transparent.png",
            height: 55, width: 300),
        elevation: 12,
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
        bottom: TabBar(
          controller:
              tabController, // Assurez-vous que cette ligne est bien après `initState`.
          tabs: const [
            Text("Suivi Offres d’Emploi",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFBB8547)),
                textAlign: TextAlign.center),
            Text("Suivi de Candidatures ",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFBB8547)),
                textAlign: TextAlign.center),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          // Tab 1 Content
          SingleChildScrollView(
            child: _offerList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _offerList.length,
                    itemBuilder: (context, index) {
                      final item = _offerList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, // Adjust horizontal padding
                          vertical: 2.0, // Adjust vertical padding
                        ), // External margin
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color(0xFFBB8547), width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: item['profile'] == 'administrateur'
                                ? const AssetImage('assets/images/person.png')
                                : const AssetImage('assets/images/person.png'),
                          ),
                          title: Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFBB8547),
                            ),
                          ),
                          subtitle: Text.rich(
                            TextSpan(
                              text:
                                  'Profile: ${item['search_Offer']} \n', // Default text
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${item['description']}.',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                                // TextSpan(
                                //   text:
                                //       '\nAdresse: ${item['adresse']} \nDate publication: ${item['date_pub']}',
                                //   style: const TextStyle(
                                //       fontSize: 12.0,
                                //       fontWeight: FontWeight.normal),
                                // ),
                              ],
                            ),
                          ),
                          trailing: Icon(
                            Icons.circle_rounded,
                            color: item['etat'] ? Colors.green : Colors.red,
                          ),
                          onTap: () {
                            _showModal(context, item!);
                          },
                        ),
                      );
                    },
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
                  subtitle: const Text(
                      "Plombier professionnel\nDate publication: 21-nov-2024 12h30"),
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
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
            primaryColor: Colors.transparent,
          ),
          child: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Image.asset(
                    'assets/images/logo_transparent.png',
                    width: 400,
                    height: 200,
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Color(0xFFBB8547),
                  ),
                  title: const Text('Accueil',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBB8547))),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFBB8547),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Color(0xFFBB8547),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFBB8547),
                  ),
                  title: const Text('Profile',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBB8547))),
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.edit_document,
                    color: Color(0xFFBB8547),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFBB8547),
                  ),
                  title: const Text('Poster Offres d’Emploi ',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBB8547))),
                  onTap: () {
                    Navigator.pushNamed(context, '/offre');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.edit_note_rounded,
                    color: Color(0xFFBB8547),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFBB8547),
                  ),
                  title: const Text('Proposer mes services',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBB8547))),
                  onTap: () {
                    Navigator.pushNamed(context, '/annonce');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.account_circle,
                    color: Color(0xFFBB8547),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFBB8547),
                  ),
                  title: const Text('Nos Services',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBB8547))),
                  onTap: () {
                    Navigator.pushNamed(context, '/services');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.help,
                    color: Color(0xFFBB8547),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFBB8547),
                  ),
                  title: const Text('Aide et Assistance',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBB8547))),
                  onTap: () {
                    Navigator.pushNamed(context, '/aide');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.file_present,
                    color: Color(0xFFBB8547),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFBB8547),
                  ),
                  title: const Text('Charte',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBB8547))),
                  onTap: () {
                    Navigator.pushNamed(context, '/charte');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Color(0xFFBB8547),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFBB8547),
                  ),
                  title: const Text('Se Déconnecter',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBB8547))),
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    SizedBox(height: 230),
                    Text("Version $appVersion  ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBB8547),
                        ))
                  ],
                ),
              ],
            ),
          )),
    );
  }

  void _showModal(BuildContext context, var item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildCard(
                  imageUrl:
                      'assets/images/person.png', // Replace with your image URL
                  title: item['name'],
                  subtitle:
                      'Profile recherché: ${item['search_Offer']} \n${item['description']} \nAdresse: ${item['adresse']}. \nTéléphone: ${item['phone']}. \nDate publication: ${item['date_pub']} \nStatut: ${item['etat'] == true ? 'actif' : 'désactivé'}',
                  rate: item['rate'],
                  phone: item['phone']),
            ],
          ),
        );
      },
    );
  }

  Widget buildCard(
      {required String imageUrl,
      required String title,
      required String subtitle,
      required int rate,
      required String phone}) {
    return Card(
      color: Colors.white,
      elevation: 1.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, //circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Image.asset(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFFBB8547),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rate ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                    );
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.call, color: Color(0xFFBB8547)),
                      onPressed: () {
                        _launchDialer(phone);
                      },
                      tooltip: 'Appeler',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to launch dialer
  void _launchDialer(String phoneNumber) async {
    print(phoneNumber);
    // ignore: deprecated_member_use
    launch('tel:+221${phoneNumber}');
  }
}
