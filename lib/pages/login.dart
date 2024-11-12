import 'package:appli01/main_listview.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool passToggle = true;
  String _email = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'Ce champ ne peut pas être vide.';
    }
    if (email.length < 4) {
      return 'Too short';
    }
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'Adresse e-mail ou mot de passe invalide. Veuillez réessayer.';
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bienvenue ! Vous êtes connecté.')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(email: _email,)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text("Login Page"),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 120.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Center(
                child: SizedBox(
                    width: 230,
                    height: 180,
                    child: Image.asset('assets/images/logo_2.png')),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 5.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    hintText: "Saisissez votre Email.",
                    // use the getter variable defined above
                  ),
                  validator: validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (text) => setState(() => _email = text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, top: 15, bottom: 10),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Saisissez votre mot de passe.',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  validator: validatePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 18.0),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
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
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Créer un compte',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}