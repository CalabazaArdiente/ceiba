import 'dart:developer';

import 'package:ceiba_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../services/post_service.dart';
import '../models/user.dart';
import '../models/post.dart';

class UserDetailsView extends StatefulWidget {
  final int userId;

  const UserDetailsView({required this.userId, super.key});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetailsView> {
  final UserService _userService = UserService();
  final PostService _postService = PostService();
  User? _user;
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final userId = widget.userId;
    _loadData(userId);
  }

  Future<void> _loadData(int id) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = await _userService.getUserById(id);
      final posts = await _postService.getPostsByUser(id);
      setState(() {
        _user = user;
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      log('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del usuario'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MainText(tittle: 'Nombre', description: _user?.name),
                  const SizedBox(height: 16),
                  _MainText(
                      tittle: 'Correo electrónico', description: _user?.email),
                  const SizedBox(height: 16),
                  _MainText(tittle: 'Teléfono', description: _user?.phone),
                  const SizedBox(height: 16),
                  const _MainText(tittle: 'Publicaciones:'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        final post = _posts[index];
                        return PostCard(post: post);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _MainText extends StatelessWidget {
  const _MainText({
    super.key,
    required this.tittle,
    this.description,
  });

  final String tittle;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tittle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description ?? '',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
