// CLASSE QUI REPRÉSENTE UN ÉVÉNEMENT
class Event {
  // PROPRIÉTÉS D'UN ÉVÉNEMENT
  final String id;        // IDENTIFIANT UNIQUE
  String title;           // TITRE
  String date;            // DATE
  String location;        // LIEU
  String description;     // DESCRIPTION
  String? imageUrl;       // URL DE L'IMAGE (PEUT ÊTRE NULL)

  // CONSTRUCTEUR AVEC PARAMÈTRES OBLIGATOIRES
  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.description,
    this.imageUrl,
  });
}