// lib/screens/second_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Tonton perubahan pada provider untuk mendapatkan data terbaru
    final appProvider = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.2),
        iconTheme: const IconThemeData(
          color: Color(0xFF545454)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // a. Teks "Welcome"
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            // b. Nama dinamis dari FirstScreen
            Text(
              appProvider.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            
            // Spacer untuk memberi ruang di tengah
            const Spacer(),
            
            // Teks dinamis untuk nama pengguna yang dipilih
            Center(
              child: Text(
                appProvider.selectedUserName,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            
            // Spacer untuk mendorong tombol ke bawah
            const Spacer(),
            
            // c. Tombol "Choose a User"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // d. Aksi untuk pindah ke layar ketiga
                onPressed: () {
                  Navigator.pushNamed(context, '/third');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B637B),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Choose a User'),
              ),
            ),
          ], 
        ),
      ),
    );
  }
}