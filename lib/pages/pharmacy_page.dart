import 'package:flutter/material.dart';
import 'package:healnet/pages/home_page.dart';
import 'package:healnet/pages/searchingPart.dart';

void main() {
  runApp(const MyApp());
}

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.local_pharmacy, color: Color.fromARGB(255, 244, 202, 252)),
                  child: Text(
                    'Medicines',
                    style: TextStyle(color: Color.fromARGB(255, 244, 202, 252)),
                  ),
                ),
                Tab(
                  icon: Icon(Icons.shopping_cart, color: Color.fromARGB(255, 244, 202, 252)),
                  child: Text(
                    'Orders',
                    style: TextStyle(color: Color.fromARGB(255, 244, 202, 252)),
                  ),
                ),
                Tab(
                  icon: Icon(Icons.info, color: Color.fromARGB(255, 244, 202, 252)),
                  child: Text(
                    'About',
                    style: TextStyle(color: Color.fromARGB(255, 244, 202, 252)),
                  ),
                ),
              ],
            ),
            title: const Text('Pharmacy'),
          ),
          body: const TabBarView(
            children: [
              MedicineTab(),
              Center(child: Text('Medicines Tab Content')),
              AboutTab(),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////THIRD TAB//////////////////////////////////////////////////////////////////
class AboutTab extends StatelessWidget {
  const AboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Text(
            'Services Offered:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '- Prescription Refills\n- Over-the-counter Medications\n- Health and Wellness Products',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 50),
          Text(
            'Contact Information:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Address:  390/F, Healnet hospital, Colombo',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'Phone:  (+94) 112-444-999',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'Email:  info@healnetpharmacy.com',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
