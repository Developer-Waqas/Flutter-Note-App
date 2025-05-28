import 'package:flutter/material.dart';
import 'package:flutter_notes_app/controller/note_controller.dart';
import 'package:get/get.dart';
import '../models/note_model.dart';

class HomeView extends StatelessWidget {
  final notesController = Get.find<NotesController>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    notesController.loadNotes();

    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: Obx(
        () =>
            notesController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                  itemCount: notesController.notes.length,
                  itemBuilder: (context, index) {
                    final note = notesController.notes[index];
                    return ListTile(
                      title: Text(note.title),
                      subtitle: Text(note.content),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed:
                                () => showDialog(
                                  context: context,
                                  builder: (_) => EditNoteDialog(note: note),
                                ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed:
                                () => notesController.deleteNote(note.id!),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed:
            () => showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    title: const Text('Add Note'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(labelText: 'Title'),
                        ),
                        TextField(
                          controller: contentController,
                          decoration: const InputDecoration(
                            labelText: 'Content',
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          notesController.addNote(
                            titleController.text,
                            contentController.text,
                          );
                          titleController.clear();
                          contentController.clear();
                          Get.back();
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
            ),
      ),
    );
  }
}

class EditNoteDialog extends StatelessWidget {
  final NoteModel note;

  EditNoteDialog({required this.note});

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final notesController = Get.find<NotesController>();

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    contentController.text = note.content;

    return AlertDialog(
      title: const Text('Update Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: contentController,
            decoration: const InputDecoration(labelText: 'Content'),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            final updatedNote = NoteModel(
              id: note.id,
              title: titleController.text,
              content: contentController.text,
            );
            notesController.updateNote(updatedNote);
            Get.back();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
