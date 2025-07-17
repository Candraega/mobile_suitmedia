import 'dart:io';
import 'package:flutter/foundation.dart';

class AppProvider with ChangeNotifier {
  String _name = '';
  File? _profileImage;
  // State baru untuk menyimpan nama user yang dipilih
  String _selectedUserName = 'Selected User Name';

  String get name => _name;
  File? get profileImage => _profileImage;
  // Getter untuk state baru
  String get selectedUserName => _selectedUserName;

  void setName(String newName) {
    _name = newName.isEmpty ? "Anonymous" : newName;
    notifyListeners();
  }

  void setProfileImage(File? image) {
    _profileImage = image; 
    notifyListeners();
  }

  // Method untuk mengubah nama user yang dipilih
  void setSelectedUserName(String newUserName) {
    _selectedUserName = newUserName;
    notifyListeners();
  }
}
