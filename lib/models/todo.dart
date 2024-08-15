class Todo {
  String title;
  String description;
  bool is_Completed;

  Todo({
    required this.title,
    required this.description,
    required this.is_Completed,
  });

  // Assuming 'id' is not part of the document data, it should be handled separately.
  Todo.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          description: json['description']! as String,
          is_Completed: json['is_Completed']! as bool,
        );

  Todo copyWith({
    String? title,
    String? description,
    bool? is_Completed,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      is_Completed: is_Completed ?? this.is_Completed,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'is_Completed': is_Completed,
    };
  }
}
