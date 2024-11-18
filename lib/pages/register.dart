import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ligueypro/constants/constants.dart'; // for date format
import 'package:loader_overlay/loader_overlay.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isChecked = false;
  String  _selectedDOB = "Date de naissance";
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cpassword = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _adresse = TextEditingController();
  final TextEditingController _description = TextEditingController();
  TextEditingController phone = TextEditingController();


  String cotegorieValue = 'Femme / Homme de ménage';   
  String profileValue = 'Recruteur';   

  // List of items in our dropdown menu
  var ouvrierList = [    
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

   var profileList = [    
    "Recruteur",
    "Employé"
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
        String formatDate = DateFormat("dd-MMM-yyyy").format(selectedDate);
        _selectedDOB = formatDate;
      });
    }
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(appName),
          content: const Text("Les informations saisies ne sont pas correctent. Merci de réessayer."),
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
    context.loaderOverlay.show();
      try {
       final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _email.text,
              password: _password.text,
            );
            FirebaseAuth.instance
              .authStateChanges()
              .listen((User? user) async {
                context.loaderOverlay.hide();

                if (user == null) {
                  print('User is currently signed out!');
                } else {
                  print('User is signed in ==> $user');
                  DatabaseReference ref = FirebaseDatabase.instance.ref("profiles/${user.uid}");
                  await ref.set({
                    "name": _username.text,
                    "email": _email.text.trim(),
                    "adresse": _adresse.text,
                    "profile": profileValue,
                    "categorie": cotegorieValue,
                    "description": _description.text,
                    "phone": phone.text.trim()
                  });
                  Navigator.pushNamed(context,  '/login');
                }
              });
            

          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              showAlertDialog(context);
            } else if (e.code == 'email-already-in-use') {
              showAlertDialog(context);
            }
          } catch (e) {
            print(e);
          }

  }

  @override
  Widget build(BuildContext context) {

    DatabaseReference _databaseRef = FirebaseDatabase.instance.ref().child('profiles');
    var size = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;

    return Form(
      key: _formkey,
      child: Scaffold(
          appBar: AppBar(title: const Text("Inscription à $appName"), elevation: 12),
          body: SafeArea(
        child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                child: SizedBox(
                    width: 150,
                    height: 100,
                    child: Image.asset('assets/images/logo_transparent.png')),
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
                      prefixIcon: const Icon(Icons.person_2_rounded, color: Color(0xFFBB8547),),
                      labelStyle: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          color: Colors.brown),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.brown, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email";
                    } else if (!validateEmail(value)) {
                      return "Adresse email invalide.";
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
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email_rounded, color: Color(0xFFBB8547),),
                      labelStyle: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          color: Colors.brown),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.brown, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "numéro de tel";
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
                      labelText: "Téléphone",
                      prefixIcon: const Icon(Icons.call_end_rounded, color: Color(0xFFBB8547),),
                      labelStyle: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          color: Colors.brown),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.brown, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
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
                      prefixIcon: const Icon(Icons.pin_drop_rounded, color: Color(0xFFBB8547),),
                      labelStyle: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          color: Colors.brown),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.brown, width: 1),
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
                      const Text("Votre profile (Recruteur ou employé)", style: TextStyle(
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
                              height: 2.0
                            ),
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
                      const Text("Selectionner votre métier", style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFBB8547),
                        ), // adjust your title as you required
                      ),
                      DropdownButton(
                        isExpanded: true,
                        iconSize: 15,
                          hint: Text(
                            cotegorieValue,
                            style: const TextStyle(
                              fontSize: 1, 
                              color: Colors.brown,
                              height: 2.0
                            ),
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
                        value: cotegorieValue,
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
                              cotegorieValue = newValue.toString();
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
                      prefixIcon: const Icon(Icons.description_rounded, color: Color(0xFFBB8547),),
                      labelStyle: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          color: Colors.brown),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.brown, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Entrer Password";
                    } else if (value.length < 7) {
                      return "Votre mot de passe doit comporter un minimum de 6 caractères.";
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
                      labelText: "Mot de passe",
                      prefixIcon: const Icon(Icons.password_rounded, color: Color(0xFFBB8547),),
                      labelStyle: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          color: Colors.brown),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.brown, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _cpassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirmer Password";
                    } else if (value.length < 7) {
                      return "Votre mot de passe doit comporter un minimum de 6 caractères.";
                    } else if (value != _password.text) {
                      return "Les mots de passe ne sont pas identiques";
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
                      labelText: "Confirmer mot de passe",
                      prefixIcon: const Icon(Icons.password_rounded, color: Color(0xFFBB8547),),
                      labelStyle: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          color: Colors.brown),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.brown, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.blue,
                        value: _isChecked,
                        onChanged: (val) {
                          setState(() {
                            _isChecked = !_isChecked;
                          });
                        }),
                    const Text("J'accepte les CGU ",
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.brown)),
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.brown, width: 1.0))),
                      child: InkWell(
                        onTap: () {
                          // toastMessage("Clique sur les CGU");
                          Navigator.pushNamed(context,  '/charte');
                        },
                        child: const Text("Conditions d'Utilisation",
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: kTextColor)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: size.width,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                         if (_selectedDOB == "Date de naissance") {
                          toastMessage("Choix de la date de naissance");
                        } else if (!_isChecked) {
                        toastMessage("Merci de valider les Conditions d'Utilisation ");
                      } else {}
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                    child: Container(
                          width: 350.0,
                          height: 70,
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 0.0, bottom:                                                                                                                                                                                          0.0),
                          child: FilledButton(
                            onPressed: _submit,
                            child: const Text(
                              "S'inscrire",
                              style: TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        )
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )))),
      )),
    );
  }
}