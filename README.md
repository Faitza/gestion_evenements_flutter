# GESTION ÉVÉNEMENTS

Application mobile Flutter pour gérer et consulter des événements.

---

## 🎯 OBJECTIF DU PROJET

Cette application permet de :
- Gérer des événements (admin)
- Consulter des événements (client)
- Ajouter, modifier et supprimer des événements
- Rechercher des événements par titre
- Afficher les événements en liste ou en grille
- Voir les détails complets d'un événement

Deux types d'utilisateurs :
- **Admin** : tous les droits (ajouter, modifier, supprimer)
- **Client** : consultation uniquement

---

## ⚙️ FONCTIONNALITÉS PRINCIPALES

### 🔐 Connexion
- Deux comptes de test :
  - Admin : `admin` / `admin123`
  - Client : `client` / `client123`
- Message d'erreur si identifiants incorrects

### 🏠 Accueil
- **Client** : message de bienvenue, nombre d'événements
- **Admin** : panneau avec statistiques, bouton pour ajouter

### 📋 Liste des événements
- Affichage en **vue liste** (détaillée)
- Affichage en **vue grille** (2 colonnes)
- Bouton pour basculer entre les deux vues
- Message "Aucun événement disponible" si liste vide

### 🔍 Recherche
- Barre de recherche en temps réel
- Filtrage par titre d'événement

### ➕ Ajouter (Admin)
- Formulaire avec validation
- Champs : Titre, Date, Lieu, Description

### ✏️ Modifier (Admin)
- Formulaire pré-rempli
- Mise à jour des informations

### 🗑️ Supprimer (Admin)
- Boîte de confirmation avant suppression

### 📄 Détails d'un événement (Client)
- Page complète avec :
  - Grande image d'en-tête
  - Titre, date, lieu
  - Description détaillée

### 🚪 Déconnexion
- Bouton dans la barre d'application
- Confirmation avant déconnexion

### 🎨 Design
- Couleurs : mauve (`#9B7EBD`) et rose pâle (`#F8C7CC`)
- Interface moderne avec Material 3
- Coins arrondis et ombres douces

---

## 🚀 INSTRUCTIONS POUR LANCER L'APPLICATION

### Prérequis
- Flutter SDK installé
- Émulateur ou appareil physique

### Étapes

1. **Cloner le dépôt**
```bash
git clone https://github.com/Faitza/gestion_evenements_flutter.git
cd gestion_evenements_flutter
```

2. **Installer les dépendances**
```bash
flutter pub get
```

3. **Lancer l'application**
```bash
flutter run
```

---

## 📁 STRUCTURE DU PROJET

```
lib/
├── main.dart
├── data/
│   └── mock_data.dart        # Données de test
├── models/
│   ├── event.dart
│   └── user.dart
├── screens/
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── admin_panel_screen.dart
│   ├── events_screen.dart
│   ├── event_detail_screen.dart
│   ├── add_event_screen.dart
│   └── edit_event_screen.dart
└── widgets/
    ├── event_card.dart
    └── search_bar.dart
```

---

## 📝 NOTES

- Les données sont stockées **en mémoire** (liste Dart)
- Les modifications sont perdues au redémarrage
- Aucune base de données ou API externe utilisée

---

## 👨‍💻 AUTEUR

Projet réalisé dans le cadre d'un cours de développement mobile Flutter.
