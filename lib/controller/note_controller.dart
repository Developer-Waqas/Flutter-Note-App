import 'package:flutter_notes_app/services/api_services.dart';
import 'package:get/get.dart';
import '../models/note_model.dart';

class NotesController extends GetxController {
  var notes = <NoteModel>[].obs;
  var isLoading = false.obs;

  Future<void> loadNotes() async {
    try {
      isLoading.value = true;
      notes.value = await ApiService.fetchNotes();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load notes');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addNote(String title, String content) async {
    try {
      isLoading.value = true;
      final success = await ApiService.addNote(
        NoteModel(title: title, content: content),
      );
      if (success) {
        await loadNotes();
      } else {
        Get.snackbar('Error', 'Failed to add note');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add note');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      isLoading.value = true;
      final success = await ApiService.updateNote(note);
      if (success) {
        await loadNotes();
      } else {
        Get.snackbar('Error', 'Failed to update note');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update note');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      isLoading.value = true;
      final success = await ApiService.deleteNote(id);
      if (success) {
        await loadNotes();
      } else {
        Get.snackbar('Error', 'Failed to delete note');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete note');
    } finally {
      isLoading.value = false;
    }
  }
}
