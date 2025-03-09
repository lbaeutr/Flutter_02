import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(data);

    print('POST request to $url');
    print('Headers: $headers');
    print('Body: $body');

    final response = await http.post(url, headers: headers, body: body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<void> login(String username, String password) async {
    final response = await post('/usuarios/login', {
      'username': username,
      'password': password,
    });

    if (response.containsKey('token')) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response['token']);
    } else {
      throw Exception('Failed to retrieve token');
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String passwordRepeat,
  }) async {
    final response = await post('/usuarios/register', {
      'username': username,
      'email': email,
      'password': password,
      'passwordRepeat': passwordRepeat,
      'rol': 'USER',
      'direccion': {
        'provincia': "Cádiz",
        'municipio': "Cádiz",
        'calle': "acacias",
        'num': 1,
        'cp': 11007,
      },
    });

    return response;
  }

  Future<List<Note>> getNotes(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tareas/mis-tareas'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Note> notes =
          body.map((dynamic item) => Note.fromJson(item)).toList();
      print('Notes: $notes');
      return notes;
    } else {
      // Imprimir el cuerpo de la respuesta para ayudar a depurar
      print('Failed to load notes: ${response.body}');
      throw Exception('Failed to load notes');
    }
  }

  Future<void> addTask(String token, String title, String description) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tareas'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'titulo': title,
        'descripcion': description,
        'estado': false,
      }),
    );

    if (response.statusCode == 201) {
      print('Tarea añadida correctamente');
    } else {
      print('Error al añadir tarea: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to add task');
    }
  }

  Future<void> deleteTask(String token, String taskId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/tareas/$taskId'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('Tarea eliminada correctamente');
    } else {
      print(
        'Error al eliminar tarea: ${response.statusCode} - ${response.body}',
      );
      throw Exception('Failed to delete task');
    }
  }

  Future<void> updateTask(
    String token,
    String taskId,
    String title,
    String description,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tareas/$taskId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'titulo': title, 'descripcion': description}),
    );

    if (response.statusCode == 200) {
      print('Tarea actualizada correctamente');
    } else {
      print(
        'Error al actualizar tarea: ${response.statusCode} - ${response.body}',
      );
      throw Exception('Failed to update task');
    }
  }
}
