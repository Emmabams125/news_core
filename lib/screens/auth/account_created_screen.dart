import 'package:flutter/material.dart';

import '../../resources/app_colours.dart';
import '../../widgets/custom_app_button.dart';

class AccountCreatedScreen extends StatelessWidget {
  const AccountCreatedScreen({super.key});

  static const path = '/accountCreated';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Group.png'),
            const SizedBox(height: 24),
            const Text(
              "Account Created",
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your news account has been ",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Center(
              child: const Text(
                "successfully created",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 100),
            CustomButton(
              text: "Continue to feed →",
              onPressed: () => Navigator.pushNamed(context, '/login'),
            ),
          ],
        ),
      ),
    );
  }
}
