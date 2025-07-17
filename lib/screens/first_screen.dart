import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _nameController = TextEditingController();
  final _sentenceController = TextEditingController();

  bool isPalindrome(String text) {
    String processedText = text.replaceAll(' ', '').toLowerCase();
    String reversedText = processedText.split('').reversed.join('');
    return processedText == reversedText;
  }

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Palindrome Check'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Jika gambar dipilih, simpan ke provider
      context.read<AppProvider>().setProfileImage(File(pickedFile.path));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sentenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Pantau perubahan pada profileImage dari provider
    final profileImage = context.watch<AppProvider>().profileImage;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient dari desain Anda
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFB0E0E6), Color(0xFF6495ED)], // LightCyan to CornflowerBlue
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: SingleChildScrollView( // Ditambahkan agar tidak overflow saat keyboard muncul
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Lingkaran untuk upload foto profil
                    GestureDetector(
                      onTap: _pickImage, // Panggil fungsi pilih gambar
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white70,
                        // Tampilkan gambar jika sudah dipilih
                        backgroundImage: profileImage != null ? FileImage(profileImage) : null,
                        // Tampilkan ikon jika belum ada gambar
                        child: profileImage == null
                            ? const Icon(Icons.add_a_photo_outlined, size: 40, color: Colors.blueGrey)
                            : null,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Name Input Field
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Palindrome Input Field
                    TextField(
                      controller: _sentenceController,
                      decoration: InputDecoration(
                        hintText: 'Palindrome',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Check Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final sentence = _sentenceController.text;
                          if (sentence.isEmpty) {
                            _showResultDialog("Please enter a sentence.");
                            return;
                          }
                          final result = isPalindrome(sentence);
                          _showResultDialog(result ? "isPalindrome" : "not palindrome");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B637B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        child: const Text('CHECK'),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Next Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final name = _nameController.text;
                          context.read<AppProvider>().setName(name);
                          Navigator.pushNamed(context, '/second');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B637B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        child: const Text('NEXT'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}