import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ligueypro/constants/constants.dart';
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
  final List<dynamic> _offerList = [];
  final List<dynamic> _annonceList = [];
  String selectedValue = "Tous";
  var ouvrierList = [
    'Tous',
    'Femme / Homme de ménage',
    'Cuisinier',
    'Electricien',
    'Plombier',
    'Jardinier',
    'Nounou',
    'Menuisier',
    'Courtier',
    'Chauffeur',
    'Gardien',
    'Autres'
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _fetchData('offres_emploi', _offerList, selectedValue!);
    _fetchData('offres_profile', _annonceList, selectedValue!);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _fetchData(String path, List<dynamic> targetList, String selectedValue) {
    var req = _database.child(path).orderByChild('search_Offer');
    if (selectedValue != 'Tous') {
      req = _database
          .child(path)
          .orderByChild('search_Offer') // Filter by a specific child key
          .equalTo(selectedValue);
    }
    req.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data == null) {
        setState(() {
          targetList.clear();
        });
        return;
      }
      final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
      final timestampThreshold = thirtyDaysAgo.millisecondsSinceEpoch;
      final dateFormat = DateFormat("dd-MMM-yyyy HH:mm");
      setState(() {
        targetList.clear();
        data.forEach((key, value) {
          final datePub = dateFormat.parse(value['date_pub']);
          if (datePub.millisecondsSinceEpoch >= timestampThreshold &&
              value['etat']) {
            targetList.add(value);
          }
        });
        targetList.sort((a, b) => b['date_pub'].compareTo(a['date_pub']));
      });
    });
  }

  void _filterData() {
    _fetchData('offres_emploi', _offerList, selectedValue!);
    _fetchData('offres_profile', _annonceList, selectedValue!);
  }

  void _showModal(BuildContext context, dynamic item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (_) => _buildModalContent(item),
    );
  }

  Widget _buildModalContent(dynamic item) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Aligns to the end of the row
              children: [
                Icon(
                  Icons.close,
                  color: Color(0xFFBB8547),
                  size: 25.0,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildCard(
            imageUrl: item['profile'] == 'Recruteur'
                ? 'assets/images/person.png'
                : 'assets/images/engineer.png',
            title: item['name'],
            subtitle:
                'Profile: ${item['search_Offer']}\n${item['description']}\nDate: ${item['date_pub']}\nStatus: ${item['etat'] ? 'Active' : 'Désactivé'}',
            rate: item['rate'] ?? 0,
            phone: item['phone'],
            profile: item['profile'],
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String imageUrl,
    required String title,
    required String subtitle,
    required int rate,
    required String phone,
    required String profile,
  }) {
    int _rating = rate; // Initialize with the provided rating

    void _rate(int newRating) {
      setState(() {
        _rating = newRating; // Update the rating and trigger a rebuild
      });
    }

    return Card(
      color: Colors.white,
      elevation: 1.0,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(imageUrl, height: 150, fit: BoxFit.contain),
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
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(height: 8),
                if (profile != 'Recruteur') // Conditionally show the Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < _rating ? Icons.star : Icons.star_border,
                          color: const Color(0xFFBB8547),
                        ),
                        onPressed: () => _rate(index + 1), // Update rating
                      );
                    }),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.call, color: Color(0xFFBB8547)),
                      onPressed: () => _launchDialer(phone),
                      tooltip: 'Call',
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

  void _launchDialer(String phoneNumber) async {
    final Uri dialerUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(dialerUri)) {
      await launchUrl(dialerUri);
    } else {
      throw "Impossible d'emettre un appel vers ce numéro $phoneNumber";
    }
  }

  Widget _buildList(List<dynamic> items) {
    return SingleChildScrollView(
      child: items.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0), // Customize individual sides
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Aucun élément trouvé\n',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Image.asset(
                          'assets/images/not_found.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 2.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(color: Color(0xFFBB8547), width: 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                          (item['profile'] == 'Recruteur' ||
                                  item['profile'] == 'administrateur')
                              ? 'assets/images/person.png'
                              : 'assets/images/engineer.png'),
                    ),
                    title: Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBB8547),
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                  text: item['profile'] == 'Recruteur'
                                      ? 'Profile recherché: '
                                      : 'Profile: '),
                              TextSpan(
                                text: item['search_Offer'] + '\n',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: item['description'],
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 10),
                        if (item['profile'] != 'Recruteur')
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              // Set your rating here
                              return Icon(
                                index < item['rate']
                                    ? Icons.star
                                    : Icons.star_border,
                                color: const Color(0xFFBB8547),
                              );
                            }),
                          ),
                      ],
                    ),
                    // Text(
                    //   item['profile'] == 'Recruteur'
                    //       ? 'Profile recherché: ${item['search_Offer']}\n${item['description']} '
                    //       : 'Profile: ${item['search_Offer']}\n${item['description']}',
                    //   style: const TextStyle(fontSize: 12.0),
                    // ),
                    trailing: Icon(
                      Icons.circle_rounded,
                      color: item['etat'] ? Colors.green : Colors.red,
                    ),
                    onTap: () => _showModal(context, item),
                  ),
                );
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        title: Image.asset("assets/images/logo_transparent.png",
            height: 55, width: 300),
        actions: [
          IconButton(
            constraints: const BoxConstraints(
              minWidth: 80, // Largeur minimale pour inclure un espace
            ),
            icon: const Icon(Icons.location_on,
                color: Color(0xFFBB8547), size: 24),
            onPressed: () {
              Navigator.pushNamed(context, '/geoloc');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                controller: tabController,
                tabs: const [
                  Text("Voir les offres d’Emploi",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBB8547)),
                      textAlign: TextAlign.center),
                  Text("Voir les Candidatures ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFBB8547)),
                      textAlign: TextAlign.center),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 5, 0, 5),
                child: Row(
                  children: [
                    const Text(
                      "Rechercher un metier", // Label text
                      style: TextStyle(
                        color: Color(0xFFBB8547),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                        width:
                            10), // Adds some space between the label and dropdown
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            _filterData();
                          });
                        },
                        items: ouvrierList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        hint: const Text(
                          "Sélectionner un métier", // This is the hint
                          style: TextStyle(color: Color(0xFFBB8547)),
                        ),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Color(0xFFBB8547)),
                        dropdownColor: Colors.white,
                        underline:
                            const SizedBox(), // Removes the default underline
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _buildList(_offerList),
          _buildList(_annonceList),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Header
            DrawerHeader(
              child: Image.asset(
                'assets/images/logo_transparent.png',
                width: 400,
                height: 200,
              ),
            ),
            // Body
            Expanded(
              child: ListView(
                children: [
                  _buildDrawerItem(
                    context,
                    icon: Icons.home,
                    label: 'Accueil',
                    routeName: '/',
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.person,
                    label: 'Profile',
                    routeName: '/profile',
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.edit_document,
                    label: 'Poster Offres d’Emploi',
                    routeName: '/offre',
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.edit_note_rounded,
                    label: 'Proposer mes services',
                    routeName: '/annonce',
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.tips_and_updates,
                    label: 'Avis et Suggestions',
                    routeName: '/avis',
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.help,
                    label: 'Aide et Assistance',
                    routeName: '/aide',
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.file_present,
                    label: 'Charte',
                    routeName: '/charte',
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.logout,
                    label: 'Se Déconnecter',
                    routeName: '/login',
                  ),
                ],
              ),
            ),
            // Footer
            Container(
              padding: const EdgeInsets.all(16.0),
              color: const Color(0xFFBB8547),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Version $appVersion',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Handle footer action
                      showAlertDialog(context, appOwner);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Helper function
  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String routeName,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFFBB8547),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Color(0xFFBB8547),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Color(0xFFBB8547),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }

  showAlertDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(appName),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
