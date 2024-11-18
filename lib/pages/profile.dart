import 'package:flutter/material.dart';
import 'package:ligueypro/constants/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List userData = [
    {
      "name": 'Momoo DIENG',
      "email": "momodieng00@gmail.com",
      'profile': "Administrateur",
      "call": "77 720 02 26",
      "address": "Hann Mariste 1 - Dakar/Sénégal",
      "categorie": "Electricien",
      "description": "Je suis un ouvrier qualifié et disponible 24/24, 7j/7 pour vos dépannage."
    }
  ];
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFBB8547), // const Color(0xFF24353F), // Theme.of(context).colorScheme.inversePrimary,
      foregroundColor: Colors.white,
      title: Image.asset("assets/images/logo_transparent.png", height: 65, width: 300,)),
      body: Column(
        children: [
          const Expanded(flex: 1, child: _TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                    top: 0, bottom: 0, left: 30.0, right: 30.0),
              child: ListView(
                children: [
                  Text(
                    userData[0]['name'], textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  // const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.person_2_rounded, color:  Color(0xFFBB8547)),
                      title: const Text('Profile: ', style: TextStyle(fontSize: 15, color:  Color(0xFFBB8547))),
                      subtitle: Text(userData[0]['profile']),
                      enabled: false,
                      onTap: () {},
                    ),
                    // Divider(),
                    ListTile(
                      leading: const Icon(Icons.call_end_rounded, color:  Color(0xFFBB8547)),
                      title: const Text('Téléphone: ', style: TextStyle(fontSize: 15, color:  Color(0xFFBB8547))),
                      subtitle: Text(userData[0]['call']),
                      enabled: false,
                      onTap: () {},
                    ),
                    // Divider(),
                    ListTile(
                      leading: const Icon(Icons.email_rounded, color:  Color(0xFFBB8547)),
                      title: const Text('Email: ', style: TextStyle(fontSize: 15, color:  Color(0xFFBB8547))),
                      subtitle: Text(userData[0]['email']),
                      enabled: false,
                      onTap: () {},
                    ),
                    // Divider(),
                    ListTile(
                      leading: const Icon(Icons.pin_drop_rounded, color:  Color(0xFFBB8547)),
                      title: const Text('Adresse: ', style: TextStyle(fontSize: 15, color:  Color(0xFFBB8547))),
                      subtitle: Text(userData[0]['address']),
                      enabled: false,
                      onTap: () {},
                    ),
                    // Divider(),
                    ListTile(
                      leading: const Icon(Icons.category_rounded, color:  Color(0xFFBB8547)),
                      title: const Text('Catégorie: ', style: TextStyle(fontSize: 15, color:  Color(0xFFBB8547))),
                      subtitle: Text(userData[0]['categorie']),
                      enabled: false,
                      onTap: () {},
                    ),
                    // Divider(),
                    ListTile(
                      leading: const Icon(Icons.description_rounded, color:  Color(0xFFBB8547)),
                      title: const Text('Description: ', style: TextStyle(fontSize: 15, color:  Color(0xFFBB8547))),
                      subtitle: Text(userData[0]['description']),
                      enabled: false,
                      onTap: () {},
                    ),
                  // const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          // height: 10,
          margin: const EdgeInsets.only(bottom: 60),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [Color(0xFFBB8547), Color(0xFFBB8547)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 110,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/person.png')),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
