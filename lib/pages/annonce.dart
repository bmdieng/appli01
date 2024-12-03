import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ligueypro/constants/constants.dart';

class AnnoncePage extends StatefulWidget {
  const AnnoncePage({Key? key}) : super(key: key);

  @override
  State<AnnoncePage> createState() => _AnnoncePageState();
}

class _AnnoncePageState extends State<AnnoncePage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _adresse = TextEditingController();
  TextEditingController phone = TextEditingController();
  Map<dynamic, dynamic> userData = {};

  String profileValue = 'Employé';
  String categorieValue = '';

  var profileList = [
    "Employé",
  ];

  var ouvrierList = [
    '',
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

  bool validateEmail(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return emailValid;
  }

  void toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.brown,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void toastError(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale("fr", "FR"),
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formatDate =
            DateFormat("dd-MMM-yyyy  HH:mm").format(selectedDate);
        // _selectedDOB = formatDate;
      });
    }
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(appName),
          content: const Text(
              "Les informations saisies ne sont pas correctent. Merci de réessayer."),
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

  Future<void> _submit() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      Navigator.of(context).pop();
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in ==> $user');
        DatabaseReference ref = FirebaseDatabase.instance.ref("offres_profile");
        // Generate a new child with a unique key
        DatabaseReference newRef = ref.push();
        // Data to add
        Map<String, dynamic> offerData = {
          "name": _username.text,
          "email": _email.text.trim(),
          "adresse": _adresse.text,
          "profile": profileValue,
          "search_Offer": categorieValue,
          "phone": phone.text.trim(),
          "etat": true,
          "description": _description.text,
          'date_pub': DateFormat("dd-MMM-yyyy HH:mm").format(DateTime.now()),
          'user_uid': user.uid,
          'rate': 0
        };
        // Add the data to the newly created child
        try {
          await newRef.set(offerData);
          toastMessage(
              "Votre annonce a été publiée avec succès. Elle sera visible dés qu'elle sera validée par les administrateurs!");
          Navigator.pushNamed(context, '/home');
        } on FirebaseAuthException catch (e) {
          print(
              "Erreur insertion =========> ${AuthExceptionHandler.generateErrorMessage(e.code)}");
        }
        print("Data added successfully at ${newRef.key}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;

    assert(_username != null, '');
    assert(_email != null, '');
    assert(_adresse != null, '');
    assert(_description != null, '');
    assert(phone != null, '');

    _fetchUserData(user!);
    return Form(
      key: _formkey,
      child: Scaffold(
          appBar: AppBar(
              title: const Text("Proposez vos services en toute simplicité"),
              elevation: 15),
          body: SafeArea(
            child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                    child: SingleChildScrollView(
                        child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Image.asset(
                              'assets/images/logo_transparent.png')),
                    ),
                    TextFormField(
                      controller: _username,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Prénom & nom";
                        }
                        return null;
                      },
                      style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          color: Colors.brown),
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              color: Colors.red),
                          labelText: "Prénom & nom",
                          prefixIcon: const Icon(
                            Icons.person_2_rounded,
                            color: Color(0xFFBB8547),
                          ),
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              color: Colors.brown),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.brown, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   controller: _email,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return "Email";
                    //     } else if (!validateEmail(value)) {
                    //       return "Adresse email invalide.";
                    //     }
                    //     return null;
                    //   },
                    //   style: const TextStyle(
                    //       fontSize: 18,
                    //       fontStyle: FontStyle.normal,
                    //       color: Colors.brown),
                    //   decoration: InputDecoration(
                    //       errorStyle: const TextStyle(
                    //           fontSize: 10,
                    //           fontStyle: FontStyle.normal,
                    //           color: Colors.red),
                    //       labelText: "Email",
                    //       prefixIcon: const Icon(
                    //         Icons.email_rounded,
                    //         color: Color(0xFFBB8547),
                    //       ),
                    //       labelStyle: const TextStyle(
                    //           fontSize: 18,
                    //           fontStyle: FontStyle.normal,
                    //           color: Colors.brown),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               color: Colors.brown, width: 1),
                    //           borderRadius: BorderRadius.circular(10)),
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10))),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // TextFormField(
                    //   controller: phone,
                    //   keyboardType: TextInputType.phone,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return "numéro de tel";
                    //     }
                    //     return null;
                    //   },
                    //   style: const TextStyle(
                    //       fontSize: 18,
                    //       fontStyle: FontStyle.normal,
                    //       color: Colors.brown),
                    //   decoration: InputDecoration(
                    //       errorStyle: const TextStyle(
                    //           fontSize: 10,
                    //           fontStyle: FontStyle.normal,
                    //           color: Colors.red),
                    //       labelText: "Téléphone",
                    //       prefixIcon: const Icon(
                    //         Icons.call_end_rounded,
                    //         color: Color(0xFFBB8547),
                    //       ),
                    //       labelStyle: const TextStyle(
                    //           fontSize: 18,
                    //           fontStyle: FontStyle.normal,
                    //           color: Colors.brown),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               color: Colors.brown, width: 1),
                    //           borderRadius: BorderRadius.circular(10)),
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10))),
                    // ),

                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _adresse,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Adresse";
                        }
                        return null;
                      },
                      style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          color: Colors.brown),
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              color: Colors.red),
                          labelText: "Adresse",
                          prefixIcon: const Icon(
                            Icons.pin_drop_rounded,
                            color: Color(0xFFBB8547),
                          ),
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              color: Colors.brown),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.brown, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      width: size.width,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      height: 50,
                      child: Stack(
                        children: [
                          const Text(
                            "Votre profile (Recruteur ou employé)",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFBB8547),
                            ), // adjust your title as you required
                          ),
                          DropdownButton(
                            isExpanded: true,
                            iconSize: 15,
                            hint: Text(
                              profileValue,
                              style: const TextStyle(
                                  fontSize: 1,
                                  color: Colors.brown,
                                  height: 2.0),
                              textAlign: TextAlign.center,
                            ),
                            underline: Container(
                                child: const Column(
                                    // children: [
                                    //   Divider(
                                    //       thickness: 1,
                                    //       color: const Color(0xFFa5a5a5))
                                    // ],
                                    )),
                            value: profileValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: profileList.map((String items) {
                              return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFa5a5a5),
                                    ),
                                  ));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                profileValue = newValue.toString();
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      width: size.width,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      height: 50,
                      child: Stack(
                        children: [
                          const Text(
                            "Indiquez votre métier",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFBB8547),
                            ), // adjust your title as you required
                          ),
                          DropdownButton(
                            isExpanded: true,
                            iconSize: 15,
                            hint: Text(
                              categorieValue,
                              style: const TextStyle(
                                  fontSize: 1,
                                  color: Colors.brown,
                                  height: 2.0),
                              textAlign: TextAlign.center,
                            ),
                            underline: Container(child: const Column()),
                            value: categorieValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: ouvrierList.map((String items) {
                              return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    items,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFa5a5a5),
                                    ),
                                  ));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                categorieValue = newValue.toString();
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _description,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Description";
                        }
                        return null;
                      },
                      style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          color: Colors.brown),
                      decoration: InputDecoration(
                          errorStyle: const TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.normal,
                              color: Colors.red),
                          labelText: "Description",
                          prefixIcon: const Icon(
                            Icons.description_rounded,
                            color: Color(0xFFBB8547),
                          ),
                          labelStyle: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              color: Colors.brown),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.brown, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: size.width,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown),
                          child: Container(
                            width: 350.0,
                            height: 80,
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 0.0, bottom: 0.0),
                            child: FilledButton(
                              onPressed: (categorieValue.isNotEmpty &&
                                      _description.text.isNotEmpty)
                                  ? _submit
                                  : _showToast(),
                              child: const Text(
                                "Publier",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )))),
          )),
    );
  }

  _showToast() {
    toastError("Merci de remplir les champs manquant.");
  }

  _fetchUserData(User user) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("profiles/${user.uid}");
    DatabaseEvent event = await ref.once();
    userData = event.snapshot.value as Map<dynamic, dynamic>;
    setState(() {
      _username.text = userData['name'];
      // _adresse.text = userData['adresse'];
      phone.text = userData['phone'];
      _email.text = userData['email'];
    });
  }
}
