import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/screens/auth/account_created_screen.dart';
import '../../widgets/custom_app_button.dart';
import 'package:untitled/widgets/vertical_label_field.dart';
import '../controllers/auth_controllers.dart';
import '../resources/app_colours.dart';
import '../services/route_names.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final obscurePasswordNotifier = ValueNotifier(true);
  final obscureConfirmPasswordNotifier = ValueNotifier(true);

  final AuthController authController = Get.put(AuthController());

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    obscurePasswordNotifier.dispose();
    obscureConfirmPasswordNotifier.dispose();
    super.dispose();
  }

  Future<void> submitForm() async {
    if (!formKey.currentState!.validate()) return;

    await authController.registerUser(
      name: nameController.text.trim(),
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
    return SingleChildScrollView(
      child: Form(
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
            SizedBox(height: 10),
            Text(
              'Create Account',
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
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
            VerticalLabelField(
              label: 'User name',
              controller: nameController,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.darkNavy,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.primaryGrey,
                hintText: "Enter your user name",
                hintStyle: const TextStyle(
                  fontFamily: 'Satoshi',
                  color: Colors.grey,
                ),

                // PADDING = (padding-left/right 16px, top/bottom 12px)
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                // BORDER = (radius 8px, border color #D9D9D9, width 1)
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
              keyboardType: TextInputType.name,
            ),

            const SizedBox(height: 12),
            VerticalLabelField(
              label: 'Email',
              controller: emailController,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.darkNavy,
              ),

              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.primaryGrey,
                prefixIcon: null,
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
            ),
            const SizedBox(height: 12),
            ValueListenableBuilder<bool>(
              valueListenable: obscurePasswordNotifier,
              builder: (context, obscure, _) => VerticalLabelField(
                controller: passwordController,
                obscureText: obscure,
                contextPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.primaryGrey,
                  prefixIcon: null,
                  hintText: "Enter your password",
                  hintStyle: const TextStyle(color: Colors.grey),
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
                    borderSide: BorderSide(
                      color: AppColors.darkNavy,
                      width: 1.5,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => obscurePasswordNotifier.value = !obscure,
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please enter a password" : null,
                label: 'Password',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF071A27),
                ),
              ),
            ),
            const SizedBox(height: 50),

            // CustomAppButton(
            //   text: "Register",
            //   onPressed: submitForm,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: authController.isLoading.value
                          ? null
                          : submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkNavy,
                        minimumSize: Size(148.w, 56.h),
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
                                  "Sign Up",
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
                ),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.login),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: AppColors.darkNavy,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
