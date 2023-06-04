import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/user_service.dart';
import '../services/post_service.dart';
import '../models/user.dart';
import '../models/post.dart';

class UserDetailsView extends StatefulWidget {
  @override
  _UserDetailsViewState createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  final UserService _userService = UserService();
  final PostService _postService = PostService();
  User? _user;
  List<Post> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final userId = Get.arguments as int;
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
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del usuario'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre: ${_user?.name}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Correo electrónico: ${_user?.email}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Teléfono: ${_user?.phone}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Publicaciones:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        final post = _posts[index];
                        return ListTile(
                          title: Text(post.title),
                          subtitle: Text(post.body),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
