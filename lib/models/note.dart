class Note {
  final int id;
  final String title;
  final String content;
  bool estado;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.estado,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'] != null ? int.parse(json['_id']) : 0,
      title: json['titulo'] ?? '',
      content: json['descripcion'] ?? '',
      estado: json['estado'] ?? false,
    );
  }
}