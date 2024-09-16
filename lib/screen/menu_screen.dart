import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> _tabTitles = [];
  final Map<String, Future<List<Map<String, dynamic>>>> _categoryData = {};
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final response = await http.get(
          Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _categories = List<Map<String, dynamic>>.from(data['categories']);
          _tabTitles = _categories
              .map((category) => category['strCategory'] as String)
              .toList();
          _tabController =
              TabController(length: _tabTitles.length, vsync: this);
          _tabController.addListener(_onTabChange);
          _isLoading = false;
          _categoryData[_tabTitles.first] = _fetchList(_tabTitles.first);
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to load categories: ${e.toString()}';
      });
    }
  }

  Future<List<Map<String, dynamic>>> _fetchList(String category) async {
    try {
      final response = await http.get(Uri.parse(
          "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category"));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['meals']);
      } else {
        throw Exception('Failed to load category data');
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load data for $category: ${e.toString()}';
      });
      return [];
    }
  }

  void _onTabChange() {
    if (_tabController.indexIsChanging) {
      final selectedCategory = _tabTitles[_tabController.index];
      if (!_categoryData.containsKey(selectedCategory)) {
        _categoryData[selectedCategory] = _fetchList(selectedCategory);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SvgPicture.asset(
          'assets/images/pizza_name.svg',
          height: 32.0,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: _tabTitles.isNotEmpty
            ? PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.white,
                  labelStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: const Color(0xFFc8102e),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tabs: _tabTitles.map((title) {
                    return Tab(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: -10),
                        child: Text(title),
                      ),
                    );
                  }).toList(),
                ),
              )
            : null,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : TabBarView(
                  controller: _tabController,
                  children: _tabTitles.map((title) {
                    return FutureBuilder<List<Map<String, dynamic>>>(
                      future: _categoryData[title] ?? _fetchList(title),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text('No data available'));
                        } else {
                          final categoryData = snapshot.data!;
                          return GridView.builder(
                            itemCount: categoryData.length,
                            itemBuilder: (context, index) {
                              final item = categoryData[index];
                              return _buildPizzaItem(item['idMeal'],
                                  item['strMeal'], item['strMealThumb']);
                            },
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 240,
                              childAspectRatio: 0.66,
                            ),
                          );
                        }
                      },
                    );
                  }).toList(),
                ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildPizzaItem(String id, String title, String image) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
      elevation: 2.5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 0.2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1 / 0.6,
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  child: const Text(
                    "CUSTOMISE",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: Colors.black87),
                ),
                const SizedBox(height: 2),
                const Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.crop_square_sharp,
                      color: Colors.green,
                      size: 28,
                    ),
                    Icon(Icons.circle, color: Colors.green, size: 9),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "Select size & crust",
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 4),
                Positioned(
                  child: Container(
                    width: double.infinity,
                    height: 34,
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: 'Personal Pan',
                        items: const [
                          DropdownMenuItem(
                              value: "Personal Pan",
                              child: Text("Personal Pan")),
                          DropdownMenuItem(
                              value: "Medium", child: Text("Medium")),
                          DropdownMenuItem(
                              value: "Large", child: Text("Large")),
                        ],
                        onChanged: (value) {
                          // Handle selection
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Positioned(
                  child: Container(
                    width: double.infinity,
                    height: 34,
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A8020),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "\$12.00",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
