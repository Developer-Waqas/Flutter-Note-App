import 'package:flutter_notes_app/views/home_view.dart';
import 'package:flutter_notes_app/views/login_view.dart';
import 'package:flutter_notes_app/views/register_view.dart';
import 'package:get/get.dart';

abstract class Routes {
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const HOME = '/home';
}


class AppPages {
  static final routes = [
    GetPage(name: Routes.LOGIN, page: () => LoginView()),
    GetPage(name: Routes.REGISTER, page: () => RegisterView()),
    GetPage(name: Routes.HOME, page: () => HomeView()),
  ];
}
