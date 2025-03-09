class Note {
  final int id;
  final String title;
  final String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'] != null ? int.parse(json['_id']) : 0, // maneja el caso de null
      title: json['titulo'] ?? '', // maneja el caso de null
      content: json['descripcion'] ?? '', // Manejar el caso de null
    );
  }

  
}