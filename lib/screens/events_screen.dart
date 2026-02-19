// IMPORTATIONS
import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';
import 'edit_event_screen.dart';

// ========================================================
// ÉCRAN LISTE ÉVÉNEMENTS
// ========================================================
class EventsScreen extends StatefulWidget {
  final bool isAdmin; // true = admin, false = client

  const EventsScreen({Key? key, required this.isAdmin}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  String _searchQuery = '';

  List<Event> get filteredEvents {
    return mockEvents.where((event) {
      return event.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ==================================================
        // BARRE DE RECHERCHE (kounye a li mache)
        // ==================================================
        SearchBar(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),

        // ==================================================
        // LISTE DES ÉVÉNEMENTS EN 2 COLONNES
        // ==================================================
        Expanded(
          child: filteredEvents.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy,
                  size: 64,
                  color: AppColors.mauve.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Aucun événement disponible',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          )
              : GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // ➜ 2 bò
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: filteredEvents.length,
            itemBuilder: (context, index) {
              final event = filteredEvents[index];

              return GestureDetector(
                onTap: () {
                  if (widget.isAdmin) {
                    // ADMIN ➜ Modifier événement
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditEventScreen(event: event),
                      ),
                    ).then((_) => setState(() {}));
                  } else {
                    // CLIENT ➜ Voir détails
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(
                          event.title,
                          style: const TextStyle(
                            color: AppColors.mauve,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (event.imageUrl != null &&
                                  event.imageUrl!.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(event.imageUrl!),
                                ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text(event.date),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text(event.location),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(event.description),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Fermer'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: EventCard(event: event), // reutilize widget ou deja genyen
              );
            },
          ),
        ),
      ],
    );
  }
}

// ========================================================
// SEARCH BAR (sa a nou itilize pou filtre lis la)
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
