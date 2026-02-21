// IMPORTATIONS
import 'package:flutter/material.dart'; // Importe la bibliothèque Material de Flutter, qui contient les widgets de base pour une application Material Design.
import 'screens/login_screen.dart'; // Importe le widget de l'écran de connexion.
import 'screens/home_screen.dart'; // Importe le widget de l'écran d'accueil.
import 'screens/admin_panel_screen.dart'; // Importe le widget de l'écran du panneau d'administration.
import 'screens/add_event_screen.dart'; // Importe le widget de l'écran pour ajouter un événement.
import 'screens/edit_event_screen.dart'; // Importe le widget de l'écran pour modifier un événement.
import 'data/mock_data.dart'; // Importe les données simulées, y compris la classe AppColors pour le thème.

// ========================================================
// POINT D'ENTRÉE
// ========================================================
// La fonction main() est le point d'entrée de toute application Flutter. C'est la première fonction exécutée.
void main() {
  // runApp() prend un widget en argument et en fait l'élément racine de l'arbre de widgets de l'application.
  runApp(const MyApp());
}

// ========================================================
// APPLICATION PRINCIPALE
// ========================================================
// MyApp est le widget racine de l'application. C'est un StatelessWidget car son état ne change pas une fois qu'il est construit.
class MyApp extends StatelessWidget {
  // Constructeur pour le widget MyApp.
  const MyApp({Key? key}) : super(key: key);

  @override
  // La méthode build() décrit comment afficher le widget. Elle est appelée chaque fois que le widget doit être rendu.
  Widget build(BuildContext context) {
    // MaterialApp est un widget de convenance qui enveloppe plusieurs widgets couramment nécessaires pour les applications Material Design.
    return MaterialApp(
      // Le titre de l'application, utilisé par le gestionnaire de tâches de l'appareil.
      title: 'Gestion Événements',
      // Masque la bannière "Debug" dans le coin supérieur droit en mode de développement.
      debugShowCheckedModeBanner: false,

      // ==================================================
      // THÈME AVEC COULEURS MAUVE/ROSE
      // ==================================================
      // ThemeData définit le thème visuel global de l'application (couleurs, polices, etc.).
      theme: ThemeData(
        // La couleur principale utilisée dans l'application.
        primaryColor: AppColors.mauve,
        // Définit la palette de couleurs de l'application à partir d'une couleur de base (seed color).
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.mauve, // La couleur de base pour générer le schéma de couleurs.
          primary: AppColors.mauve, // Remplace la couleur primaire générée par le mauve défini.
          secondary: AppColors.rosePale, // Remplace la couleur secondaire générée par le rose pâle défini.
        ),
        // Définit le thème par défaut pour tous les widgets AppBar.
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mauve, // Couleur de fond par défaut des AppBars.
          foregroundColor: Colors.white, // Couleur par défaut du texte et des icônes dans les AppBars.
          centerTitle: true, // Centre le titre par défaut dans les AppBars.
          elevation: 0, // L'ombre sous l'AppBar (0 signifie aucune ombre).
        ),
        // Définit le thème par défaut pour tous les widgets ElevatedButton.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mauve, // Couleur de fond par défaut des boutons.
            foregroundColor: Colors.white, // Couleur par défaut du texte et des icônes sur les boutons.
            // Définit la forme des boutons.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Coins arrondis avec un rayon de 10.
            ),
            // Définit la taille minimale par défaut des boutons.
            minimumSize: const Size(double.infinity, 50), // Fait en sorte que les boutons prennent toute la largeur disponible.
          ),
        ),
        // Définit le thème par défaut pour la décoration des champs de saisie (comme TextField).
        inputDecorationTheme: InputDecorationTheme(
          // La bordure par défaut des champs de saisie.
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Coins arrondis.
          ),
          filled: true, // Indique que le champ doit être rempli d'une couleur.
          fillColor: Colors.white, // La couleur de remplissage par défaut est le blanc.
        ),
        // Active l'utilisation des spécifications de Material 3.
        useMaterial3: true,
      ),

      // ==================================================
      // PAGE D'ACCUEIL - CONNEXION
      // ==================================================
      // La propriété `home` définit le widget à afficher comme écran principal de l'application.
      home: const LoginScreen(),
    );
  }
}
