import 'package:ceiba_app/models/post.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(post.body),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed:
                      () {}, // TODO: Implementar navegación a la pantalla de detalles de la publicación
                  child: const Text('Ver detalles'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
