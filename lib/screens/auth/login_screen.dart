import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../resources/app_colours.dart';
import '../../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const path = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPurple,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: kToolbarHeight + 20),

                // --- Logo & Title
                Column(
                  children: [
                    SvgPicture.asset('assets/icons/Frame3.svg'),
                    const SizedBox(height: 10),
                    Text(
                      'News Core',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 28.sp,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 100),

                // --- Layered Containers
                Center(
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // --- Back transparent layer (smallest & highest)
                      Positioned(
                        top: -18.h, // lifted up slightly
                        child: Container(
                          width: 310.w,
                          height: 502.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),

                      Positioned(
                        top: -9.h, // between back and main
                        child: Container(
                          width: 330.w,
                          height: 492.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),

                      Container(
                        width: 350.w,
                        height: 506.h,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const LoginForm(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
