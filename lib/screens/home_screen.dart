// ========================================================
// IMPORTATIONS
// ========================================================
import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import 'events_screen.dart';
import 'login_screen.dart';

// ========================================================
// HOME SCREEN
// ========================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const EventsScreen(isAdmin: false),
  ];

  // ========================================================
  // CONFIRMATION LOGOUT
  // ========================================================
  Future<void> _confirmLogout() async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation"),
        content: const Text("Ou vle dekonekte vre ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Anile"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Wi"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      currentUser = null;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
      );
    }
  }

  // ========================================================
  // UI
  // ========================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _confirmLogout,
          ),
        ],
      ),
      body: _screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.mauve,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Événements'),
        ],
      ),
    );
  }
}

// ========================================================
// CONTENU ACCUEIL (AVEC IMAGE BACKGROUND)
// ========================================================
class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        // ================= BACKGROUND IMAGE =================
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://images.unsplash.com/photo-1492684223066-81342ee5ff30",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // ================= DARK OVERLAY =================
        Container(
          color: Colors.black.withOpacity(0.55),
        ),

        // ================= CONTENT =================
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Icon(
                  Icons.event_available,
                  size: 90,
                  color: Colors.white,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Bienvenue sur Gestion Événements',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  '${mockEvents.length} événements disponibles',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 30),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mauve,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  icon: const Icon(Icons.event),
                  label: const Text(
                    "Explorer les événements",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    // Change tab vers événements
                    DefaultTabController.of(context)?.animateTo(1);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
