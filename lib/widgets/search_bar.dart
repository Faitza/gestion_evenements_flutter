// IMPORTATIONS
import 'package:flutter/material.dart';
import '../data/mock_data.dart';

// ========================================================
// BARRE DE RECHERCHE
// ========================================================
class SearchBar extends StatelessWidget {
  final Function(String)? onChanged;

  const SearchBar({Key? key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Rechercher un événement...',
          prefixIcon: const Icon(Icons.search, color: AppColors.mauve),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}