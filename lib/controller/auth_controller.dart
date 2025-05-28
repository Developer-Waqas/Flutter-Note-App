import 'package:flutter_notes_app/routes/app_routes.dart';
import 'package:flutter_notes_app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final box = GetStorage();

  Future<void> loadToken() async {
    final savedToken = box.read('jwt_token');
    if (savedToken != null) {
      ApiService.token = savedToken;
      Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final token = await ApiService.login(email, password);
    isLoading.value = false;
    if (token != null) {
      await box.write('jwt_token', token);
      ApiService.token = token;
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar('Error', 'Login failed');
    }
  }

  Future<void> register(String email, String password) async {
    isLoading.value = true;
    final success = await ApiService.register(email, password);
    isLoading.value = false;
    if (success) {
      Get.snackbar('Success', 'Registered! Please log in.');
      Get.offNamed(Routes.LOGIN);
    } else {
      Get.snackbar('Error', 'Registration failed');
    }
  }

  Future<void> logout() async {
    await box.remove('jwt_token');
    ApiService.token = '';
    Get.offAllNamed(Routes.LOGIN);
  }
}
