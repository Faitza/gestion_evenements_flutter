// IMPORTATIONS
import 'package:flutter/material.dart';
import '../models/event.dart';
import '../data/mock_data.dart';

// ========================================================
// CARTE POUR AFFICHER UN ÉVÉNEMENT (VERSION AVEC IMAGE)
// ========================================================
class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback? onTap;
  final bool isAdmin;

  const EventCard({
    Key? key,
    required this.event,
    this.onTap,
    this.isAdmin = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // IMAGE EVENEMENT (si genyen)
            // ==================================================
            if (event.imageUrl != null && event.imageUrl!.isNotEmpty)
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Image.network(
                  event.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _iconPlaceholder();
                  },
                ),
              )
            else
              _iconPlaceholder(),

            // ==================================================
            // CONTENU TEXTE
            // ==================================================
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                event.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      event.date,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      event.location,
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ==================================================
            // ICON EDIT SI ADMIN
            // ==================================================
            if (isAdmin)
              const Padding(
                padding: EdgeInsets.all(6),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.edit, color: AppColors.mauve, size: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ==================================================
  // PLACEHOLDER SI PA GEN IMAGE
  // ==================================================
  Widget _iconPlaceholder() {
    return Container(
      height: 120,
      width: double.infinity,
      color: AppColors.mauveClair.withOpacity(0.3),
      child: const Icon(
        Icons.event,
        color: AppColors.mauve,
        size: 40,
      ),
    );
  }
}
