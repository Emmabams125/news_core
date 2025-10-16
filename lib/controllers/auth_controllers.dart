import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_config.dart';
import '../helpers/hive_helper.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  /// REGISTER USER
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      final response = await SupabaseConfig.client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user != null) {
        Get.snackbar('Success', 'Account created successfully.');
        Get.offAllNamed('/accountCreated');
      } else {
        Get.snackbar('Error', 'Signup failed. Try again.');
      }
    } on AuthException catch (e) {
      Get.snackbar('Auth Error', e.message);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// LOGIN USER
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      final response = await SupabaseConfig.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        final token = response.session!.accessToken;
        await HiveHelper.saveToken(token);
        Get.snackbar('Success', 'Login successful!');
        Get.offAllNamed('/bottomNavBar');
      } else {
        Get.snackbar('Error', 'Invalid credentials.');
      }
    } on AuthException catch (e) {
      Get.snackbar('Auth Error', e.message);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// GOOGLE LOGIN
  Future<void> loginWithGoogle() async {
    try {
      await SupabaseConfig.client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.flutter://login-callback/',
      );
    } on AuthException catch (e) {
      Get.snackbar('Auth Error', e.message);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  /// FACEBOOK LOGIN
  Future<void> loginWithFacebook() async {
    try {
      await SupabaseConfig.client.auth.signInWithOAuth(
        OAuthProvider.facebook,
        redirectTo: 'io.supabase.flutter://login-callback/',
      );
    } on AuthException catch (e) {
      Get.snackbar('Auth Error', e.message);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    try {
      await SupabaseConfig.client.auth.signOut();
      await HiveHelper.clearToken();
      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar('Error', 'Could not log out');
    }
  }
}
