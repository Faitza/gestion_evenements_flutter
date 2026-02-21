// IMPORTATIONS
import 'package:flutter/material.dart'; // Importe la bibliothèque Material pour les widgets de l'interface utilisateur.
import '../data/mock_data.dart'; // Importe les données simulées (utilisateurs, événements, etc.).
import '../models/user.dart'; // Importe le modèle de données pour un utilisateur.
import 'home_screen.dart'; // Importe l'écran d'accueil pour les clients.
import 'admin_panel_screen.dart'; // Importe l'écran du panneau d'administration.

// ========================================================
// ÉCRAN DE CONNEXION
// ========================================================
// Définit un widget avec état pour l'écran de connexion.
class LoginScreen extends StatefulWidget {
  // Constructeur du widget.
  const LoginScreen({Key? key}) : super(key: key);

  @override
  // Crée l'état mutable pour ce widget.
  _LoginScreenState createState() => _LoginScreenState();
}

// Classe d'état pour le widget LoginScreen.
class _LoginScreenState extends State<LoginScreen> {
  // Contrôleur pour le champ de texte du nom d'utilisateur.
  final TextEditingController _usernameController = TextEditingController();
  // Contrôleur pour le champ de texte du mot de passe.
  final TextEditingController _passwordController = TextEditingController();
  // Booléen pour gérer la visibilité du mot de passe.
  bool _isObscure = true;

  // Méthode pour gérer la logique de connexion.
  void _login() {
    // Récupère le texte du nom d'utilisateur et supprime les espaces de début et de fin.
    String username = _usernameController.text.trim();
    // Récupère le texte du mot de passe et supprime les espaces.
    String password = _passwordController.text.trim();

    // Recherche dans la liste des utilisateurs simulés (mockUsers).
    var user = mockUsers.firstWhere(
          // La condition pour trouver un utilisateur correspondant.
          (u) => u.username == username && u.password == password,
      // Si aucun utilisateur n'est trouvé, retourne un utilisateur vide.
      orElse: () => User('', '', ''),
    );

    // Vérifie si le rôle de l'utilisateur trouvé est vide (ce qui signifie qu'aucun utilisateur n'a correspondu).
    if (user.role.isEmpty) {
      // Affiche une SnackBar (barre de notification) pour informer de l'erreur.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Nom d\'utilisateur ou mot de passe incorrect'),
          backgroundColor: AppColors.rosePale, // Couleur de fond de la notification.
        ),
      );
      return; // Arrête l'exécution de la méthode.
    }

    // Si un utilisateur est trouvé, le définit comme l'utilisateur actuellement connecté.
    currentUser = user;

    // Vérifie le rôle de l'utilisateur connecté.
    if (user.role == 'admin') {
      // Si c'est un administrateur, navigue vers l'écran du panneau d'administration.
      // 'pushReplacement' remplace l'écran actuel par le nouveau, l'utilisateur ne peut pas revenir en arrière.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminPanelScreen()),
      );
    } else {
      // Si ce n'est pas un administrateur (donc un client), navigue vers l'écran d'accueil.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    }
  }

  @override
  // Méthode qui construit l'interface utilisateur du widget.
  Widget build(BuildContext context) {
    // Retourne un Scaffold, la structure de base pour un écran Material Design.
    return Scaffold(
      // Le corps de l'écran.
      body: Container(
        // Applique une décoration à l'ensemble du conteneur.
        decoration: BoxDecoration(
          // Crée un dégradé linéaire comme fond d'écran.
          gradient: LinearGradient(
            begin: Alignment.topLeft, // Point de départ du dégradé.
            end: Alignment.bottomRight, // Point de fin du dégradé.
            colors: [ // Les couleurs utilisées dans le dégradé.
              AppColors.blancRose,
              Colors.white,
              AppColors.mauveClair.withOpacity(0.3),
            ],
          ),
        ),
        // SafeArea s'assure que le contenu n'est pas masqué par des encoches ou des barres système.
        child: SafeArea(
          // Centre son enfant.
          child: Center(
            // Permet de faire défiler le contenu si l'écran est trop petit.
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24), // Applique un remplissage autour du contenu.
              // Organise les widgets enfants en une colonne verticale.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Centre les enfants verticalement.
                children: [
                  // LOGO
                  // Un conteneur pour le logo.
                  Container(
                    width: 100, // Largeur du logo.
                    height: 100, // Hauteur du logo.
                    decoration: BoxDecoration(
                      // Applique un dégradé de couleurs au logo.
                      gradient: LinearGradient(
                        colors: [AppColors.mauve, AppColors.rosePale],
                      ),
                      borderRadius: BorderRadius.circular(25), // Arrondit les coins du logo.
                    ),
                    // Affiche une icône à l'intérieur du conteneur du logo.
                    child: const Icon(
                      Icons.event,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32), // Crée un espace vertical.

                  // TITRE
                  // Affiche le titre de l'application.
                  Text(
                    'GESTION ÉVÉNEMENTS',
                    style: TextStyle(
                      fontSize: 24, // Taille de la police.
                      fontWeight: FontWeight.bold, // Police en gras.
                      color: AppColors.mauve, // Couleur du texte.
                    ),
                  ),
                  const SizedBox(height: 40), // Espace vertical.

                  // FORMULAIRE
                  // Un conteneur pour le formulaire de connexion.
                  Container(
                    padding: const EdgeInsets.all(20), // Remplissage interne du formulaire.
                    decoration: BoxDecoration(
                      color: Colors.white, // Fond blanc.
                      borderRadius: BorderRadius.circular(20), // Coins arrondis.
                      boxShadow: [ // Applique une ombre portée.
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    // Une colonne pour les champs de texte et le bouton.
                    child: Column(
                      children: [
                        // Champ de texte pour le nom d'utilisateur.
                        TextField(
                          controller: _usernameController, // Lie le champ au contrôleur.
                          decoration: InputDecoration(
                            labelText: 'Nom d\'utilisateur',
                            prefixIcon: Icon(Icons.person, color: AppColors.mauve), // Icône avant le texte.
                            border: OutlineInputBorder( // Bordure du champ.
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16), // Espace vertical.
                        // Champ de texte pour le mot de passe.
                        TextField(
                          controller: _passwordController, // Lie le champ au contrôleur.
                          obscureText: _isObscure, // Masque le texte si _isObscure est vrai.
                          decoration: InputDecoration(
                            labelText: 'Mot de passe',
                            prefixIcon: Icon(Icons.lock, color: AppColors.mauve),
                            // Icône à la fin du champ pour afficher/masquer le mot de passe.
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Change l'icône en fonction de l'état de _isObscure.
                                _isObscure ? Icons.visibility_off : Icons.visibility,
                                color: AppColors.mauve,
                              ),
                              onPressed: () {
                                // Met à jour l'état pour reconstruire le widget avec la nouvelle valeur de _isObscure.
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24), // Espace vertical.
                        // Bouton de connexion.
                        ElevatedButton(
                          onPressed: _login, // Appelle la méthode _login lors du clic.
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50), // Le bouton prend toute la largeur.
                          ),
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24), // Espace vertical.

                  // COMPTES TEST
                  // Un conteneur pour afficher les informations des comptes de test.
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.mauveClair.withOpacity(0.2), // Fond semi-transparent.
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text('Comptes de test:'), // Texte d'en-tête.
                        const SizedBox(height: 8),
                        // Une rangée pour afficher les deux comptes côte à côte.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center, // Centre les enfants horizontalement.
                          children: [
                            // Conteneur pour le compte admin.
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.mauve,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                'admin / admin123',
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 8), // Espace horizontal.
                            // Conteneur pour le compte client.
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.rosePale,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                'client / client123',
                                style: TextStyle(color: AppColors.mauve, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ], 
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
