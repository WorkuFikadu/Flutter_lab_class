import 'package:flutter/material.dart';

/// Flutter implementation of "My First App" matching the Android Lab Demo:
/// 1. Enter name and press Submit -> Shows "Hello, <name>!"
/// 2. Leave field empty and press Submit -> Shows validation error
/// 3. Press Clear -> Input and greeting disappear
class LabFirstAppScreen extends StatefulWidget {
  const LabFirstAppScreen({Key? key}) : super(key: key);

  @override
  State<LabFirstAppScreen> createState() => _LabFirstAppScreenState();
}

class _LabFirstAppScreenState extends State<LabFirstAppScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _greeting = '';
  String? _errorMessage;

  void _handleSubmit() {
    final text = _nameController.text.trim();
    if (text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter your name';
        _greeting = 'Please enter your name';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      setState(() {
        _errorMessage = null;
        _greeting = 'Hello, $text!';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hello, $text!'),
          backgroundColor: const Color(0xFF2563EB),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _handleClear() {
    setState(() {
      _nameController.clear();
      _greeting = '';
      _errorMessage = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cleared'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('My First Mobile App (Lab Demo)'),
        backgroundColor: const Color(0xFF2563EB),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            color: const Color(0xFFF0F6FE),
            elevation: 2,
            shape: RoundedCornerShape(16),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'My First Android App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      errorText: _errorMessage,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF93C5FD)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF93C5FD)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedCornerShape(10),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _handleClear,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDBEAFE),
                      foregroundColor: const Color(0xFF1E40AF),
                      minimumSize: const Size.fromHeight(50),
                      elevation: 0,
                      shape: RoundedCornerShape(10),
                    ),
                    child: const Text(
                      'Clear',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (_greeting.isNotEmpty) ...[
                    const SizedBox(height: 22),
                    Text(
                      _greeting,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _errorMessage != null ? Colors.redAccent : const Color(0xFF1E3A8A),
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),
                  const Text(
                    'Example preview — the actual app runs on your selected Android device.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  RoundedRectangleBorder RoundedCornerShape(double radius) {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
  }
}
