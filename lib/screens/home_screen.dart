// ========================================================
// IMPORTATIONS
// ========================================================
// Importe la bibliothèque Material pour les widgets de l'interface utilisateur.
import 'package:flutter/material.dart';
// Importe les données simulées (mock data), y compris la liste des événements et les couleurs.
import '../data/mock_data.dart';
// Importe l'écran qui affiche la liste des événements.
import 'events_screen.dart';
// Importe l'écran de connexion.
import 'login_screen.dart';

// ========================================================
// HOME SCREEN
// ========================================================
// Définit un widget avec état pour l'écran d'accueil principal.
class HomeScreen extends StatefulWidget {
  // Constructeur du widget.
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // Crée l'état mutable pour ce widget.
  _HomeScreenState createState() => _HomeScreenState();
}

// Classe d'état pour le widget HomeScreen.
class _HomeScreenState extends State<HomeScreen> {
  // Variable pour suivre l'index de l'onglet actuellement sélectionné dans la barre de navigation.
  int _selectedIndex = 0;

  // Liste des widgets (écrans) à afficher en fonction de l'index sélectionné.
  final List<Widget> _screens = [
    const HomeContent(), // Contenu de l'écran d'accueil.
    const EventsScreen(isAdmin: false), // Écran de la liste des événements pour un client.
  ];

  // ========================================================
  // CONFIRMATION LOGOUT
  // ========================================================
  // Méthode asynchrone pour afficher une boîte de dialogue de confirmation avant de se déconnecter.
  Future<void> _confirmLogout() async {
    // Affiche la boîte de dialogue et attend que l'utilisateur fasse un choix.
    final confirm = await showDialog(
      context: context, // Le contexte de build actuel.
      builder: (context) => AlertDialog( // Construit la boîte de dialogue.
        title: const Text("Confirmation"), // Le titre de la dialogue.
        content: const Text("Voulez vous vraiment deconnecter ?"), // Le message de confirmation.
        actions: [ // Liste des boutons d'action.
          // Bouton pour annuler la déconnexion.
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Ferme la dialogue et retourne 'false'.
            child: const Text("Annuler"), // Texte du bouton.
          ),
          // Bouton pour confirmer la déconnexion.
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true), // Ferme la dialogue et retourne 'true'.
            child: const Text("Oui"), // Texte du bouton.
          ),
        ],
      ),
    );

    // Si l'utilisateur a confirmé la déconnexion (a cliqué sur "Oui").
    if (confirm == true) {
      // Réinitialise la variable globale de l'utilisateur connecté à null.
      currentUser = null;

      // Navigue vers l'écran de connexion et supprime toutes les routes précédentes de l'historique.
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false, // Ce prédicat supprime toutes les routes existantes.
      );
    }
  }

  // ========================================================
  // UI (Interface Utilisateur)
  // ========================================================
  @override
  // Méthode qui construit l'interface utilisateur du widget.
  Widget build(BuildContext context) {
    // Retourne un Scaffold, la structure de base pour un écran Material Design.
    return Scaffold(
      appBar: AppBar( // La barre d'application en haut.
        title: const Text('Accueil'), // Le titre de l'AppBar.
        actions: [ // Widgets affichés à droite du titre.
          // Un bouton avec une icône pour se déconnecter.
          IconButton(
            icon: const Icon(Icons.logout), // L'icône de déconnexion.
            onPressed: _confirmLogout, // Appelle la méthode de confirmation de déconnexion au clic.
          ),
        ],
      ),
      // Le corps de l'écran affiche le widget correspondant à l'index sélectionné.
      body: _screens[_selectedIndex],

      // La barre de navigation en bas de l'écran.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // L'onglet actuellement actif.
        onTap: (index) { // Fonction appelée lorsqu'un onglet est touché.
          // Met à jour l'état pour reconstruire le widget avec le nouvel index.
          setState(() => _selectedIndex = index);
        },
        type: BottomNavigationBarType.fixed, // Le type de la barre, tous les onglets sont visibles et fixes.
        selectedItemColor: AppColors.mauve, // La couleur de l'icône et du libellé de l'onglet sélectionné.
        items: const [ // La liste des onglets (items) de la barre de navigation.
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'), // Onglet Accueil.
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Événements'), // Onglet Événements.
        ],
      ),
    );
  }
}

// ========================================================
// CONTENU ACCUEIL (AVEC IMAGE BACKGROUND)
// ========================================================
// Définit un widget sans état pour le contenu de la page d'accueil.
class HomeContent extends StatelessWidget {
  // Constructeur du widget.
  const HomeContent({Key? key}) : super(key: key);

  @override
  // Construit l'interface utilisateur pour ce widget.
  Widget build(BuildContext context) {
    // Utilise un Stack pour superposer les widgets les uns sur les autres.
    return Stack(
      children: [

        // ================= IMAGE DE FOND =================
        // Un conteneur pour l'image de fond.
        Container(
          decoration: const BoxDecoration( // Décoration du conteneur.
            image: DecorationImage( // Utilise une image pour la décoration.
              image: NetworkImage( // Charge une image depuis une URL réseau.
                "https://i.pinimg.com/736x/e8/08/40/e80840ac36efebf5128b3e2b9e203a56.jpg",
              ),
              fit: BoxFit.cover, // Redimensionne l'image pour couvrir tout le conteneur.
            ),
          ),
        ),

        // ================= SUPERPOSITION SOMBRE =================
        // Un conteneur pour appliquer une couleur semi-transparente par-dessus l'image.
        Container(
          color: Colors.black.withOpacity(0.55), // Couleur noire avec 55% d'opacité.
        ),

        // ================= CONTENU =================
        // Centre le contenu principal au milieu de l'écran.
        Center(
          child: Padding( // Ajoute un remplissage autour du contenu.
            padding: const EdgeInsets.all(20),
            child: Column( // Organise les widgets enfants en une colonne verticale.
              mainAxisAlignment: MainAxisAlignment.center, // Centre les enfants verticalement.
              children: [

                // Une icône d'événement disponible.
                const Icon(
                  Icons.event_available,
                  size: 90, // Taille de l'icône.
                  color: Colors.white, // Couleur de l'icône.
                ),

                const SizedBox(height: 20), // Crée un espace vertical.

                // Le texte de bienvenue.
                const Text(
                  'Bienvenue sur Gestion Événements',
                  textAlign: TextAlign.center, // Centre le texte horizontalement.
                  style: TextStyle(
                    fontSize: 26, // Taille de la police.
                    fontWeight: FontWeight.bold, // Épaisseur de la police (gras).
                    color: Colors.white, // Couleur du texte.
                  ),
                ),

                const SizedBox(height: 15), // Espace vertical.

                // Texte affichant le nombre total d'événements disponibles.
                Text(
                  '${mockEvents.length} événements disponibles',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70, // Couleur blanche avec 70% d'opacité.
                  ),
                ),

                const SizedBox(height: 30), // Espace vertical.

                // Un bouton avec une icône pour explorer les événements.
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom( // Style du bouton.
                    backgroundColor: AppColors.mauve, // Couleur de fond.
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 14), // Remplissage interne.
                    shape: RoundedRectangleBorder( // Forme du bouton.
                      borderRadius: BorderRadius.circular(25), // Coins arrondis.
                    ),
                  ),
                  icon: const Icon(Icons.event), // L'icône du bouton.
                  label: const Text( // Le texte du bouton.
                    "Explorer les événements",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () { // Action à exécuter lors du clic.
                    // Tente de changer d'onglet en utilisant DefaultTabController.
                    // Note : Ceci ne peut pas fonctionner comme prévu car ce widget n'est pas un descendant
                    // direct d'un DefaultTabController qui gère aussi la BottomNavigationBar.
                    DefaultTabController.of(context)?.animateTo(1);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
