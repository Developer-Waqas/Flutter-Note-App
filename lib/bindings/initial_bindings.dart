import 'package:flutter_notes_app/controller/auth_controller.dart';
import 'package:flutter_notes_app/controller/note_controller.dart';
import 'package:get/get.dart';


class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => NotesController());
  }
}
