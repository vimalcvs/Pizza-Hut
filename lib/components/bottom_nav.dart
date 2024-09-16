import 'package:flutter/material.dart';

import '../screen/account_screen.dart';
import '../screen/home_screen.dart';
import '../screen/menu_screen.dart';

class BottomNavExample extends StatefulWidget {
  const BottomNavExample({super.key});

  @override
  _BottomNavExampleState createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _currentIndex = 0;

  // List of pages for Home and Account
  final List<Widget> _pages = [
    const HomeScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 2
          ? _pages[1] // Show AccountScreen when index is 2
          : _pages[0], // Show HomeScreen by default
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            // Open new activity (MenuScreen) when "Menu" is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuScreen()),
            );
          } else {
            // Update index for Home and Account screens
            setState(() {
              _currentIndex = index;
            });
          }
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 0
                  ? Icons.water_damage_rounded
                  : Icons.water_damage_outlined,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.fastfood_rounded, // Menu icon
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 2
                  ? Icons.account_circle_rounded
                  : Icons.account_circle_outlined,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
