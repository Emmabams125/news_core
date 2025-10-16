import 'package:flutter/material.dart';
import 'package:untitled/screens/history_screen.dart';
import 'package:untitled/screens/like_screen.dart';
import 'package:untitled/screens/profile_screen.dart';
import '../resources/app_colours.dart';

import 'home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  static const path = '/bottomNavBar';

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const HistoryScreen(),
    const LikeScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.home_rounded,
      Icons.history_rounded,
      Icons.favorite_border_rounded,
      Icons.person_outline_rounded,
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 65,
        decoration: BoxDecoration(
          color: AppColors.primaryPurple,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(icons.length, (index) {
            final isActive = index == _selectedIndex;
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white24 : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icons[index],
                  color: isActive ? Colors.white : Colors.white70,
                  size: isActive ? 28 : 24,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
