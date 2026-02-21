// IMPORTATIONS
import 'package:flutter/material.dart'; // Importe la bibliothèque Material pour les widgets de base.
import '../models/event.dart'; // Importe le modèle de données pour un objet Event.
import '../data/mock_data.dart'; // Importe les données simulées, notamment les couleurs.

// ========================================================
// CARTE POUR AFFICHER UN ÉVÉNEMENT (VERSION LISTE)
// ========================================================
// Définit un widget sans état pour afficher les informations d'un événement sous forme de carte.
class EventCard extends StatelessWidget {
  // L'objet événement à afficher dans la carte.
  final Event event;
  // Une fonction de rappel (callback) optionnelle à exécuter lors d'un appui sur la carte.
  final VoidCallback? onTap;
  // Un booléen pour indiquer si la vue est celle d'un administrateur.
  final bool isAdmin;

  // Constructeur du widget.
  const EventCard({
    Key? key, // Clé optionnelle pour le widget.
    required this.event, // L'événement est requis.
    this.onTap, // Le callback onTap est optionnel.
    this.isAdmin = false, // Par défaut, la vue n'est pas celle d'un administrateur.
  }) : super(key: key);

  @override
  // Méthode qui construit l'interface utilisateur du widget.
  Widget build(BuildContext context) {
    // Retourne un widget Card, qui est un panneau Material avec une légère élévation.
    return Card(
      // Marge horizontale et verticale autour de la carte.
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // Définit la forme de la carte avec des coins arrondis.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      // L'élévation (ombre) de la carte.
      elevation: 2,
      // Le contenu de la carte est un ListTile, qui est une ligne de hauteur fixe.
      child: ListTile(
        // Le widget affiché au début (à gauche) du ListTile.
        leading: Container(
          width: 50, // Largeur du conteneur.
          height: 50, // Hauteur du conteneur.
          // Décoration du conteneur (couleur de fond, coins arrondis).
          decoration: BoxDecoration(
            color: AppColors.mauveClair.withOpacity(0.3), // Couleur mauve clair semi-transparente.
            borderRadius: BorderRadius.circular(8), // Coins arrondis.
          ),
          // L'icône affichée à l'intérieur du conteneur.
          child: const Icon(
            Icons.event, // Icône d'événement standard.
            color: AppColors.mauve, // Couleur de l'icône.
            size: 30, // Taille de l'icône.
          ),
        ),
        // Le widget principal du ListTile, généralement un texte.
        title: Text(
          event.title, // Le titre de l'événement.
          // Style du texte du titre.
          style: const TextStyle(
            fontWeight: FontWeight.bold, // Police en gras.
            fontSize: 16, // Taille de la police.
          ),
        ),
        // Le widget affiché sous le titre.
        subtitle: Column(
          // Aligne les enfants au début (à gauche) de la colonne.
          crossAxisAlignment: CrossAxisAlignment.start,
          // La liste des widgets enfants de la colonne.
          children: [
            // Texte affichant la date et le lieu de l'événement.
            Text(
              '${event.date} - ${event.location}',
              style: const TextStyle(fontSize: 14), // Style du texte.
            ),
            // Un petit espace vertical.
            const SizedBox(height: 4),
            // Texte affichant la description de l'événement.
            Text(
              event.description,
              style: const TextStyle(fontSize: 12), // Style du texte.
              maxLines: 1, // Limite le texte à une seule ligne.
              overflow: TextOverflow.ellipsis, // Affiche "..." si le texte dépasse.
            ),
          ],
        ),
        // Le widget affiché à la fin (à droite) du ListTile.
        trailing: isAdmin
            // Si l'utilisateur est un administrateur, affiche une icône de modification.
            ? const Icon(
          Icons.edit,
          color: AppColors.mauve,
        )
        // Sinon, n'affiche rien.
            : null,
        // La fonction à appeler lorsque l'utilisateur appuie sur le ListTile.
        onTap: onTap,
      ),
    );
  }
}
