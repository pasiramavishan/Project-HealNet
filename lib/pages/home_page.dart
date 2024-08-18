import 'package:flutter/material.dart';
import 'package:healnet/pages/pharmacy_page.dart';
import 'package:healnet/pages/wellness_app.dart';

import 'fitness_page.dart';
import 'healing_page.dart';
import 'heart_page.dart';
import 'hospital_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Management App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: <Widget>[
            GestureDetector(
              onTap: () => navigateToPage(context, const heartPage()),
              child: Container(
                color: Colors.blue,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite, size: 50, color: Colors.white),
                    Text('Heart', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => navigateToPage(context, const HospitalPage()),
              child: Container(
                color: Colors.green,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.local_hospital, size: 50, color: Colors.white),
                    Text('Hospital', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => navigateToPage(context, const healingPage()),
              child: Container(
                color: Colors.red,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.healing, size: 50, color: Colors.white),
                    Text('Healing', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => navigateToPage(context, const fitnessPage()),
              child: Container(
                color: Colors.orange,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.fitness_center, size: 50, color: Colors.white),
                    Text('Fitness', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => navigateToPage(context, const PharmacyPage()),
              child: Container(
                color: Colors.purple,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.local_pharmacy, size: 50, color: Colors.white),
                    Text('Pharmacy', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => navigateToPage(context, const wellnessPage()),
              child: Container(
                color: Colors.teal,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.spa, size: 50, color: Colors.white),
                    Text('Wellness', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}









