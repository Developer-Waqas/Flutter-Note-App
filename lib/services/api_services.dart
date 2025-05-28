import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note_model.dart';

class ApiService {
  // Updated baseUrl with your Vercel backend URL
  static const String baseUrl =
      'https://flutter-note-app-backend.vercel.app/api';

  static String token = '';

  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  static Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token = data['token'];
      return token;
    } else {
      return null;
    }
  }

  static Future<bool> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 201;
  }

  static Future<List<NoteModel>> fetchNotes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/notes/all'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => NoteModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  static Future<bool> addNote(NoteModel note) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notes/create'),
      headers: headers,
      body: jsonEncode(note.toJson()),
    );
    return response.statusCode == 201;
  }

  static Future<bool> updateNote(NoteModel note) async {
    final response = await http.put(
      Uri.parse('$baseUrl/notes/update/${note.id}'),
      headers: headers,
      body: jsonEncode(note.toJson()),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deleteNote(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/notes/delete/$id'),
      headers: headers,
    );
    return response.statusCode == 200;
  }
}
