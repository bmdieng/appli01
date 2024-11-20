import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const Color kBackgroundColor = Color(0xFFD4DEF7);
const String appName = "LigueyPro";
const String appVersion = "1.0";
const Color kTextColor = Color(0xFF4879C5);
const Color kButtonColor = Color(0xFFBB8547);
const InputDecoration kTextInputDecoration = InputDecoration(
  border: InputBorder.none,
  hintText: '',
  // ),
);
const firebaseConfig = {
  'apiKey': "AIzaSyDzH26-VT-mDJZL5-Xh9DoWlSL56ED9Q44",
  'authDomain': "ligueypro.firebaseapp.com",
  'projectId': "ligueypro",
  'storageBucket': "ligueypro.firebasestorage.app",
  'messagingSenderId': "1036306872826",
  'appId': "1:1036306872826:web:a45a56e2a18f9e7108cc43"
};

enum AuthStatus {
  successful,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  weakPassword,
  networkOff,
  unknown,
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      case "network-request-failed":
        status = AuthStatus.networkOff;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    print("************** Message d'erreur $error ");
    switch (error) {
      case "invalid-email":
        errorMessage = "Votre adresse e-mail semble être mal formée.";
        break;
      case "weak-password":
        errorMessage = "Votre mot de passe doit comporter au moins 6 caractères.";
        break;
      case "wrong-password":
        errorMessage = "Votre adresse e-mail ou votre mot de passe est incorrect.";
        break;
      case "email-already-in-use":
        errorMessage =
            "L'adresse e-mail est déjà utilisée par un autre compte";
        break;
      case "network-request-failed":
        errorMessage =
            "Merci de vérifier l'état de votre connexion internet.";
        break;
      case 'user-not-found':
        return 'Utilisateur introuvable!';
      default:
        errorMessage = "Une erreur s'est produite. Veuillez réessayer plus tard.";
    }
    return errorMessage;
  }
}
