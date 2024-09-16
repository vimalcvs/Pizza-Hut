import 'package:flutter/material.dart';

class PizzaApp extends StatelessWidget {
  const PizzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PizzaHome(),
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}

class PizzaHome extends StatelessWidget {
  final List<Map<String, dynamic>> pizzaList = [
    {
      'name': 'Schezwan Margherita',
      'price': 199,
      'image': 'assets/pizza1.png', // Replace with your images
      'customisable': true,
      'isNew': false,
    },
    {
      'name': 'Awesome American Cheesy',
      'price': 359,
      'image': 'assets/pizza2.png',
      'customisable': true,
      'isNew': false,
    },
    {
      'name': 'Ultimate Tandoori Veggie',
      'price': 359,
      'image': 'assets/pizza3.png',
      'customisable': true,
      'isNew': true,
    },
    {
      'name': 'Mexican Fiesta',
      'price': 299,
      'image': 'assets/pizza4.png',
      'customisable': true,
      'isNew': true,
    },
  ];

  PizzaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pizza Hut"),
        actions: const [
          Icon(Icons.shopping_cart),
        ],
      ),
      body: Column(
        children: [
          // Category Tabs
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCategoryTab("Deals"),
                _buildCategoryTab("Pizzas", isSelected: true),
                _buildCategoryTab("Melts"),
                _buildCategoryTab("Sides"),
                _buildCategoryTab("Pastas"),
              ],
            ),
          ),
          // Pizza List
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: pizzaList.length,
              itemBuilder: (context, index) {
                final pizza = pizzaList[index];
                return _buildPizzaItem(pizza);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String name, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        // Handle tab click
      },
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.red : Colors.grey,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 2),
              height: 2,
              width: 40,
              color: Colors.red,
            ),
        ],
      ),
    );
  }

  Widget _buildPizzaItem(Map<String, dynamic> pizza) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                pizza['image'],
                fit: BoxFit.cover,
                height: 120,
                width: double.infinity,
              ),
              if (pizza['isNew'])
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    color: Colors.white,
                    child: const Text(
                      "NEW",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  color: Colors.white,
                  child: const Text(
                    "CUSTOMISE",
                    style: TextStyle(
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
            child: Text(
              pizza['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Select size & crust",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              isExpanded: true,
              value: 'Personal Pan',
              items: const [
                DropdownMenuItem(
                    value: "Personal Pan", child: Text("Personal Pan")),
                DropdownMenuItem(value: "Medium", child: Text("Medium")),
                DropdownMenuItem(value: "Large", child: Text("Large")),
              ],
              onChanged: (value) {
                // Handle selection
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle add to cart
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text("Add"),
                ),
                Text(
                  "₹${pizza['price']}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
