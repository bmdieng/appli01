import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ligueypro/constants/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool passToggle = true;
  String _email = '';
  String _password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;

  String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'Ce champ ne peut pas être vide.';
    }
    if (email.length < 4) {
      return 'Adresse trop courte';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Adresse e-mail non conforme.';
    }
    // return null if the text is valid
    return null;
  }

  String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Ce champ ne peut pas être vide.';
    }
    if (password.length < 6) {
      return 'Votre mot de passe doit comporter un minimum de 6 caractères.';
    }
    // return null if the text is valid
    return null;
  }

  showToast(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(appName),
          content: const Text(
              "Votre identifiant ou mot de passe est incorrect. Merci de réessayer."),
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
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      // Hide the loader
      Navigator.of(context).pop();

      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bienvenue ! Vous êtes connecté.')),
        );
        Navigator.pushNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      // String msg = AuthExceptionHandler.generateErrorMessage(e.code);
      // Hide the loader
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(appName),
            content: Text(AuthExceptionHandler.generateErrorMessage(e.code)),
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

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () async {
          return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Quitter ?'),
                  content:
                      const Text('Voulez-vous vraiment quitter cette page ?'),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pop(false), // Ne pas quitter
                      child: const Text('Non'),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pop(true), // Quitter
                      child: const Text('Oui'),
                    ),
                  ],
                ),
              ) ??
              false; // Si null, retourner false
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 241, 234, 226),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            width: 230,
                            height: 180,
                            child: Image.asset(
                                'assets/images/logo_transparent.png'),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 15.0, bottom: 5.0, left: 40.0, right: 40.0),
                          child: Text(
                            "Trouvez le bon expert, tout près de chez vous.",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFBB8547)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 5.0, left: 30.0, right: 30.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color(0xFFBB8547),
                              ),
                              hintText: "Saisissez votre Email.",
                            ),
                            validator: validateEmail,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onChanged: (text) => setState(() => _email = text),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 15, bottom: 10),
                          child: TextFormField(
                            obscureText: passToggle,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              hintText: 'Saisissez votre mot de passe.',
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color(0xFFBB8547)),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    passToggle = !passToggle;
                                  });
                                },
                                child: Icon(passToggle
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            validator: validatePassword,
                            onChanged: (text) =>
                                setState(() => _password = text),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.only(right: 18.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/reset_password');
                            },
                            child: const Text(
                              'Mot de passe oublié ?',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15),
                            ),
                          ),
                        ),
                        Container(
                          width: 350.0,
                          height: 70,
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 10.0, bottom: 10.0),
                          child: FilledButton(
                            onPressed: _email.isNotEmpty ? _submit : null,
                            child: const Text(
                              'Se connecter',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text(
                            'Créer un compte',
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 150), // Add space before footer
                // Footer Section
                Container(
                  // color: const Color(0xFFBB8547), // Footer background color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: const Text(
                    '$appOwner © 2024',
                    style: TextStyle(
                        color: const Color(0xFFBB8547),
                        fontSize: 14,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
