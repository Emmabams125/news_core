import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/auth_controllers.dart';
import '../resources/app_colours.dart';
import '../services/route_names.dart';
import '../widgets/vertical_label_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePasswordNotifier = ValueNotifier(true);

  final AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    obscurePasswordNotifier.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    await authController.loginUser(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  Widget _socialButton(String imagePath, String text) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(imagePath, width: 22.w, height: 22.h),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/Star1.svg',
            width: 24, // adjust width as needed
            height: 24, // optional: adjust height too
            // ensures the image scales nicely
          ),
          const SizedBox(height: 10),
          Text(
            'Login',
            style: TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.darkNavy,
            ),
          ),
          const SizedBox(height: 16),

          // Social Buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: authController.loginWithGoogle,
                  child: _socialButton('assets/icons/Google.svg', "Google"),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: GestureDetector(
                  onTap: authController.loginWithFacebook,
                  child: _socialButton('assets/icons/Group2.svg', "Facebook"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Email
          VerticalLabelField(
            label: 'Email',
            controller: emailController,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.darkNavy,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.primaryGrey,
              hintText: "Enter your email",
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFFD9D9D9),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFFD9D9D9),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.darkNavy, width: 1.5),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                value!.isEmpty ? "Please enter your email" : null,
          ),

          const SizedBox(height: 12),

          // Password
          ValueListenableBuilder<bool>(
            valueListenable: obscurePasswordNotifier,
            builder: (context, obscure, _) => VerticalLabelField(
              label: 'Password',
              controller: passwordController,
              obscureText: obscure,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.primaryGrey,
                hintText: "Enter your password",
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFD9D9D9),
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFD9D9D9),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.darkNavy, width: 1.5),
                ),
                suffixIcon: IconButton(
                  icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => obscurePasswordNotifier.value = !obscure,
                ),
              ),
              validator: (value) =>
                  value!.isEmpty ? "Please enter your password" : null,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.darkNavy,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  height: 1.5,
                  color: AppColors.darkNavy,
                ),
              ),
            ),
          ),

          const SizedBox(height: 60),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Get.toNamed(Routes.register),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    height: 1.5,
                    color: AppColors.darkNavy,
                  ),
                ),
              ),
              Obx(
                () => ElevatedButton(
                  onPressed: authController.isLoading.value ? null : submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkNavy,
                    minimumSize: Size(130.w, 56.h),
                    padding: EdgeInsets.fromLTRB(30.w, 16.h, 30.w, 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    elevation: 0,
                  ),
                  child: authController.isLoading.value
                      ? SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: CircularProgressIndicator(
                            color: AppColors.primaryPurple,
                            strokeWidth: 3,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            SvgPicture.asset(
                              'assets/icons/arrow-up.svg',
                              // optional: adjust height too
                              // ensures the image scales nicely
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
