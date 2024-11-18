import 'package:flutter/material.dart';

class ChartePage extends StatelessWidget{
  const ChartePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conditions Générales d'Utilisation"), elevation: 12),
      body: ListView(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
                child: SizedBox(
                    width: 150,
                    height: 100,
                    child: Image.asset('assets/images/logo_transparent.png')),
              ),
       const Padding(
        padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
        child: Text("A l’air du numérique ou les logiciels et les applications font parties de notre environnement quotidien, ILAMMEDIA propose aux entreprises des solutions innovantes qui vont les aider à optimiser leur productions ou à les mieux valoriser leurs produits ou services. Acteur majeur du conseil dans l’informatique pour les entreprises, ILAMMEDIA accompagne de grands groupes et filiales du secteur industriel tout au long de leurs projets et les a aidés à optimiser et valoriser leurs productions. Les intervenants de ILAMMEDIA sont capables de gérer vos projets (étude, conception, déploiement et mis en service, formation, accompagnement et maintenance). Et en s’adaptant à votre environnement technologique, fonctionnel et métier. Chez ILAMMEDIA, nous élaborant des applications qui répondent parfaitement à vos attente et a vos besoins. Nos principaux atouts concernent la réalisation d'applications sur-mesure. Que ce soit au niveau de l'analyse fonctionnel, de la planification, du développement, des tests, de la mise en place, du suivi ou transfert de compétences vous trouverez chez ILAMMEDIA les skills et la rigueur nécessaire. La maîtrise de plusieurs outils de programmation et de développement ainsi que des bases de données et les Framework nous permettent de proposer à nos clients la solution la plus optimale et la plus adaptée a leurs besoins.",
        style: TextStyle(
          fontSize: 16
        ),)
        ),
      ],

    )
    );
  }

}