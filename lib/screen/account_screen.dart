import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AccountSettingsPage(),
    );
  }
}

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Account Settings👌',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign in to receive exclusive deals, live updates on your order status and more.',
                style: TextStyle(fontSize: 14.0, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                elevation: 0,
                height: 48,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onPressed: () {},
                color: const Color(0xFF0A8020),
                textColor: Colors.white,
                child: const Text(
                  "Sign in or Register",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const SizedBox(height: 15),

              // Settings list using cards
              _buildCard('Track order'),
              _buildCard('Terms & Conditions'),
              _buildCard('Privacy'),
              _buildCard('FAQs'),
              _buildCard('Nutrition'),
              _buildCard('Give feedback'),
              _buildCard('Rate us'),

              const SizedBox(height: 20),

              const Center(
                child: Text(
                  'Version: 1.6.0',
                  style: TextStyle(color: Colors.black87, fontSize: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      color: Colors.white,
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: Colors.grey, width: 0.1),
      ),
      child: ListTile(
        title: Text(title,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Color(0xFF0A8020),
        ),
        onTap: () {
          // Add onTap functionality here
        },
      ),
    );
  }
}
