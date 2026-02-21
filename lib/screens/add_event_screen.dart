// IMPORTATIONS
// Importe la bibliothèque Material de Flutter pour les widgets de l'interface utilisateur.
import 'package:flutter/material.dart';
// Importe les données simulées (mock data), y compris la liste des événements et les couleurs.
import '../data/mock_data.dart';
// Importe le modèle de données pour un objet Event.
import '../models/event.dart';

// ========================================================
// AJOUTER UN ÉVÉNEMENT
// ========================================================
// Définit un widget avec état (StatefulWidget) pour l'écran d'ajout d'événement.
class AddEventScreen extends StatefulWidget {
  // Constructeur du widget, avec une clé optionnelle.
  const AddEventScreen({Key? key}) : super(key: key);


  @override
  // Crée l'état mutable pour ce widget, qui contiendra la logique et l'interface de l'écran.
  _AddEventScreenState createState() => _AddEventScreenState();
}
// Contrôleur pour le champ de texte de l'URL de l'image (défini globalement).
final TextEditingController _imageController = TextEditingController();

// Classe d'état pour le widget AddEventScreen.
class _AddEventScreenState extends State<AddEventScreen> {
  // Clé globale pour identifier et gérer le formulaire de manière unique.
  final _formKey = GlobalKey<FormState>();
  // Contrôleur pour le champ de texte du titre.
  final _titleController = TextEditingController();
  // Contrôleur pour le champ de texte de la date.
  final _dateController = TextEditingController();
  // Contrôleur pour le champ de texte du lieu.
  final _locationController = TextEditingController();
  // Contrôleur pour le champ de texte de la description.
  final _descriptionController = TextEditingController();

  // Méthode appelée pour valider le formulaire et ajouter un nouvel événement.
  void _addEvent() {
    // Vérifie si tous les champs du formulaire sont valides en se basant sur les validateurs.
    if (_formKey.currentState!.validate()) {
      // Crée une nouvelle instance d'événement à partir des données saisies.
      final newEvent = Event(
        // Génère un ID unique basé sur le timestamp actuel.
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        // Récupère le texte du titre et supprime les espaces vides au début et à la fin.
        title: _titleController.text.trim(),
        // Récupère le texte de la date et supprime les espaces.
        date: _dateController.text.trim(),
        // Récupère le texte du lieu et supprime les espaces.
        location: _locationController.text.trim(),
        // Récupère le texte de la description et supprime les espaces.
        description: _descriptionController.text.trim(),
        // L'URL de l'image est définie sur null pour le moment dans cette version de la logique.
        imageUrl: null,
      );

      // Ajoute le nouvel événement créé à la liste des événements simulés.
      mockEvents.add(newEvent);

      // Affiche une barre de notification (SnackBar) en bas de l'écran pour confirmer le succès.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Événement ajouté avec succès!'),
          backgroundColor: Colors.green, // Couleur de fond verte pour la notification de succès.
        ),
      );

      // Ferme l'écran d'ajout et retourne à l'écran précédent, en passant 'true' comme résultat.
      Navigator.pop(context, true);
    }
  }

  @override
  // Méthode qui construit l'interface utilisateur de l'écran.
  Widget build(BuildContext context) {
    // Retourne un Scaffold, qui fournit la structure de base de l'écran (AppBar, body, etc.).
    return Scaffold(
      backgroundColor: AppColors.blancRose, // Définit la couleur de fond de l'écran.
      appBar: AppBar( // La barre d'application en haut de l'écran.
        title: const Text('Ajouter un événement'), // Titre affiché dans l'AppBar.
      ),
      // Le corps de l'écran, avec un remplissage (padding) autour.
      body: Padding(
        padding: const EdgeInsets.all(16), // Espace de 16 pixels sur tous les côtés.
        // Un widget de formulaire qui regroupe et valide les champs de saisie.
        child: Form(
          key: _formKey, // Associe la clé globale au formulaire pour la validation et la gestion d'état.
          // Utilise un ListView pour que le contenu soit déroulant et éviter les problèmes de dépassement sur petits écrans.
          child: ListView(
            // La liste des widgets enfants du formulaire.
            children: [
              const SizedBox(height: 20), // Crée un espace vertical de 20 pixels.
              // Champ de texte pour le titre (avec validation).
              TextFormField(
                controller: _titleController, // Lie le champ au contrôleur de titre.
                decoration: InputDecoration( // Définit l'apparence du champ.
                  labelText: 'Titre', // Texte indicatif qui s'affiche au-dessus du champ.
                  border: OutlineInputBorder( // Bordure du champ.
                    borderRadius: BorderRadius.circular(10), // Coins arrondis.
                  ),
                  filled: true, // Le champ sera rempli avec une couleur.
                  fillColor: Colors.white, // Couleur de fond blanche.
                  prefixIcon: const Icon(Icons.event, color: AppColors.mauve), // Icône affichée avant le texte.
                ),
                validator: (value) { // Fonction de validation pour ce champ.
                  if (value == null || value.isEmpty) { // Vérifie si le champ est vide.
                    return 'Champ requis'; // Message d'erreur à afficher si vide.
                  }
                  return null; // Retourne null si la valeur est valide.
                },
              ),
              const SizedBox(height: 16), // Espace vertical.
              // Champ de texte pour la date.
              TextFormField(
                controller: _dateController, // Lie le champ au contrôleur de date.
                decoration: InputDecoration(
                  labelText: 'Date (AAAA-MM-JJ)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.calendar_today, color: AppColors.mauve),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Champ requis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16), // Espace vertical.
              // Champ de texte pour le lieu.
              TextFormField(
                controller: _locationController, // Lie le champ au contrôleur de lieu.
                decoration: InputDecoration(
                  labelText: 'Lieu',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.location_on, color: AppColors.mauve),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Champ requis';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16), // Espace vertical.
              // Champ de texte simple (sans validation) pour l'URL de l'image.
              TextField(
                controller: _imageController, // Lie le champ au contrôleur d'image.
                decoration: const InputDecoration(
                  labelText: "Image URL",
                  hintText: "https://....", // Texte d'aide affiché à l'intérieur du champ vide.
                ),
              ),
              const SizedBox(height: 15), // Espace vertical.

              // Champ de texte pour la description.
              TextFormField(
                controller: _descriptionController, // Lie le champ au contrôleur de description.
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(Icons.description, color: AppColors.mauve),
                ),
                maxLines: 3, // Permet au champ de s'étendre sur 3 lignes.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Champ requis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30), // Espace vertical.
              // Bouton pour soumettre le formulaire et ajouter l'événement.
              ElevatedButton(
                onPressed: _addEvent, // Appelle la méthode _addEvent lorsqu'on clique.
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), // Le bouton prend toute la largeur disponible.
                ),
                child: const Text(
                  'Ajouter',
                  style: TextStyle(fontSize: 16), // Style du texte du bouton.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
