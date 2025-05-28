import 'package:flutter/material.dart';
import 'package:flutter_notes_app/controller/auth_controller.dart';
import 'package:flutter_notes_app/routes/app_routes.dart';
import 'package:get/get.dart';


class LoginView extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Obx(
              () =>
                  authController.isLoading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: () {
                          authController.login(
                            emailController.text,
                            passwordController.text,
                          );
                        },
                        child: const Text('Login'),
                      ),
            ),
            TextButton(
              onPressed: () => Get.toNamed(Routes.REGISTER),
              child: const Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
