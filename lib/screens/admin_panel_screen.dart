// IMPORTATIONS
import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import 'add_event_screen.dart';
import 'events_screen.dart';
import 'login_screen.dart';

// ========================================================
// PANNEAU ADMIN
// ========================================================
class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({Key? key}) : super(key: key);

  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const AdminHomeContent(),
    const EventsScreen(isAdmin: true),
    const AddEventScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blancRose,
      appBar: AppBar(
        title: Text(_getTitle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              currentUser = null;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
              );
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.mauve,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Événements'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Ajouter'),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Accueil Admin';
      case 1:
        return 'Gérer événements';
      case 2:
        return 'Ajouter';
      default:
        return 'Admin';
    }
  }
}

// ========================================================
// CONTENU ACCUEIL ADMIN (STATEFUL → pou refresh done yo)
// ========================================================
class AdminHomeContent extends StatefulWidget {
  const AdminHomeContent({Key? key}) : super(key: key);

  @override
  State<AdminHomeContent> createState() => _AdminHomeContentState();
}

class _AdminHomeContentState extends State<AdminHomeContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4",
              height: 180,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 20),

          // IKÔN ADMIN
          Icon(
            Icons.admin_panel_settings,
            size: 80,
            color: AppColors.mauve,
          ),

          const SizedBox(height: 20),

          // TIT
          const Text(
            'Bienvenue Administrateur',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // TOTAL EVENMAN (ap refresh kounye a)
          Text(
            'Total: ${mockEvents.length} événements',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.mauve,
            ),
          ),

          const SizedBox(height: 30),

          // BOUTON AJOUT EVENMAN
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddEventScreen(),
                ),
              );

              // SI EVENMAN AJOUTE → REFRESH
              if (result == true) {
                setState(() {});

                final adminState =
                context.findAncestorStateOfType<_AdminPanelScreenState>();

                if (adminState != null) {
                  adminState.setState(() {
                    adminState._selectedIndex = 1;
                  });
                }
              }
            },
            child: const Text(
              'Ajouter un événement',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
