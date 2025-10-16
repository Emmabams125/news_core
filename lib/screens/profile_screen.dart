import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controllers.dart';
import '../resources/app_colours.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const path = '/profile';

  @override
  Widget build(BuildContext context) {
    // Ensure AuthController is available
    final AuthController authController = Get.put(
      AuthController(),
      permanent: true,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Profile Picture Placeholder
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primaryPurple,
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 16),
              // User Name Placeholder
              const Text(
                'John Doe',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Email Placeholder
              const Text(
                'johndoe@example.com',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(height: 40),
              // Sign Out Button
              ElevatedButton.icon(
                onPressed: () async {
                  await authController.logout();
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
