// lib/resume_maker_app/resume_maker_screen.dart
import 'package:flutter/material.dart';

class ResumeMakerScreen extends StatefulWidget {
  const ResumeMakerScreen({super.key});

  @override
  State<ResumeMakerScreen> createState() => _ResumeMakerScreenState();
}

class _ResumeMakerScreenState extends State<ResumeMakerScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _skillsController = TextEditingController();
  final _experienceController = TextEditingController();
  bool _showResume = false;

  void _generateResume() {
    if (_nameController.text.isNotEmpty) {
      setState(() {
        _showResume = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Maker'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _showResume ? _buildResume() : _buildForm(),
      floatingActionButton: _showResume
          ? FloatingActionButton(
              onPressed: () => setState(() => _showResume = false),
              backgroundColor: Colors.blue,
              child: const Icon(Icons.edit, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _skillsController,
            decoration: const InputDecoration(
              labelText: 'Skills',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _experienceController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Experience',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _generateResume,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: const Text('Generate Resume'),
          ),
        ],
      ),
    );
  }

  Widget _buildResume() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _nameController.text,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(_emailController.text, style: const TextStyle(fontSize: 16)),
              Text(_phoneController.text, style: const TextStyle(fontSize: 16)),
              const Divider(height: 30),
              const Text('SKILLS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(_skillsController.text, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              const Text('EXPERIENCE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(_experienceController.text, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}