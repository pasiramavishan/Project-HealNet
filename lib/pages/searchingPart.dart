import 'package:flutter/material.dart';
import 'package:healnet/pages/fitness_page.dart';
import 'package:healnet/pages/healing_page.dart';
import 'package:healnet/pages/pharmacy_page.dart';
import 'package:healnet/pages/wellness_app.dart';

import 'heart_page.dart';
import 'hospital_page.dart';

class MedicineTab extends StatefulWidget {
  const MedicineTab({super.key});

  @override
  State<MedicineTab> createState() => _MedicineTabState();
}

class _MedicineTabState extends State<MedicineTab> {
  final String _searchText = '';

  final List<Map<String, dynamic>> _items = [
    {'icon': Icons.favorite, 'color': Colors.blue, 'label': 'Heart', 'page': const heartPage()},
    {'icon': Icons.local_hospital, 'color': Colors.green, 'label': 'Hospital', 'page': const HospitalPage()},
    {'icon': Icons.healing, 'color': Colors.red, 'label': 'Healing', 'page': const healingPage()},
    {'icon': Icons.fitness_center, 'color': Colors.orange, 'label': 'Fitness', 'page': const fitnessPage()},
    {'icon': Icons.local_pharmacy, 'color': Colors.purple, 'label': 'Pharmacy', 'page': const PharmacyPage()},
    {'icon': Icons.spa, 'color': Colors.teal, 'label': 'Wellness', 'page': const wellnessPage()},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _filteredItems = _items
        .where((item) =>
        item['label'].toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Medicine',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(_items),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: _filteredItems.map((item) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item['page']),
              ),
              child: Container(
                color: item['color'],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(item['icon'], size: 50, color: Colors.white),
                    Text(item['label'], style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> items;

  CustomSearchDelegate(this.items);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Map<String, dynamic>> _filteredItems = items
        .where((item) =>
        item['label'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: _filteredItems.map((item) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item['page']),
          ),
          child: Container(
            color: item['color'],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item['icon'], size: 50, color: Colors.white),
                Text(item['label'], style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Map<String, dynamic>> _filteredItems = items
        .where((item) =>
        item['label'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: _filteredItems.map((item) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item['page']),
          ),
          child: Container(
            color: item['color'],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item['icon'], size: 50, color: Colors.white),
                Text(item['label'], style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
