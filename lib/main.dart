// IMPORTATIONS
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/admin_panel_screen.dart';
import 'screens/add_event_screen.dart';
import 'screens/edit_event_screen.dart';
import 'data/mock_data.dart';

// ========================================================
// POINT D'ENTRÉE
// ========================================================
void main() {
  runApp(const MyApp());
}

// ========================================================
// APPLICATION PRINCIPALE
// ========================================================
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion Événements',
      debugShowCheckedModeBanner: false,

      // ==================================================
      // THÈME AVEC COULEURS MAUVE/ROSE
      // ==================================================
      theme: ThemeData(
        primaryColor: AppColors.mauve,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.mauve,
          primary: AppColors.mauve,
          secondary: AppColors.rosePale,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.mauve,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mauve,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        useMaterial3: true,
      ),

      // ==================================================
      // PAGE D'ACCUEIL - CONNEXION
      // ==================================================
      home: const LoginScreen(),
    );
  }
}