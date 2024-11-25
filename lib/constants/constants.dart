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
const termsAndConditions = """Conditions Générales d'Utilisation (CGU)
1. Préambule
Les présentes Conditions Générales d'Utilisation (ci-après "CGU") régissent l’utilisation de l’application Ligueyro  (ci-après "l’Application"), éditée par Digitrest Consulting.

En accédant ou en utilisant l’Application, l’Utilisateur (particulier ou ouvrier) reconnaît avoir lu, compris et accepté les présentes CGU.

2. Définitions
Application : la plateforme numérique accessible via permettant la mise en relation entre les Particuliers et les Ouvriers.
Utilisateur : toute personne utilisant l’Application, qu’il s’agisse d’un Particulier ou d’un Ouvrier.
Particulier : toute personne physique recherchant des prestations de services.
Ouvrier : toute personne physique proposant ses services en vue de réaliser des missions ponctuelles.
Prestations : les services proposés par les Ouvriers et demandés par les Particuliers via l’Application.
3. Objet
L’Application a pour objet de mettre en relation des Particuliers souhaitant bénéficier de prestations de services et des Ouvriers cherchant des missions. Ligueyro  agit uniquement en tant qu’intermédiaire et n’intervient pas dans la relation contractuelle entre le Particulier et l’Ouvrier.

4. Inscription et accès à l’Application
4.1. Création de compte
L’accès à certaines fonctionnalités de l’Application nécessite la création d’un compte utilisateur. Lors de l’inscription, l’Utilisateur s’engage à fournir des informations exactes, complètes et à jour.

4.2. Conditions d’éligibilité
Avoir au moins 18 ans.
Résider dans un pays où l’Application est disponible.
Pour les Ouvriers : disposer des qualifications requises et respecter les obligations légales et réglementaires en vigueur.
5. Utilisation de l’Application
5.1. Engagement des Utilisateurs
Chaque Utilisateur s’engage à :

Utiliser l’Application de manière conforme aux lois et règlements en vigueur.
Ne pas publier de contenu illicite, offensant ou inapproprié.
Ne pas détourner l’usage de l’Application à des fins autres que celles prévues.
5.2. Rôle de l’Application
Ligueyro  ne garantit ni la qualité des Prestations réalisées par les Ouvriers, ni le respect des engagements pris par les Particuliers. Toute réclamation doit être adressée directement entre les parties concernées.

6. Responsabilité
6.1. Responsabilité de l’éditeur
Ligueyro  décline toute responsabilité en cas de :

Litige entre Particulier et Ouvrier.
Dommage causé par une Prestation réalisée par un Ouvrier.
Mauvaise utilisation de l’Application par l’Utilisateur.
6.2. Responsabilité des Utilisateurs
Les Utilisateurs sont seuls responsables des informations qu’ils fournissent et des engagements qu’ils prennent via l’Application.

7. Tarification et paiement
L’inscription à l’Application peut être gratuite ou payante, selon les fonctionnalités. Si l’Application propose une solution de paiement, les transactions financières sont traitées via un prestataire tiers, dont les conditions s’appliquent en complément des présentes CGU.

8. Données personnelles
Ligueyro  collecte et traite les données personnelles des Utilisateurs afin de fournir de meilleurs qualités de service.

9. Propriété intellectuelle
Tous les éléments de l’Application (textes, images, logos, marques, logiciels) sont protégés par les lois sur la propriété intellectuelle. Toute reproduction ou exploitation non autorisée est interdite.

10. Modification des CGU
Ligueyro  se réserve le droit de modifier les présentes CGU à tout moment. Les Utilisateurs seront informés des changements via l’Application.

11. Loi applicable et juridiction compétente
Les présentes CGU sont régies par la loi . En cas de litige, les parties s’efforceront de trouver une solution amiable avant de saisir les tribunaux compétents.

Pour toute question concernant ces CGU, contactez-nous à ligueypro@gmail.com .

Date de dernière mise à jour : 25 novembre 2024.""";

const aideAssistance = """1. Définir le concept et les fonctionnalités clés
Public cible
Particuliers : Cherchent des services (ménage, bricolage, jardinage, plomberie, etc.).
Ouvriers/Prestataires : Personnes qualifiées ou non à la recherche d’opportunités.
Fonctionnalités essentielles
Pour les particuliers :

Création de compte et profil (avec besoin précis).
Recherche d’ouvriers par localisation, compétence ou disponibilité.
Système de réservation (par date et heure).
Suivi des prestations (historique, feedback).
Paiement intégré (sécurisé).
Pour les ouvriers :

Création de profil avec compétences et expérience.
Disponibilité et gestion des demandes de missions.
Accès aux évaluations et recommandations.
Gestion des paiements reçus.
Général :

Système de géolocalisation.
Messagerie interne pour échanger avant une prestation.
Avis et notes pour les deux parties.
Notifications push (nouveaux jobs ou messages).
2. Étude de marché
Analyse des concurrents
Regarde des applications similaires (ex. : Frizbiz, NeedHelp, Allovoisins) pour comprendre leurs points forts et faiblesses.
Identifie des niches ou des fonctionnalités manquantes.
Cibles spécifiques
Propose une offre différenciée : par exemple, un tarif réduit pour les étudiants ou une garantie qualité pour les particuliers.
3. Modèle économique
Sources de revenus
Commission : Prenez un pourcentage sur chaque transaction entre particulier et ouvrier.
Abonnement premium : Donne accès à des fonctionnalités supplémentaires (plus de visibilité pour les ouvriers ou priorisation des demandes pour les particuliers).
Publicité locale : Pour des artisans ou entreprises.
4. Développement technique
Technologies
Backend : Node.js, Django (Python) ou Laravel (PHP).
Frontend : React.js, Vue.js ou Angular pour une application web.
Mobile : Flutter ou React Native pour une application cross-platform.
Base de données : PostgreSQL, MySQL ou MongoDB.
Équipe nécessaire
Développeurs (frontend, backend, mobile).
Designer UI/UX pour une interface intuitive.
Spécialiste marketing pour le lancement.
Outils à considérer
API de géolocalisation (Google Maps).
Paiement sécurisé (Stripe, PayPal).
Hébergement cloud (AWS, Google Cloud).
5. Lancer et promouvoir
Phase de test
Commence par un pilote dans une ville ou une région spécifique.
Collecte les retours pour améliorer l’application.
Stratégies marketing
Campagnes sur les réseaux sociaux : Publicités ciblées sur Facebook, Instagram, LinkedIn.
Partenariats locaux : Avec des agences de placement ou des entreprises de formation professionnelle.
Référencement naturel et payant : Crée un blog avec des conseils pratiques pour attirer des visiteurs.
Fidélisation
Offres promotionnelles au lancement.
Programme de parrainage : Récompense les utilisateurs qui recommandent l’application.
6. Suivi et amélioration
Analyse des données d’utilisation pour comprendre les besoins des utilisateurs.
Ajouter de nouvelles fonctionnalités en fonction des retours.
Maintenir un excellent service client. """;

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
        errorMessage =
            "Votre mot de passe doit comporter au moins 6 caractères.";
        break;
      case "wrong-password":
        errorMessage =
            "Votre adresse e-mail ou votre mot de passe est incorrect.";
        break;
      case "email-already-in-use":
        errorMessage = "L'adresse e-mail est déjà utilisée par un autre compte";
        break;
      case "network-request-failed":
        errorMessage = "Merci de vérifier l'état de votre connexion internet.";
        break;
      case 'user-not-found':
        return 'Utilisateur introuvable!';
      default:
        errorMessage =
            "Une erreur s'est produite. Veuillez réessayer plus tard.";
    }
    return errorMessage;
  }
}
