// IMPORTATIONS
import 'package:flutter/material.dart'; // Importe la bibliothèque Material pour les widgets de l'interface utilisateur.
import '../data/mock_data.dart'; // Importe les données simulées, probablement pour accéder aux couleurs (AppColors).

// ========================================================
// BARRE DE RECHERCHE
// ========================================================
// Définit un widget sans état (StatelessWidget) pour la barre de recherche.
class SearchBar extends StatelessWidget {
  // Une fonction de rappel (callback) qui sera appelée chaque fois que le texte dans le champ de recherche change.
  // Elle prend une chaîne de caractères (la nouvelle valeur du texte) en argument.
  final Function(String)? onChanged;

  // Constructeur du widget SearchBar.
  // Il prend en paramètre optionnel la fonction onChanged.
  const SearchBar({Key? key, this.onChanged}) : super(key: key);

  @override
  // Méthode qui construit l'interface utilisateur du widget.
  Widget build(BuildContext context) {
    // Utilise un widget Padding pour ajouter un espace autour du champ de texte.
    return Padding(
      // Définit un remplissage de 16 pixels sur tous les côtés.
      padding: const EdgeInsets.all(16),
      // Le widget principal est un TextField, qui est un champ de saisie de texte.
      child: TextField(
        // Associe la fonction de rappel 'onChanged' à l'événement de changement de texte du TextField.
        onChanged: onChanged,
        // La décoration (style) du champ de texte.
        decoration: InputDecoration(
          // Texte indicatif affiché à l'intérieur du champ lorsqu'il est vide.
          hintText: 'Rechercher un événement...',
          // Une icône affichée avant le texte (à gauche).
          prefixIcon: const Icon(Icons.search, color: AppColors.mauve),
          // La bordure du champ de texte.
          border: OutlineInputBorder(
            // Définit des coins arrondis pour la bordure.
            borderRadius: BorderRadius.circular(12),
          ),
          // Indique que le champ de décoration doit être rempli avec une couleur.
          filled: true,
          // La couleur de fond du champ de texte.
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
