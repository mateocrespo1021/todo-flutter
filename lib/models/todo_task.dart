class TodoTask {
  int? id;
  String title;
  bool isCompleted;
  DateTime createdAt;
  DateTime? updatedAt;

  TodoTask({
    this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
    this.updatedAt,
  });

  //permite crear una instancia de TodoTask a partir de un mapa JSON.

  factory TodoTask.fromJson(Map<String, dynamic> json) {
    return TodoTask(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

//convierte una instancia de TodoTask en un mapa JSON,
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'title': title,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };

    // Solo incluir el ID si no es nulo
    if (id != null) {
      data['id'] = id;
    }

    return data;
  }
}
