// IMPORTATIONS
// Importe la bibliothèque Material de Flutter pour les widgets d'interface utilisateur.
import 'package:flutter/material.dart';
// Importe le modèle de données Event.
import '../models/event.dart';
// Importe les données de simulation, y compris les couleurs et les listes.
import '../data/mock_data.dart';

// ========================================================
// MODIFIER UN ÉVÉNEMENT (AVEC IMAGE)
// ========================================================
// Définit un widget avec état pour l'écran de modification d'un événement.
class EditEventScreen extends StatefulWidget {
  // L'événement à modifier, passé en paramètre lors de la création de l'écran.
  final Event event;

  // Constructeur du widget, qui requiert un objet Event.
  const EditEventScreen({Key? key, required this.event}) : super(key: key);

  @override
  // Crée l'état mutable pour ce widget.
  _EditEventScreenState createState() => _EditEventScreenState();
}

// Classe d'état pour le widget EditEventScreen.
class _EditEventScreenState extends State<EditEventScreen> {
  // Déclare les contrôleurs pour gérer le texte des champs de saisie.
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;

  @override
  // Méthode appelée une seule fois lorsque le widget est inséré dans l'arbre de widgets.
  void initState() {
    super.initState(); // Appelle la méthode initState de la classe mère.
    // Initialise le contrôleur de titre avec le titre de l'événement.
    _titleController = TextEditingController(text: widget.event.title);
    // Initialise le contrôleur de date avec la date de l'événement.
    _dateController = TextEditingController(text: widget.event.date);
    // Initialise le contrôleur de lieu avec le lieu de l'événement.
    _locationController = TextEditingController(text: widget.event.location);
    // Initialise le contrôleur de description avec la description de l'événement.
    _descriptionController =
        TextEditingController(text: widget.event.description);
    // Initialise le contrôleur d'URL d'image avec l'URL de l'événement, ou une chaîne vide si elle est nulle.
    _imageController =
        TextEditingController(text: widget.event.imageUrl ?? "");
  }

  @override
  // Méthode appelée lorsque le widget est définitivement supprimé de l'arbre de widgets.
  void dispose() {
    // Libère les ressources détenues par chaque contrôleur pour éviter les fuites de mémoire.
    _titleController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose(); // Appelle la méthode dispose de la classe mère.
  }

  // Méthode pour mettre à jour les informations de l'événement.
  void _updateEvent() {
    // Demande au framework de reconstruire le widget pour refléter les changements d'état.
    setState(() {
      // Met à jour les propriétés de l'objet Event avec les nouvelles valeurs des contrôleurs.
      widget.event.title = _titleController.text;
      widget.event.date = _dateController.text;
      widget.event.location = _locationController.text;
      widget.event.description = _descriptionController.text;
      widget.event.imageUrl = _imageController.text;
    });

    // Affiche une SnackBar pour informer l'utilisateur que l'événement a été modifié.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Événement modifié!')),
    );

    // Revient à l'écran précédent dans la pile de navigation.
    Navigator.pop(context);
  }

  // Méthode pour supprimer l'événement.
  void _deleteEvent() {
    // Affiche une boîte de dialogue de confirmation.
    showDialog(
      context: context, // Le contexte de build actuel.
      builder: (context) => AlertDialog( // Construit la boîte de dialogue.
        title: const Text('Confirmation'), // Le titre de la boîte de dialogue.
        content: const Text('Supprimer cet événement?'), // Le contenu de la boîte de dialogue.
        actions: [ // La liste des actions (boutons) de la boîte de dialogue.
          // Bouton pour annuler la suppression.
          TextButton(
            onPressed: () => Navigator.pop(context), // Action à exécuter lors du clic : fermer la dialogue.
            child: const Text('Annuler'), // Le texte du bouton.
          ),
          // Bouton pour confirmer la suppression.
          TextButton(
            onPressed: () {
              // Supprime l'événement de la liste des événements simulés.
              mockEvents.remove(widget.event);
              Navigator.pop(context); // Ferme la boîte de dialogue.
              Navigator.pop(context); // Revient à l'écran qui listait les événements.

              // Affiche une SnackBar pour confirmer la suppression.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ Événement supprimé!')),
              );
            },
            child: const Text('Supprimer'), // Le texte du bouton.
          ),
        ],
      ),
    );
  }

  @override
  // Construit l'interface utilisateur du widget.
  Widget build(BuildContext context) {
    // Retourne un Scaffold, qui implémente la structure de base de l'écran Material Design.
    return Scaffold(
      backgroundColor: AppColors.blancRose, // Définit la couleur de fond de l'écran.
      appBar: AppBar( // La barre d'application en haut de l'écran.
        title: const Text('Modifier'), // Le titre affiché dans la barre d'application.
        actions: [ // Une liste de widgets à afficher après le titre.
          // Bouton d'icône pour la suppression.
          IconButton(
            icon: const Icon(Icons.delete), // L'icône de corbeille.
            onPressed: _deleteEvent, // L'action à exécuter au clic : appeler _deleteEvent.
          ),
        ],
      ),
      body: Padding( // Ajoute un remplissage autour de son enfant.
        padding: const EdgeInsets.all(16), // Définit un remplissage de 16 pixels sur tous les côtés.
        child: ListView( // Un widget qui affiche ses enfants dans une liste déroulante pour éviter le dépassement de pixels.
          children: [ // La liste des widgets enfants.
            const SizedBox(height: 10), // Une boîte de taille fixe pour créer un espacement vertical.

            // ==================================================
            // PREVIEW IMAGE (Aperçu de l'image)
            // ==================================================
            // Condition pour afficher l'image seulement si l'URL n'est pas vide.
            if (_imageController.text.isNotEmpty)
              ClipRRect( // Widget qui coupe son enfant avec des coins arrondis.
                borderRadius: BorderRadius.circular(12), // Rayon des coins.
                child: Image.network( // Widget pour afficher une image depuis une URL.
                  _imageController.text, // L'URL de l'image.
                  height: 180, // Hauteur de l'image.
                  fit: BoxFit.cover, // Redimensionne l'image pour couvrir l'espace alloué.
                  errorBuilder: (context, error, stackTrace) { // Widget à construire en cas d'erreur de chargement.
                    return _imagePlaceholder(); // Affiche le placeholder si l'image ne se charge pas.
                  },
                ),
              )
            else
              // Affiche le placeholder si le champ URL est vide.
              _imagePlaceholder(),

            const SizedBox(height: 20), // Espacement vertical.

            // ==================================================
            // CHAMP IMAGE URL
            // ==================================================
            // Un champ de texte de formulaire pour l'URL de l'image.
            TextFormField(
              controller: _imageController, // Le contrôleur pour ce champ.
              decoration: InputDecoration( // La décoration du champ.
                labelText: 'Image URL', // Le libellé du champ.
                hintText: 'https://...', // Texte d'aide affiché dans le champ vide.
                border: OutlineInputBorder( // Bordure du champ.
                  borderRadius: BorderRadius.circular(10), // Coins arrondis de la bordure.
                ),
                filled: true, // Le champ sera rempli avec une couleur.
                fillColor: Colors.white, // La couleur de remplissage.
                prefixIcon: const Icon(Icons.image, color: AppColors.mauve), // Icône avant le texte.
              ),
              onChanged: (_) => setState(() {}), // Met à jour l'état à chaque changement pour rafraîchir l'aperçu de l'image.
            ),

            const SizedBox(height: 16), // Espacement vertical.

            // Champ de texte pour le titre.
            TextFormField(
              controller: _titleController, // Le contrôleur pour ce champ.
              decoration: _inputDecoration('Titre', Icons.event), // Utilise la méthode helper pour la décoration.
            ),

            const SizedBox(height: 16), // Espacement vertical.

            // Champ de texte pour la date.
            TextFormField(
              controller: _dateController, // Le contrôleur pour ce champ.
              decoration: _inputDecoration('Date', Icons.calendar_today), // Utilise la méthode helper.
            ),

            const SizedBox(height: 16), // Espacement vertical.

            // Champ de texte pour le lieu.
            TextFormField(
              controller: _locationController, // Le contrôleur pour ce champ.
              decoration: _inputDecoration('Lieu', Icons.location_on), // Utilise la méthode helper.
            ),

            const SizedBox(height: 16), // Espacement vertical.

            // Champ de texte pour la description.
            TextFormField(
              controller: _descriptionController, // Le contrôleur pour ce champ.
              decoration: _inputDecoration('Description', Icons.description), // Utilise la méthode helper.
              maxLines: 3, // Le champ peut s'étendre sur 3 lignes.
            ),

            const SizedBox(height: 30), // Espacement vertical.

            // Bouton pour soumettre les modifications.
            ElevatedButton(
              onPressed: _updateEvent, // Action à exécuter au clic : appeler _updateEvent.
              style: ElevatedButton.styleFrom( // Style du bouton.
                minimumSize: const Size(double.infinity, 50), // Définit la taille minimale du bouton (il prend toute la largeur).
              ),
              child: const Text( // Le texte du bouton.
                'Modifier',
                style: TextStyle(fontSize: 16), // Style du texte.
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================================================
  // STYLE INPUT (méthode d'aide pour la décoration des champs)
  // ==================================================
  // Retourne un objet InputDecoration pour styliser les champs de texte de manière cohérente.
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label, // Le libellé du champ.
      border: OutlineInputBorder( // La bordure du champ.
        borderRadius: BorderRadius.circular(10), // Coins arrondis.
      ),
      filled: true, // Le champ est rempli.
      fillColor: Colors.white, // Couleur de remplissage.
      prefixIcon: Icon(icon, color: AppColors.mauve), // Icône à gauche avec la couleur mauve.
    );
  }

  // ==================================================
  // PLACEHOLDER IMAGE (Widget d'aide pour l'aperçu de l'image)
  // ==================================================
  // Retourne un widget à afficher lorsque l'URL de l'image est vide ou invalide.
  Widget _imagePlaceholder() {
    return Container( // Un conteneur simple.
      height: 180, // Hauteur fixe.
      decoration: BoxDecoration( // Décoration du conteneur.
        color: AppColors.mauveClair.withOpacity(0.3), // Couleur de fond avec opacité.
        borderRadius: BorderRadius.circular(12), // Coins arrondis.
      ),
      child: const Center( // Centre son enfant.
        child: Icon(Icons.image, size: 50, color: AppColors.mauve), // Affiche une icône d'image.
      ),
    );
  }
}
