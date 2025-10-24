import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../helpers/hive_helper.dart';
import '../../resources/app_colours.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Give the splash a short delay to show brand
    await Future.delayed(const Duration(milliseconds: 800));

    final token = await HiveHelper.getToken();
    if (token != null) {
      print('Found saved token, navigating to home.');
      // Optional: you could validate token by calling Supabase /user endpoint
      Navigator.pushReplacementNamed(context, 'bottomNavBar');
    } else {
      Navigator.pushReplacementNamed(context, '/register'); // or login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/Frame3.svg'),
            const SizedBox(height: 16),
            Text(
              'News Core',
              style: TextStyle(
                fontFamily: 'Satoshi',
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
