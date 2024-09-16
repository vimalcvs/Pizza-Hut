import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import 'menu_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildImageBanner(),
            _buildGreetingSection(),
            _buildSectionTitle(context, 'Menu', 'View deals',
                () => _navigateToScreen(context, const MenuScreen())),
            _buildHotDealList(),
            _buildSectionTitle(context, 'Menu', 'View menu',
                () => _navigateToScreen(context, const MenuScreen())),
            _buildMenuDealList(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildImageBanner() {
    return CachedNetworkImage(
        imageUrl:
            "https://www.pizzahut.co.in/order/images/backgrounds/in/en-IN/home-bg-lg.4f1162d6605078aa9cdf4f8cb8c9c6a3.jpg",
        height: 180,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Icon(Icons.error));
  }

  Widget _buildGreetingSection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello there!🍕',
            style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const Text(
            'Select Delivery or Takeaway to see local deals',
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          _buildCard('Track order', 'View your order status',
              'assets/images/pizza_name.svg'),
          _buildCard('Terms & Conditions', 'View our terms and conditions',
              'assets/images/pizza_name.svg'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title,
      String actionText, VoidCallback onActionTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          GestureDetector(
            onTap: onActionTap,
            child: Text(actionText,
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.green)),
          ),
        ],
      ),
    );
  }

  Widget _buildHotDealList() {
    return SizedBox(
      height: 180,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildHotDeal(
                'https://api.pizzahut.io/v1/content/en-in/in-1/images/promo/hut300.9f6133b5006c985a6a9f30af1c7acc89.1.jpg'),
            _buildHotDeal(
                'https://api.pizzahut.io/v1/content/en-in/in-1/images/promo/melts-meal-with-pepsi-zero-sugar.ff926f59503846849f86a0de94a67279.1.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuDealList() {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildMenuDeal('Pizza',
                'https://api.pizzahut.io/v1/content/en-in/in-1/images/pizza/mazedar-makhni-paneer.cb3150d2be9cb8dcd248be70921c5196.1.jpg'),
            _buildMenuDeal('Melts',
                'https://api.pizzahut.io/v1/content/en-in/in-1/images/side/loaded-veggie-bbq-single.f947c28d2a08a955238dd425a783b01c.1.jpg'),
            _buildMenuDeal('Sides',
                'https://api.pizzahut.io/v1/content/en-in/in-1/images/side/zesty-chicken-pocket.dbe88abe1adeee1dc4d5bec7390327f0.1.jpg'),
            _buildMenuDeal('Pastas',
                'https://api.pizzahut.io/v1/content/en-in/in-1/images/side/spiced-tomato-twist-veg-single.681dd4eaf5abe803c451682a7dca5d8e.1.jpg'),
            _buildMenuDeal('Desserts',
                'https://api.pizzahut.io/v1/content/en-in/in-1/images/dessert/choco-volcano-single.f829dc6e30a07b83f232b4880395162f.1.jpg'),
            _buildMenuDeal('Drinks',
                'https://api.pizzahut.io/v1/content/en-in/in-1/images/drink/7-up.15b00a4f5a8acd746ca6ae6f6e2d0330.1.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildHotDeal(String image) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      color: Colors.white,
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CachedNetworkImage(
          imageUrl: image,
          errorWidget: (context, url, error) => const Icon(Icons.error)),
    );
  }

  Widget _buildMenuDeal(String title, String image) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
              imageUrl: image,
              height: 100,
              errorWidget: (context, url, error) => const Icon(Icons.error)),
          const SizedBox(height: 5),
          Text(title,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, String image) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ListTile(
        title: Text(title,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 14.0)),
        leading: SvgPicture.asset(image, width: 32.0),
        trailing: const Icon(Icons.arrow_forward_ios,
            size: 14, color: Color(0xFF0A8020)),
        onTap: () {},
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
