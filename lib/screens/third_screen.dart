// lib/screens/third_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/app_provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();
  List<User> _users = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    // Ambil data pertama kali saat layar dibuka
    _fetchUsers();

    // Tambahkan listener ke scroll controller untuk infinite scrolling
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _fetchUsers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Fungsi untuk mengambil data user dari API
  Future<void> _fetchUsers({bool isRefresh = false}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    if (isRefresh) {
      _currentPage = 1;
      _users = [];
      _hasMore = true;
    }

    final url = Uri.parse('https://reqres.in/api/users?page=$_currentPage&per_page=10');
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> userList = data['data'];
        final int totalPages = data['total_pages'];

        setState(() {
          _users.addAll(userList.map((userJson) => User.fromJson(userJson)).toList());
          if (_currentPage >= totalPages) {
            _hasMore = false;
          }
          _currentPage++;
        });
      }
    } catch (e) {
      // Handle error jika ada
      print('Error fetching users: $e');
    } finally {
      if(mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Fungsi untuk pull-to-refresh
  Future<void> _onRefresh() async {
    await _fetchUsers(isRefresh: true);
  }

  Widget _buildUserList() {
    // Tampilkan empty state jika data kosong setelah selesai loading
    if (_users.isEmpty && !_isLoading) {
      return const Center(
        child: Text(
          'Tidak ada data pengguna.\nCoba tarik ke bawah untuk me-refresh.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: _users.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        // Tampilkan loading indicator di bagian bawah list
        if (index == _users.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final user = _users[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.avatar),
          ),
          title: Text('${user.firstName} ${user.lastName}'),
          subtitle: Text(user.email),
          onTap: () {
            // Update nama user di provider
            final fullName = '${user.firstName} ${user.lastName}';
            context.read<AppProvider>().setSelectedUserName(fullName);
            // Kembali ke Second Screen
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen'),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.2),
        iconTheme: const IconThemeData(color: Color(0xFF545454)),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _buildUserList(),
      ),
    ); 
  }
}