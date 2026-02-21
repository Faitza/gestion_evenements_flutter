// IMPORTATIONS
import 'package:flutter/material.dart'; // Importe la bibliothèque Material pour utiliser la classe Color.
import '../models/event.dart'; // Importe le modèle de données pour les événements.
import '../models/user.dart'; // Importe le modèle de données pour les utilisateurs.

// ========================================================
// COULEURS DE L'APPLICATION - MAUVE ET ROSE
// ========================================================
// Classe pour définir une palette de couleurs personnalisée pour l'application.
class AppColors {
  static const Color mauve = Color(0xFF9B7EBD);      // MAUVE PRINCIPAL - Couleur primaire pour les éléments importants.
  static const Color rosePale = Color(0xFFF8C7CC);   // ROSE PÂLE - Couleur d'accentuation ou pour les fonds.
  static const Color mauveClair = Color(0xFFD4C1EC); // MAUVE CLAIR - Une variation plus douce du mauve.
  static const Color blancRose = Color(0xFFFEF3F2);  // BLANC ROSÉ - Couleur de fond générale pour les écrans.
  static const Color mauveFonce = Color(0xFF7A5FA0); // MAUVE FONCÉ - Pour les textes ou les éléments contrastants.
}

// ========================================================
// UTILISATEURS DE TEST
// ========================================================
// Crée une liste d'utilisateurs de test pour la simulation de connexion.
List<User> mockUsers = [
  // Un utilisateur avec le rôle 'admin'.
  User('admin', 'admin123', 'admin'),
  // Un utilisateur avec le rôle 'client'.
  User('client', 'client123', 'client'),
];

// ========================================================
// ÉVÉNEMENTS DE TEST (AVEC VRAIES IMAGES DIRECTES)
// ========================================================
// Crée une liste d'événements de test pour peupler l'application.
List<Event> mockEvents = [
  // Premier événement de la liste.
  Event(
    id: '1', // Identifiant unique de l'événement.
    title: 'Conférence Flutter', // Titre de l'événement.
    date: '2026-03-15', // Date de l'événement.
    location: 'Port-au-Prince', // Lieu de l'événement.
    description: // Description détaillée de l'événement.
    'Découvrez les dernières nouveautés de Flutter avec des experts internationaux',
    imageUrl: // URL de l'image de l'événement.
    "https://images.unsplash.com/photo-1515169067868-5387ec356754",
  ),
  // Deuxième événement de la liste.
  Event(
    id: '2',
    title: 'Atelier Design UI/UX',
    date: '2026-03-20',
    location: 'Cap-Haïtien',
    description: 'Apprenez les principes du design moderne pour mobile',
    imageUrl:
    "https://images.unsplash.com/photo-1559028012-481c04fa702d",
  ),
  // Troisième événement de la liste.
  Event(
    id: '3',
    title: 'Hackathon 2026',
    date: '2026-04-10',
    location: 'Pétion-Ville',
    description: '48h pour créer des solutions innovantes',
    imageUrl:
    "https://images.unsplash.com/photo-1504384308090-c894fdcc538d",
  ),
];

// ========================================================
// UTILISATEUR CONNECTÉ
// ========================================================
// Variable globale pour stocker l'utilisateur actuellement connecté.
// Elle est nullable, ce qui signifie qu'elle peut être 'null' si aucun utilisateur n'est connecté.
User? currentUser;
