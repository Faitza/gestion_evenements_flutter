// IMPORTATIONS
import 'package:flutter/material.dart'; // Importe la bibliothèque Material pour les widgets de base de l'interface utilisateur.
import '../data/mock_data.dart'; // Importe les données simulées (événements, couleurs).
import '../models/event.dart'; // Importe le modèle de données pour un événement.
import '../widgets/search_bar.dart'; // Importe un widget de barre de recherche personnalisé (semble ne pas être utilisé ici).
import '../widgets/event_card.dart'; // Importe le widget personnalisé pour afficher une carte d'événement.
import 'edit_event_screen.dart'; // Importe l'écran de modification d'événement.
import 'event_detail_screen.dart';  // ✅ AJOUTE SA -> Importe l'écran de détail d'un événement.

// ========================================================
// ÉCRAN LISTE ÉVÉNEMENTS AVEC VUE LISTE/GRID
// ========================================================
// Définit un widget avec état pour afficher la liste des événements.
class EventsScreen extends StatefulWidget {
  // Un booléen pour déterminer si l'utilisateur est un administrateur.
  final bool isAdmin;

  // Constructeur qui requiert la valeur de isAdmin.
  const EventsScreen({Key? key, required this.isAdmin}) : super(key: key);

  @override
  // Crée l'état mutable pour ce widget.
  _EventsScreenState createState() => _EventsScreenState();
}

// Classe d'état pour le widget EventsScreen.
class _EventsScreenState extends State<EventsScreen> {
  // Chaîne de caractères pour stocker la requête de recherche de l'utilisateur.
  String _searchQuery = '';
  // Booléen pour basculer entre la vue en grille (true) et la vue en liste (false).
  bool _isGridView = false;

  // Getter qui retourne une liste d'événements filtrée en fonction de la requête de recherche.
  List<Event> get filteredEvents {
    // Retourne la liste des événements simulés (mockEvents).
    return mockEvents.where((event) {
      // Filtre les événements dont le titre (en minuscules) contient la requête de recherche (en minuscules).
      return event.title
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
    }).toList(); // Convertit le résultat itérable en une liste.
  }

  @override
  // Construit l'interface utilisateur du widget.
  Widget build(BuildContext context) {
    // Utilise une colonne pour organiser verticalement la barre de recherche et la liste des événements.
    return Column(
      children: [
        // Ajoute un remplissage autour de la barre de recherche et du bouton de vue.
        Padding(
          padding: const EdgeInsets.all(16),
          // Utilise une rangée pour organiser horizontalement la barre de recherche et le bouton.
          child: Row(
            children: [
              // Le champ de recherche prend 4/5 de l'espace.
              Expanded(
                flex: 4,
                // Un conteneur pour styliser le champ de texte.
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Fond blanc.
                    borderRadius: BorderRadius.circular(12), // Coins arrondis.
                    boxShadow: [ // Ombre portée subtile.
                      BoxShadow(
                        color: AppColors.mauve.withOpacity(0.1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  // Le champ de texte pour la saisie de la recherche.
                  child: TextField(
                    onChanged: (value) { // Se déclenche à chaque modification du texte.
                      setState(() { // Met à jour l'état pour reconstruire le widget avec la nouvelle requête.
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Rechercher...', // Texte d'aide affiché lorsque le champ est vide.
                      prefixIcon: Icon(Icons.search, color: AppColors.mauve), // Icône de recherche à gauche.
                      border: InputBorder.none, // Aucune bordure visible.
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), // Remplissage interne.
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8), // Espace horizontal entre les deux éléments.

              // Le bouton de changement de vue prend 1/5 de l'espace.
              Expanded(
                flex: 1,
                // Un conteneur pour styliser le bouton.
                child: Container(
                  height: 50, // Hauteur fixe.
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mauve.withOpacity(0.1),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  // Le bouton avec une icône.
                  child: IconButton(
                    icon: Icon(
                      _isGridView ? Icons.list : Icons.grid_view, // Change l'icône en fonction de l'état de _isGridView.
                      color: AppColors.mauve, // Couleur de l'icône.
                    ),
                    onPressed: () { // Action déclenchée au clic.
                      setState(() { // Met à jour l'état.
                        _isGridView = !_isGridView; // Inverse la valeur du booléen de la vue grille.
                      });
                    },
                    tooltip: _isGridView ? 'Vue liste' : 'Vue grille', // Info-bulle qui apparaît lors d'un appui long.
                  ),
                ),
              ),
            ],
          ),
        ),

        // Le reste de l'espace est occupé par la liste ou la grille d'événements.
        Expanded(
          // Vérifie si la liste des événements filtrés est vide.
          child: filteredEvents.isEmpty
              // Si c'est vide, affiche un message "Aucun événement disponible".
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy, // Icône d'événement non disponible.
                  size: 64,
                  color: AppColors.mauve.withOpacity(0.3), // Couleur de l'icône avec opacité.
                ),
                const SizedBox(height: 16), // Espace vertical.
                const Text(
                  'Aucun événement disponible',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
              // Si la liste n'est pas vide, vérifie quelle vue est sélectionnée.
              : _isGridView
              ? _buildGridView() // Si _isGridView est vrai, construit la vue en grille.
              : _buildListView(), // Sinon, construit la vue en liste.
        ),
      ],
    );
  }

  // Widget qui construit la vue en liste.
  Widget _buildListView() {
    // Utilise ListView.builder pour construire les éléments de la liste de manière performante.
    return ListView.builder(
      padding: const EdgeInsets.all(8), // Remplissage autour de la liste.
      itemCount: filteredEvents.length, // Le nombre total d'éléments dans la liste.
      itemBuilder: (context, index) { // La fonction qui construit chaque élément.
        final event = filteredEvents[index]; // Récupère l'événement à l'index actuel.

        // Utilise le widget EventCard pour afficher les informations de l'événement.
        return EventCard(
          event: event,
          isAdmin: widget.isAdmin,
          onTap: widget.isAdmin
              // Si c'est un admin, la navigation se fait vers l'écran de modification.
              ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditEventScreen(event: event),
              ),
            ).then((_) => setState(() {})); // Met à jour l'état au retour pour refléter les changements.
          }
              // Si c'est un client, la navigation se fait vers l'écran de détail.
              : () {
            // ✅ CLIENT: ALE VERS PAGE DETAY
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailScreen(event: event),
              ),
            );
          },
        );
      },
    );
  }

  // Widget qui construit la vue en grille.
  Widget _buildGridView() {
    // Utilise GridView.builder pour construire les éléments de la grille.
    return GridView.builder(
      padding: const EdgeInsets.all(8), // Remplissage autour de la grille.
      // Définit la disposition de la grille.
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 éléments par ligne.
        childAspectRatio: 0.75, // Ratio largeur/hauteur de chaque élément.
        crossAxisSpacing: 8, // Espace horizontal entre les éléments.
        mainAxisSpacing: 8, // Espace vertical entre les éléments.
      ),
      itemCount: filteredEvents.length, // Nombre total d'éléments.
      itemBuilder: (context, index) { // Fonction qui construit chaque élément.
        final event = filteredEvents[index]; // Récupère l'événement à l'index actuel.

        // Utilise un GestureDetector pour rendre chaque carte de la grille cliquable.
        return GestureDetector(
          onTap: widget.isAdmin
              // Si c'est un admin, navigue vers l'écran de modification.
              ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditEventScreen(event: event),
              ),
            ).then((_) => setState(() {})); // Met à jour l'état au retour.
          }
              // Si c'est un client, navigue vers l'écran de détail.
              : () {
            // ✅ CLIENT: ALE VERS PAGE DETAY
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailScreen(event: event),
              ),
            );
          },
          // Le contenu visuel de la carte de la grille.
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            // Colonne pour organiser l'image et le texte de la carte.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Conteneur pour l'image ou l'icône de l'événement.
                Container(
                  height: 100, // Hauteur fixe.
                  width: double.infinity, // Occupe toute la largeur.
                  decoration: BoxDecoration(
                    color: AppColors.mauveClair.withOpacity(0.3),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12), // Coins arrondis seulement en haut.
                    ),
                  ),
                  child: Center( // Centre l'icône.
                    child: Icon(
                      Icons.event,
                      size: 40,
                      color: AppColors.mauve.withOpacity(0.5),
                    ),
                  ),
                ),
                // Remplissage pour le contenu textuel de la carte.
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Affiche le titre de l'événement.
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2, // Limite à 2 lignes.
                        overflow: TextOverflow.ellipsis, // Ajoute "..." si le texte dépasse.
                      ),
                      const SizedBox(height: 4), // Espace vertical.
                      // Affiche la date.
                      Text(
                        event.date,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 2), // Espace vertical.
                      // Affiche le lieu.
                      Text(
                        event.location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 1, // Limite à 1 ligne.
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Affiche un badge "Modifier" si l'utilisateur est un admin.
                      if (widget.isAdmin) ...[
                        const SizedBox(height: 8), // Espace vertical.
                        // Conteneur pour le badge.
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.mauve.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          // Rangée pour l'icône et le texte du badge.
                          child: const Row(
                            mainAxisSize: MainAxisSize.min, // La rangée prend la taille minimale nécessaire.
                            children: [
                              Icon(Icons.edit, size: 12, color: AppColors.mauve),
                              SizedBox(width: 4),
                              Text(
                                'Modifier',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.mauve,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
