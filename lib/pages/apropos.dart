import 'package:flutter/material.dart';

class AproposPage extends StatelessWidget{
  const AproposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text("A propos de Digitrest Consulting"), elevation: 12),
    // Utilisation de Container permet de 
    body: Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      height: 200,
      width: 400,
      decoration: BoxDecoration(
        // color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(10)
      ),
      child: const Text("Depuis un certain temps, on a pu constater la floraison dâ€™un nouveau phénoméne de livraison entre particulier et livreur nommé à « coursier à  moto». Ce phénoméne étant un peu informel a attiré mon attention sur comment gérer au mieux cette activité en capitalisant les ressources et en proposant plus de choix aux utilisateurs. Solution : Une première idÃ©e qui mâ€™est venu en tÃªte est de mettre en place une plateforme de mise en relation entre les usagers et les livreurs. En effet, en observant ce phénomène, j'ai pu constater que les livreurs sont souvent des jeunes disposant de moyen de transport et voulant arrondir leur fin de mois moyennant des cours de livraison qu'il font et qui sont rémunérées. Ainsi, leur propos de s'inscrire sur cette plateforme leur permettra d'avoir plus de visibilitÃ© et d'augmenter leur chance de gagner de l'argent. D'autre part, le client en ayant cette application installé sur leur téléphone ou bien sur la plateforme web (site) peuvent avoir plus de choix, visité les profils des livreurs et choisir celui qui lui convient. A la fin de la course, il peut émettre un avis ce qui participera à l'évolution du profil du livreur. Dans une phase de test, l'application mettra, juste en relation le client et le livreur et donc ne gérera pas l'aspect paiement. Celui-ci se fera comme dâ€™habitude en main propre. Application mobile disponible sur Android et IPhone. ")),
      floatingActionButton: FloatingActionButton(
      onPressed: (){
        // Demande à DART de raffraichir l'interface utilisateur 
        
      },
      child: const Icon(Icons.add),
      ),
   );
  }

}