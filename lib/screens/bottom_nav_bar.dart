import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final svgIcons = [
      'assets/icons/home.svg',
      'assets/icons/explore.svg',
      'assets/icons/heart.svg',
      'assets/icons/profile.svg',
    ];

    return Scaffold(
      body: _screens[_selectedIndex],
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: AppColors.primaryPurple,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(svgIcons.length, (index) {
                final isActive = index == _selectedIndex;
                return GestureDetector(
                  onTap: () => _onItemTapped(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 48,
                    height: 36,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color(0xFF071A27)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: SvgPicture.asset(
                      svgIcons[index],
                      color: isActive ? Colors.white : Colors.white70,
                      width: isActive ? 26 : 24,
                      height: isActive ? 26 : 24,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
