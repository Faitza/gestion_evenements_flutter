// IMPORTATIONS
import 'package:flutter/material.dart'; // Importe la bibliothèque Material pour les widgets de l'interface utilisateur.
import '../data/mock_data.dart'; // Importe les données de simulation (utilisateurs, événements, couleurs).
import 'add_event_screen.dart'; // Importe l'écran pour ajouter un événement.
import 'events_screen.dart'; // Importe l'écran qui affiche la liste des événements.
import 'login_screen.dart'; // Importe l'écran de connexion.

// ========================================================
// PANNEAU ADMIN
// ========================================================
// Définit un widget avec état pour l'écran du panneau d'administration.
class AdminPanelScreen extends StatefulWidget {
  // Constructeur du widget.
  const AdminPanelScreen({Key? key}) : super(key: key);

  @override
  // Crée l'état mutable pour ce widget.
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

// Classe d'état pour le widget AdminPanelScreen.
class _AdminPanelScreenState extends State<AdminPanelScreen> {
  // Variable pour suivre l'index de l'onglet actuellement sélectionné dans la barre de navigation.
  int _selectedIndex = 0;

  // Liste des widgets (écrans) à afficher en fonction de l'index sélectionné.
  final List<Widget> _screens = [
    const AdminHomeContent(), // Le contenu de l'écran d'accueil de l'admin.
    const EventsScreen(isAdmin: true), // L'écran de la liste des événements, en mode admin.
    const AddEventScreen(), // L'écran pour ajouter un nouvel événement.
  ];

  // ========================================================
  // FONCTION POUR CONFIRMER LA DECONNEXION
  // ========================================================
  // Méthode asynchrone pour afficher une boîte de dialogue de confirmation avant de se déconnecter.
  Future<void> _confirmLogout() async {
    // Affiche la boîte de dialogue et attend que l'utilisateur fasse un choix.
    final confirm = await showDialog<bool>(
      context: context, // Le contexte de build actuel.
      builder: (context) => AlertDialog( // Construit la boîte de dialogue d'alerte.
        title: const Text("Confirmation"), // Le titre de la boîte de dialogue.
        content: const Text("Voulez-vous vraiment vous déconnecter ?"), // Le message de confirmation.
        shape: RoundedRectangleBorder( // Définit la forme de la boîte de dialogue.
          borderRadius: BorderRadius.circular(15), // Coins arrondis.
        ),
        actions: [ // Liste des boutons d'action.
          TextButton( // Un bouton avec un texte simple.
            onPressed: () => Navigator.pop(context, false), // Ferme la dialogue et retourne 'false'.
            child: const Text(
              "Annuler", // Texte du bouton.
              style: TextStyle(color: Colors.grey), // Style du texte.
            ),
          ),
          ElevatedButton( // Un bouton avec une élévation.
            onPressed: () => Navigator.pop(context, true), // Ferme la dialogue et retourne 'true'.
            style: ElevatedButton.styleFrom( // Style du bouton.
              backgroundColor: AppColors.mauve, // Couleur de fond.
            ),
            child: const Text("Oui"), // Texte du bouton.
          ),
        ],
      ),
    );

    // SI L'UTILISATEUR A CONFIRMÉ (cliqué sur "Oui")
    if (confirm == true) {
      // EFFACE L'UTILISATEUR ACTUEL
      currentUser = null; // Réinitialise la variable globale de l'utilisateur connecté.

      // RETOURNE VERS L'ÉCRAN DE CONNEXION
      // Navigue vers l'écran de connexion et supprime toutes les routes précédentes de l'historique.
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,  // Cette condition supprime toutes les routes existantes.
      );
    }
  }

  @override
  // Méthode qui construit l'interface utilisateur du widget.
  Widget build(BuildContext context) {
    // Retourne un Scaffold, la structure de base pour un écran Material Design.
    return Scaffold(
      backgroundColor: AppColors.blancRose, // Définit la couleur de fond de l'écran.
      appBar: AppBar( // La barre d'application en haut.
        title: Text(_getTitle()), // Le titre de l'AppBar, déterminé par la méthode _getTitle.
        actions: [ // Widgets affichés à droite du titre.
          IconButton( // Un bouton avec une icône.
            icon: const Icon(Icons.logout), // L'icône de déconnexion.
            onPressed: _confirmLogout,  // ✅ Appelle la fonction de confirmation lors du clic.
          ),
        ],
      ),
      body: _screens[_selectedIndex], // Le corps de l'écran affiche le widget correspondant à l'index sélectionné.
      bottomNavigationBar: BottomNavigationBar( // La barre de navigation en bas de l'écran.
        currentIndex: _selectedIndex, // L'onglet actuellement actif.
        onTap: (index) { // Fonction appelée lorsqu'un onglet est touché.
          setState(() { // Met à jour l'état pour reconstruire le widget avec le nouvel index.
            _selectedIndex = index; // Met à jour l'index sélectionné.
          });
        },
        type: BottomNavigationBarType.fixed, // Le type de la barre, 'fixed' signifie que tous les onglets sont visibles.
        selectedItemColor: AppColors.mauve, // La couleur de l'icône et du libellé de l'onglet sélectionné.
        unselectedItemColor: Colors.grey, // La couleur des onglets non sélectionnés.
        items: const [ // La liste des onglets (items) de la barre de navigation.
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'), // Onglet Accueil.
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Événements'), // Onglet Événements.
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Ajouter'), // Onglet Ajouter.
        ],
      ),
    );
  }

  // Méthode pour obtenir le titre de l'AppBar en fonction de l'onglet sélectionné.
  String _getTitle() {
    switch (_selectedIndex) { // Évalue l'index de l'onglet sélectionné.
      case 0:
        return 'Accueil Admin'; // Titre pour l'onglet 0.
      case 1:
        return 'Gérer événements'; // Titre pour l'onglet 1.
      case 2:
        return 'Ajouter'; // Titre pour l'onglet 2.
      default:
        return 'Admin'; // Titre par défaut.
    }
  }
}

// ========================================================
// CONTENU ACCUEIL ADMIN
// ========================================================
// Définit un widget avec état pour le contenu de la page d'accueil de l'admin.
class AdminHomeContent extends StatefulWidget {
  // Constructeur.
  const AdminHomeContent({Key? key}) : super(key: key);

  @override
  // Crée l'état mutable pour ce widget.
  State<AdminHomeContent> createState() => _AdminHomeContentState();
}

// Classe d'état pour le widget AdminHomeContent.
class _AdminHomeContentState extends State<AdminHomeContent> {
  @override
  // Construit l'interface utilisateur pour ce widget.
  Widget build(BuildContext context) {
    return Center( // Centre son contenu.
      child: SingleChildScrollView(  // ✅ Permet de faire défiler le contenu si l'écran est trop petit, pour éviter les erreurs de dépassement.
        child: Column( // Organise ses enfants en une colonne verticale.
          mainAxisAlignment: MainAxisAlignment.center, // Centre les enfants verticalement.
          children: [
            ClipRRect( // Un widget qui coupe son enfant en utilisant un rectangle arrondi.
              borderRadius: BorderRadius.circular(20), // Rayon des coins.
              child: Image.network( // Affiche une image depuis une URL.
                "https://i.pinimg.com/736x/e8/08/40/e80840ac36efebf5128b3e2b9e203a56.jpg",
                height: 180, // Hauteur de l'image.
                width: 300, // Largeur de l'image.
                fit: BoxFit.cover, // Fait en sorte que l'image couvre tout l'espace disponible.
                errorBuilder: (context, error, stackTrace) { // Widget à afficher si l'image ne se charge pas.
                  return Container( // Un conteneur pour afficher une icône d'erreur.
                    height: 180,
                    width: 300,
                    decoration: BoxDecoration(
                      color: AppColors.mauveClair.withOpacity(0.3), // Couleur de fond.
                      borderRadius: BorderRadius.circular(20), // Coins arrondis.
                    ),
                    child: const Icon( // L'icône d'image cassée.
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20), // Crée un espace vertical.

            Icon( // Une icône.
              Icons.admin_panel_settings, // L'icône du panneau d'administration.
              size: 80, // Taille de l'icône.
              color: AppColors.mauve, // Couleur de l'icône.
            ),

            const SizedBox(height: 20), // Espace vertical.

            const Text( // Un widget de texte.
              'Bienvenue Administrateur',
              style: TextStyle(
                fontSize: 24, // Taille de la police.
                fontWeight: FontWeight.bold, // Épaisseur de la police (gras).
              ),
              textAlign: TextAlign.center, // Centre le texte horizontalement.
            ),

            const SizedBox(height: 10), // Espace vertical.

            Text( // Un widget de texte qui affiche le nombre total d'événements.
              'Total: ${mockEvents.length} événements', // Interpole la longueur de la liste mockEvents.
              style: TextStyle(
                fontSize: 18,
                color: AppColors.mauve,
              ),
            ),

            const SizedBox(height: 30), // Espace vertical.

            ElevatedButton( // Un bouton avec élévation.
              onPressed: () async { // Fonction asynchrone appelée au clic.
                // Navigue vers l'écran d'ajout d'événement et attend un résultat.
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddEventScreen(),
                  ),
                );

                // Si l'écran d'ajout retourne 'true' (ce qui signifie qu'un événement a été ajouté).
                if (result == true) {
                  setState(() {}); // Met à jour l'état de ce widget (AdminHomeContent) pour rafraîchir le nombre d'événements.

                  // Trouve l'état du widget parent AdminPanelScreen.
                  final adminState = context.findAncestorStateOfType<_AdminPanelScreenState>();

                  // Si l'état du parent est trouvé.
                  if (adminState != null) {
                    // Met à jour l'état du parent pour changer l'onglet sélectionné.
                    adminState.setState(() {
                      adminState._selectedIndex = 1; // Change l'onglet pour celui des "Événements".
                    });
                  }
                }
              },
              child: const Text( // Texte du bouton.
                'Ajouter un événement',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
