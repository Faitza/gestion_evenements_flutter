// IMPORTATIONS
import 'package:flutter/material.dart';
import '../models/event.dart';
import '../models/user.dart';

// ========================================================
// COULEURS DE L'APPLICATION - MAUVE ET ROSE
// ========================================================
class AppColors {
  static const Color mauve = Color(0xFF9B7EBD);      // MAUVE PRINCIPAL
  static const Color rosePale = Color(0xFFF8C7CC);   // ROSE PÂLE
  static const Color mauveClair = Color(0xFFD4C1EC); // MAUVE CLAIR
  static const Color blancRose = Color(0xFFFEF3F2);  // BLANC ROSÉ
  static const Color mauveFonce = Color(0xFF7A5FA0); // MAUVE FONCÉ
}

// ========================================================
// UTILISATEURS DE TEST
// ========================================================
List<User> mockUsers = [
  User('admin', 'admin123', 'admin'),
  User('client', 'client123', 'client'),
];

// ========================================================
// ÉVÉNEMENTS DE TEST (AVEC VRAIES IMAGES DIRECTES)
// ========================================================
List<Event> mockEvents = [
  Event(
    id: '1',
    title: 'Conférence Flutter',
    date: '2026-03-15',
    location: 'Port-au-Prince',
    description:
    'Découvrez les dernières nouveautés de Flutter avec des experts internationaux',
    imageUrl:
    "https://images.unsplash.com/photo-1515169067868-5387ec356754",
  ),
  Event(
    id: '2',
    title: 'Atelier Design UI/UX',
    date: '2026-03-20',
    location: 'Cap-Haïtien',
    description: 'Apprenez les principes du design moderne pour mobile',
    imageUrl:
    "https://images.unsplash.com/photo-1559028012-481c04fa702d",
  ),
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
User? currentUser;
