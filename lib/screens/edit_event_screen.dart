// IMPORTATIONS
import 'package:flutter/material.dart';
import '../models/event.dart';
import '../data/mock_data.dart';

// ========================================================
// MODIFIER UN ÉVÉNEMENT (AVEC IMAGE)
// ========================================================
class EditEventScreen extends StatefulWidget {
  final Event event;

  const EditEventScreen({Key? key, required this.event}) : super(key: key);

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event.title);
    _dateController = TextEditingController(text: widget.event.date);
    _locationController = TextEditingController(text: widget.event.location);
    _descriptionController =
        TextEditingController(text: widget.event.description);
    _imageController =
        TextEditingController(text: widget.event.imageUrl ?? "");
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _updateEvent() {
    setState(() {
      widget.event.title = _titleController.text;
      widget.event.date = _dateController.text;
      widget.event.location = _locationController.text;
      widget.event.description = _descriptionController.text;
      widget.event.imageUrl = _imageController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Événement modifié!')),
    );

    Navigator.pop(context);
  }

  void _deleteEvent() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Supprimer cet événement?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              mockEvents.remove(widget.event);
              Navigator.pop(context);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ Événement supprimé!')),
              );
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blancRose,
      appBar: AppBar(
        title: const Text('Modifier'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteEvent,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            // ==================================================
            // PREVIEW IMAGE
            // ==================================================
            if (_imageController.text.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  _imageController.text,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _imagePlaceholder();
                  },
                ),
              )
            else
              _imagePlaceholder(),

            const SizedBox(height: 20),

            // ==================================================
            // CHAMP IMAGE URL
            // ==================================================
            TextFormField(
              controller: _imageController,
              decoration: InputDecoration(
                labelText: 'Image URL',
                hintText: 'https://...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.image, color: AppColors.mauve),
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _titleController,
              decoration: _inputDecoration('Titre', Icons.event),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _dateController,
              decoration: _inputDecoration('Date', Icons.calendar_today),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _locationController,
              decoration: _inputDecoration('Lieu', Icons.location_on),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              decoration: _inputDecoration('Description', Icons.description),
              maxLines: 3,
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _updateEvent,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Modifier',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================================================
  // STYLE INPUT
  // ==================================================
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(icon, color: AppColors.mauve),
    );
  }

  // ==================================================
  // PLACEHOLDER IMAGE
  // ==================================================
  Widget _imagePlaceholder() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.mauveClair.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(Icons.image, size: 50, color: AppColors.mauve),
      ),
    );
  }
}
