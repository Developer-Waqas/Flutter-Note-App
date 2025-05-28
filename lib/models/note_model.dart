class NoteModel {
  String? id;
  String title;
  String content;

  NoteModel({this.id, required this.title, required this.content});

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    id: json['_id'],
    title: json['title'],
    content: json['content'],
  );

  Map<String, dynamic> toJson() => {'title': title, 'content': content};
}
