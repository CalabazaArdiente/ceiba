import 'package:ceiba_app/models/post.dart';
import 'package:ceiba_app/tools/design_system.dart';
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
      margin: const EdgeInsets.symmetric(
          vertical: secondaryVerticalPadding,
          horizontal: secondaryHorizontalPadding),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: mainVerticalPadding, horizontal: mainHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(
                  fontSize: mainTextSize,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            const SizedBox(height: secondaryVerticalPadding),
            Text(
              post.body,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: secondaryVerticalPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed:
                      () {}, // TODO: Implementar navegación a la pantalla de detalles de la publicación
                  child: const Text(
                    'VER DETALLES',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
