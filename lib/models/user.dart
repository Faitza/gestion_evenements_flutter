// CLASSE QUI REPRÉSENTE UN UTILISATEUR
class User {
  // PROPRIÉTÉS D'UN UTILISATEUR
  final String username;  // NOM D'UTILISATEUR
  final String password;  // MOT DE PASSE
  final String role;      // RÔLE (admin OU client)

  // CONSTRUCTEUR
  User(this.username, this.password, this.role);
}