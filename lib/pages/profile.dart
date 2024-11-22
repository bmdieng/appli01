import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget{

  const ProfilePage({super.key });
 
  @override
  State<ProfilePage> createState() {
    return ProfilePageState();
  }
}


class ProfilePageState extends State<ProfilePage>{
    Map<dynamic, dynamic> userData = {};
    String name = '';
    String profile = '';
    String call = '';
    String email = '';
    String address = '';
    String date = '';

  @override
  Widget build(BuildContext context) {

  fetchUserData(User user) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("profiles/${user.uid}");
    DatabaseEvent event = await ref.once();
    userData = event.snapshot.value as Map<dynamic, dynamic>;
    setState(() {
      name = userData['name'];
      profile = userData['profile'];
      call = userData['phone'];
      email = userData['email'];
      address = userData['adresse'];
      date = userData['date'];
    });
  }
  
  Future<void> loadUserData() async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(child: CircularProgressIndicator()),
    // );
    FirebaseAuth.instance
            .authStateChanges()
            .listen((User? user) async {
              // Hide the loader
              // Navigator.of(context).pop(); 
                if (user == null) {
                  print('User is currently signed out!');
                } else {
                  // print('User is signed in ==> $user');
                  fetchUserData(user);
                }
            });      
  }

  loadUserData();
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
                    name, textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  // const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.person_2_rounded, color:  Color(0xFFBB8547)),
                      title: const Text('Profile: ', style: TextStyle(fontSize: 15, color:  Color(0xFFBB8547))),
                      subtitle: Text(profile),
                      enabled: false,
                      onTap: () {},
                    ),
                    // Divider(),
                    ListTile(
                      leading: const Icon(Icons.call_end_rounded, color:  Color(0xFFBB8547)),
                      title: const Text('Téléphone: ', style: TextStyle(fontSize: 15, color:  Color(0xFFBB8547))),
                      subtitle: Text(call),
                      enabled: false,
                      onTap: () {},
                    ),
                    // Divider(),
                    ListTile(
                      leading: const Icon(Icons.email_rounded, color:  Color(0xFFBB8547)),
                      title: const Text('Email: ', style: TextStyle(fontSize: 15, color:  Color(0xFFBB8547))),
                      subtitle: Text(email),
                      enabled: false,
                      onTap: () {},
                    ),
                    // Divider(),
                    ListTile(
                      leading: const Icon(Icons.pin_drop_rounded, color:  Color(0xFFBB8547)),
                      title: const Text('Adresse: ', style: TextStyle(fontSize: 15, color:  Color(0xFFBB8547))),
                      subtitle: Text(address),
                      enabled: false,
                      onTap: () {},
                    ),
                     ListTile(
                      leading: const Icon(Icons.description_rounded, color:  Color(0xFFBB8547)),
                      title: const Text("Date d'inscription: ", style: TextStyle(fontSize: 15, color:  Color(0xFFBB8547))),
                      subtitle: Text(date),
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
