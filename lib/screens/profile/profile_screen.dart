import 'package:flutter/material.dart';
import 'wishlist_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
              ListTile(
                leading : const Icon(Icons.favorite_border),
                title : const Text('WishList'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_)=> const WishListScreen()),
                  );
                },
              ),
        ],
      ),
    );
  }
}