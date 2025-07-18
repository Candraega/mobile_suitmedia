// lib/screens/second_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    // Ambil data gambar profil dari provider
    final profileImage = appProvider.profileImage;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.2),
        iconTheme: const IconThemeData(color: Color(0xFF545454)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Menampilkan foto profil yang di-upload
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: profileImage != null
                      ? FileImage(profileImage)
                      : null,
                  child: profileImage == null
                      ? Icon(
                          Icons.person_outline,
                          size: 30,
                          color: Colors.grey.shade600,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                // Teks Welcome dan Nama
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      appProvider.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

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

            // Tombol "Choose a User"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
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
