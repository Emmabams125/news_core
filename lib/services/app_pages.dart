import 'package:flutter/material.dart';
import 'package:untitled/screens/auth/account_created_screen.dart';
import 'package:untitled/services/route_names.dart';
import 'package:get/get.dart';

import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/bottom_nav_bar.dart';
import '../screens/home_screen.dart';

class AppPages {
  static final routes = [
    GetPage(name: Routes.login, page: () => const LoginScreen()),
    GetPage(name: Routes.home, page: () => const HomeScreen()),
    GetPage(name: Routes.splashScreen, page: () => const SplashScreen()),
    GetPage(name: Routes.register, page: () => const RegisterScreen()),
    GetPage(name: Routes.bottomNavBar, page: () => const BottomNavBar()),
    GetPage(
      name: Routes.accountCreated,
      page: () => const AccountCreatedScreen(),
    ),
  ];
}
