// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:med_app/pages/activity_page.dart';
import 'package:med_app/pages/meds_page.dart';
import 'package:med_app/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedindex = 0;

  void _navigationBottomBar(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  final List _pages = [
    // meds page
    MedsPage(),
    // activity page
    ActivityPage(),
    // profile page
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedindex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.blue[200],
        currentIndex: _selectedindex,
        onTap: _navigationBottomBar,
        items: [
          // meds page
          BottomNavigationBarItem(
            icon: const Text(
              'Medications',
              style: TextStyle(color: Colors.white),
            ),
            label: 'Meds Page',
            activeIcon: Column(
              children: [
                const Text(
                  'Medications',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 5),
                Container(
                  // color: Colors.blueGrey[100],
                  width: 74,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blueGrey[50],
                  ),
                ),
              ],
            ),
          ),

          // activity page
          BottomNavigationBarItem(
            icon: const Text(
              'Activity',
              style: TextStyle(color: Colors.white),
            ),
            label: 'Activity Page',
            activeIcon: Column(
              children: [
                const Text(
                  'Activity',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 5),
                Container(
                  // color: Colors.blueGrey[100],
                  width: 45,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blueGrey[50],
                  ),
                ),
              ],
            ),
          ),

          // profile
          BottomNavigationBarItem(
            icon: const Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
            label: 'Profile Page',
            activeIcon: Column(
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 5),
                Container(
                  // color: Colors.blueGrey[100],
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blueGrey[50],
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
