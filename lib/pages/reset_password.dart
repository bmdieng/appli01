import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ligueypro/constants/constants.dart';

class ResetPasswordPage extends StatefulWidget {
  static const String id = 'reset_password';
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  static final auth = FirebaseAuth.instance;
  // static late AuthStatus _status;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      await auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Un lien de réinitialisation du mot de passe a été envoyé à votre adresse adresse e-mail!")),
      );
      Navigator.pushNamed(context,  '/login');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AuthExceptionHandler.generateErrorMessage(e.code))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Container(
        width: size.width,
        height: size.height,
        color: const Color.fromARGB(255, 241, 234, 226),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 50.0, bottom: 25.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Color(0xFFBB8547), size: 30.0,),
                ),
                const SizedBox(height: 10),
                 Center(
                  child: SizedBox(
                      width: 230,
                      height: 100,
                      child: Image.asset('assets/images/logo_transparent.png')),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Vous avez oublié votre mot de passe ?",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Veuillez saisir votre adresse email pour récupérer votre mot de passe.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Saisir votre adresse email',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  child: TextFormField(
                    obscureText: false,
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Empty email';
                      }
                      return null;
                    },
                    autofocus: false,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      isDense: true,
                      // fillColor: kPrimaryColor,
                      filled: true,
                      errorStyle: TextStyle(fontSize: 15),
                      hintText: 'Adresse Email',
                      hintStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey),
                    ),
                  ),
                ),
                SizedBox(height: (size.height/2.8)),
                // const Expanded(child: SizedBox()),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.brown,
                    child: MaterialButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          sendPasswordResetEmail();
                        }
                      },
                      minWidth: double.infinity,
                      child: const Text(
                        'Réinitialiser',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
        ]
      )
    );
  }
}