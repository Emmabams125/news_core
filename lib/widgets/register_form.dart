import 'package:flutter/material.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, width: 24, height: 24),
          const SizedBox(width: 8),
          Text(text),
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
          Image.asset(
            color: Color(0xFF071A27),
            'assets/images/Frame.png',
            width: 24, // adjust width as needed
            height: 24, // optional: adjust height too
            fit: BoxFit.contain, // ensures the image scales nicely
          ),
          SizedBox(height: 10),
          Text(
            'Create Account',
            style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: authController.loginWithGoogle,
                child: _socialButton('assets/images/Google.png', "Google"),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: authController.loginWithFacebook,
                child: _socialButton('assets/images/Facebook.png', "Facebook"),
              ),
            ],
          ),

          const SizedBox(height: 24),
          VerticalLabelField(
            controller: nameController,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF071A27),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: null,
              hintText: "Enter your user name",
              hintStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(3),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            keyboardType: TextInputType.name,
            label: 'User name',
          ),
          const SizedBox(height: 12),
          VerticalLabelField(
            label: 'Email',
            controller: emailController,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF071A27),
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: null,
              hintText: "Enter your email",
              hintStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(3),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(3),
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
                fillColor: Colors.grey[200],
                prefixIcon: null,
                hintText: "Enter your password",
                hintStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(3),
                ),
                suffixIcon: IconButton(
                  icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
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
          const SizedBox(height: 24),
          // CustomAppButton(
          //   text: "Register",
          //   onPressed: submitForm,
          // ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 148, // Hug width
                height: 56, // Hug height
                child: Obx(
                  () => ElevatedButton(
                    onPressed: authController.isLoading.value
                        ? null
                        : submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF071A27), // Dark blue
                      padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                    ),
                    child: authController.isLoading.value
                        ? SizedBox(
                            width: 24,
                            height: 24,
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
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 7),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
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
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: const Color(0xFF071A27),
                    fontWeight: FontWeight.w500,
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
