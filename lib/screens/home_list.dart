import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../models/note.dart';
import '../service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeList extends StatefulWidget {
  const HomeList({super.key});

  @override
  HomeListState createState() => HomeListState();
}

class HomeListState extends State<HomeList> {
  final List<Note> notes = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  int _idCounter = 0;
  final ApiService apiService = ApiService(baseUrl: 'https://api-rest-segura-2.onrender.com');

  @override
  void initState() {
    super.initState();
    _fetchNotes();
  }

  Future<void> _fetchNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        List<Note> fetchedNotes = await apiService.getNotes(token);
        print('Fetched notes: $fetchedNotes');
        setState(() {
          notes.clear(); // Limpiar la lista existente
          notes.addAll(fetchedNotes); // Añadir las notas obtenidas
        });
      } else {
        throw Exception('Token no encontrado');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al obtener notas: $e")),
      );
    }
  }

  Future<void> _addTask() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        await apiService.addTask(token, titleController.text, contentController.text);
        _fetchNotes(); // Refrescar la lista de notas después de añadir una nueva tarea
      } else {
        throw Exception('Token no encontrado');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al añadir tarea: $e")),
      );
    }
  }

  Future<void> _updateTask(int index, {String? title, String? description, bool? estado}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        await apiService.updateTask(
          token,
          notes[index].id.toString(),
          title ?? notes[index].title,
          description ?? notes[index].content,
          estado ?? notes[index].estado,
        );
        _fetchNotes(); // Refrescar la lista de notas después de actualizar una tarea
      } else {
        throw Exception('Token no encontrado');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al actualizar tarea: $e")),
      );
    }
  }

  Future<void> _deleteTask(int index) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token != null) {
        await apiService.deleteTask(token, notes[index].id.toString());
        setState(() {
          notes.removeAt(index);
        });
      } else {
        throw Exception('Token no encontrado');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al eliminar tarea: $e")),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  // Método para agregar o editar una nota
  void addOrEditNote({int? index}) {
    // Si se está editando una nota, se llenan los controladores con los datos existentes
    titleController.text = index != null ? notes[index].title : '';
    contentController.text = index != null ? notes[index].content : '';
    String? errorMessage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Mostrar mensaje de error si hay campos vacíos
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  // Campo de texto para el título
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "Título"),
                  ),
                  // Campo de texto para el contenido
                  TextField(
                    controller: contentController,
                    decoration: const InputDecoration(labelText: "Contenido"),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  // Botón para guardar o actualizar la nota
                  ElevatedButton(
                    onPressed: () {
                      // Validar que los campos no estén vacíos
                      if (titleController.text.isEmpty ||
                          contentController.text.isEmpty) {
                        setModalState(
                          () => errorMessage = "Completa todos los campos",
                        );
                        return;
                      }

                      if (index != null) {
                        // Actualizar nota existente
                        _updateTask(index, title: titleController.text, description: contentController.text);
                      } else {
                        // Agregar nueva nota
                        _addTask();
                      }

                      Navigator.pop(context);
                    },
                    child: Text(
                      index != null ? "Actualizar Nota" : "Guardar Nota",
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Método para eliminar una nota
  void deleteNote(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Eliminar Nota"),
            content: const Text("¿Seguro que deseas eliminar esta nota?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  _deleteTask(index);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Eliminar",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  // Método para cerrar sesión
  void logout() => Navigator.pushReplacementNamed(context, '/');

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tareas"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: logout,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Fondo de pantalla
          Positioned.fill(
            child: Image.asset(
              isDarkMode
                  ? 'lib/assets/darkbackground.png'
                  : 'lib/assets/lightbackground.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Expanded(
                child:
                    notes.isEmpty
                        ? const Center(
                          child: Text(
                            "No hay notas aún",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        )
                        : ListView.builder(
                          itemCount: notes.length,
                          itemBuilder:
                              (context, index) => Card(
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: ListTile(
                                  leading: Checkbox(
                                    value: notes[index].estado,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        notes[index].estado = value!;
                                      });
                                      _updateTask(index, estado: value);
                                    },
                                  ),
                                  title: Text(
                                    notes[index].title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(notes[index].content),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Botón para editar la nota
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        onPressed:
                                            () => addOrEditNote(index: index),
                                      ),
                                      // Botón para eliminar la nota
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => deleteNote(index),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addOrEditNote(),
        child: const Icon(Icons.add),
      ),
    );
  }
}