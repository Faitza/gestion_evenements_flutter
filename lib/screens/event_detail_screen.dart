// IMPORTATIONS
import 'package:flutter/material.dart'; // Importe la bibliothèque Material de Flutter pour les widgets d'interface utilisateur.
import '../models/event.dart'; // Importe le modèle de données Event.
import '../data/mock_data.dart'; // Importe les données de simulation, y compris les couleurs de l'application.

// ========================================================
// ÉCRAN DÉTAILS D'UN ÉVÉNEMENT
// ========================================================
// Définit un widget sans état pour afficher les détails d'un événement.
class EventDetailScreen extends StatelessWidget {
  final Event event; // Déclare une variable finale pour contenir les données de l'événement.

  // Constructeur pour l'écran de détail de l'événement, requiert un objet Event.
  const EventDetailScreen({Key? key, required this.event}) : super(key: key);

  @override
  // Construit l'interface utilisateur du widget.
  Widget build(BuildContext context) {
    // Retourne un widget Scaffold qui fournit une structure d'écran de base.
    return Scaffold(
      backgroundColor: AppColors.blancRose, // Définit la couleur de fond de l'écran.
      appBar: AppBar( // Définit la barre d'application en haut de l'écran.
        title: Text( // Définit le titre de la barre d'application.
          event.title, // Utilise le titre de l'événement comme texte.
          style: const TextStyle(fontSize: 18), // Style du texte du titre.
        ),
        backgroundColor: AppColors.mauve, // Définit la couleur de fond de la barre d'application.
        foregroundColor: Colors.white, // Définit la couleur des éléments de premier plan (titre, icônes) de la barre d'application.
      ),
      body: SingleChildScrollView( // Permet au contenu de défiler si l'écran est trop petit.
        child: Column( // Organise ses enfants dans une colonne verticale.
          crossAxisAlignment: CrossAxisAlignment.start, // Aligne les enfants au début de l'axe transversal.
          children: [ // Liste des widgets enfants.
            // ================================================
            // 1. GRANDE IMAGE D'EN-TÊTE
            // ================================================
            Container( // Un conteneur pour l'image d'en-tête.
              height: 250, // Définit la hauteur du conteneur.
              width: double.infinity, // Fait en sorte que le conteneur prenne toute la largeur disponible.
              decoration: BoxDecoration( // Décore la boîte du conteneur.
                gradient: LinearGradient( // Crée un dégradé de couleurs comme fond.
                  begin: Alignment.topLeft, // Point de départ du dégradé.
                  end: Alignment.bottomRight, // Point de fin du dégradé.
                  colors: [AppColors.mauve, AppColors.rosePale], // Les couleurs du dégradé.
                ),
              ),
              child: Stack( // Empile les widgets les uns sur les autres.
                children: [ // Liste des widgets enfants de la pile.
                  // Affiche l'image de l'événement si une URL est disponible.
                  if (event.imageUrl != null)
                    Positioned.fill( // Positionne son enfant pour remplir la pile.
                      child: Image.network( // Affiche une image depuis une URL réseau.
                        event.imageUrl!, // L'URL de l'image (l'opérateur '!' suppose qu'elle n'est pas nulle ici).
                        fit: BoxFit.cover, // Redimensionne l'image pour couvrir toute la boîte.
                        errorBuilder: (context, error, stackTrace) { // Widget à construire en cas d'erreur de chargement de l'image.
                          return Center( // Centre son enfant.
                            child: Icon( // Affiche une icône.
                              Icons.broken_image, // L'icône d'image cassée.
                              size: 80, // La taille de l'icône.
                              color: Colors.white.withOpacity(0.5), // La couleur de l'icône avec opacité.
                            ),
                          );
                        },
                      ),
                    )
                  else // Sinon, si aucune URL d'image n'est fournie.
                    Center( // Centre son enfant.
                      child: Icon( // Affiche une icône d'événement par défaut.
                        Icons.event,
                        size: 100,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),

                  // Superpose un dégradé en bas de l'image pour que le texte soit lisible.
                  Positioned(
                    bottom: 0, // Aligne en bas.
                    left: 0, // Aligne à gauche.
                    right: 0, // Aligne à droite.
                    child: Container(
                      height: 100, // Hauteur du dégradé.
                      decoration: BoxDecoration(
                        gradient: LinearGradient( // Dégradé du noir vers le transparent.
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Affiche le titre de l'événement et la date par-dessus l'image.
                  Positioned(
                    bottom: 20, // Positionné à 20 pixels du bas.
                    left: 20, // Positionné à 20 pixels de la gauche.
                    child: Column( // Organise le titre et la date verticalement.
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text( // Le titre de l'événement.
                          event.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4), // Espace vertical.
                        Row( // Organise l'icône de calendrier et la date horizontalement.
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
                            const SizedBox(width: 8), // Espace horizontal.
                            Text( // La date de l'événement.
                              event.date,
                              style: const TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ================================================
            // 2. INFORMATIONS PRINCIPALES
            // ================================================
            Padding( // Ajoute un remplissage autour de son enfant.
              padding: const EdgeInsets.all(20),
              child: Column( // Organise les informations verticalement.
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Carte pour afficher le lieu.
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mauve.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row( // Organise l'icône et le texte du lieu horizontalement.
                      children: [
                        Container( // Conteneur stylisé pour l'icône.
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.mauve.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: AppColors.mauve,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16), // Espace horizontal.
                        Expanded( // Permet à la colonne de texte de prendre l'espace restant.
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text( // Libellé "Lieu".
                                'Lieu',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4), // Espace vertical.
                              Text( // Le lieu de l'événement.
                                event.location,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16), // Espace vertical.

                  // Carte pour afficher la date.
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mauve.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row( // Organise l'icône et le texte de la date horizontalement.
                      children: [
                        Container( // Conteneur stylisé pour l'icône.
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.rosePale.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            color: AppColors.mauve,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16), // Espace horizontal.
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text( // Libellé "Date".
                                'Date',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4), // Espace vertical.
                              Text( // La date de l'événement.
                                event.date,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20), // Espace vertical.

                  // Titre de la section "Description".
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10), // Espace vertical.

                  // Conteneur pour le texte de la description.
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mauve.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text( // Le texte de la description de l'événement.
                      event.description,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5, // Hauteur de ligne pour une meilleure lisibilité.
                      ),
                    ),
                  ),

                  const SizedBox(height: 30), // Espace vertical.

                  // Bouton pour revenir à l'écran précédent.
                  Center( // Centre le bouton.
                    child: ElevatedButton.icon(
                      onPressed: () { // Action à exécuter lors du clic.
                        Navigator.pop(context); // Ferme l'écran actuel et revient au précédent.
                      },
                      icon: const Icon(Icons.arrow_back), // Icône du bouton.
                      label: const Text('Retour'), // Texte du bouton.
                      style: ElevatedButton.styleFrom( // Style du bouton.
                        backgroundColor: Colors.white, // Couleur de fond du bouton.
                        foregroundColor: AppColors.mauve, // Couleur du texte et de l'icône.
                        side: BorderSide(color: AppColors.mauve), // Bordure du bouton.
                        minimumSize: const Size(200, 50), // Taille minimale du bouton.
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
