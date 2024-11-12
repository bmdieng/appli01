import 'package:flutter/material.dart';

class ChartePage extends StatelessWidget{
  const ChartePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Charte de Digitrest Consulting"), elevation: 12),
      body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network('https://scontent.fdkr7-1.fna.fbcdn.net/v/t39.30808-6/299853964_609061554186723_1300273112549399377_n.png?_nc_cat=108&ccb=1-7&_nc_sid=cc71e4&_nc_ohc=ac4MsQ-FTGYQ7kNvgECPSpC&_nc_zt=23&_nc_ht=scontent.fdkr7-1.fna&_nc_gid=ARKZAVkBLIVGpBZi4_8Yxdo&oh=00_AYD_nGh-s71dJ9LYAf5jj7S8VcCB7EIFE9ePvbWNdWhhEA&oe=672FC4D4', width: 400, height: 200,),
        const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("A l’air du numérique ou les logiciels et les applications font parties de notre environnement quotidien, ILAMMEDIA propose aux entreprises des solutions innovantes qui vont les aider à optimiser leur productions ou à les mieux valoriser leurs produits ou services. Acteur majeur du conseil dans l’informatique pour les entreprises, ILAMMEDIA accompagne de grands groupes et filiales du secteur industriel tout au long de leurs projets et les a aidés à optimiser et valoriser leurs productions. Les intervenants de ILAMMEDIA sont capables de gérer vos projets (étude, conception, déploiement et mis en service, formation, accompagnement et maintenance). Et en s’adaptant à votre environnement technologique, fonctionnel et métier. Chez ILAMMEDIA, nous élaborant des applications qui répondent parfaitement à vos attente et a vos besoins. Nos principaux atouts concernent la réalisation d'applications sur-mesure. Que ce soit au niveau de l'analyse fonctionnel, de la planification, du développement, des tests, de la mise en place, du suivi ou transfert de compétences vous trouverez chez ILAMMEDIA les skills et la rigueur nécessaire. La maîtrise de plusieurs outils de programmation et de développement ainsi que des bases de données et les Framework nous permettent de proposer à nos clients la solution la plus optimale et la plus adaptée a leurs besoins.")
        ),
      ],

    )
    );
  }

}