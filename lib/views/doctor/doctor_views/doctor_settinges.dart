import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Doc_Settings extends StatelessWidget {
  const Doc_Settings();
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? email = user?.email;
    String? name = user?.displayName;
    String? imageUrl = user?.photoURL;

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Profile'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
              child: imageUrl == null
                  ? const Icon(Icons.person, size: 60, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 20),
            Text(
              email!.contains('@') ? email!.split('@')[0] : 'Name not available',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              email ?? 'Email not available',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
