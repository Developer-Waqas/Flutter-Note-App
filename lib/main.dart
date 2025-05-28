import 'package:flutter/material.dart';
import 'package:flutter_notes_app/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'bindings/initial_bindings.dart';
import 'routes/app_routes.dart';

void main() async {
  await GetStorage.init();
  final authController = Get.put(AuthController());
  await authController.loadToken();
  InitialBindings().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notes App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
    );
  }
}
