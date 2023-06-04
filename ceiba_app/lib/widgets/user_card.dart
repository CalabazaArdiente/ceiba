import 'package:ceiba_app/models/user.dart';
import 'package:ceiba_app/tools/design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(secondaryHorizontalPadding),
      child: Padding(
        padding: const EdgeInsets.all(mainHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                  fontSize: mainTextSize,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            const SizedBox(height: secondaryVerticalPadding),
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: primaryColor,
                ),
                const SizedBox(width: secondaryHorizontalPadding),
                Text(user.phone),
              ],
            ),
            const SizedBox(height: secondaryVerticalPadding),
            Row(
              children: [
                const Icon(
                  Icons.email,
                  color: primaryColor,
                ),
                const SizedBox(width: secondaryHorizontalPadding),
                Text(user.email),
              ],
            ),
            const SizedBox(height: secondaryVerticalPadding),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => Get.toNamed('/details', arguments: user.id),
                child: const Text(
                  'VER PUBLICACIONES',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
