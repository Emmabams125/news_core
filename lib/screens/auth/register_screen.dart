import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/app_colours.dart';
import '../../widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const path = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPurple,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                // --- Logo & Title
                Column(
                  children: [
                    Image.asset('assets/images/Frame.png'),
                    const SizedBox(height: 10),
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

                const SizedBox(height: 60),

                // --- Layered Containers
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // --- Back transparent layer (smaller & higher)
                      Positioned(
                        top: -24.h, // shifted upward
                        child: Container(
                          width: 310.w,
                          height: 534.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),

                      // --- Middle transparent layer (slightly larger & higher)
                      Positioned(
                        top: -12.h, // slightly lower than the back one
                        child: Container(
                          width: 330.w,
                          height: 534.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),

                      // --- Top white main layer (fully visible)
                      Container(
                        width: 350.w,
                        height: 560.h,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const RegisterForm(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
