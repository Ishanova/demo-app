class DemoModel {
  final int id;
  final String title;
  final String description;
  final DateTime date;

  DemoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory DemoModel.fromJson(Map<String, dynamic> json) {
    return DemoModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }

  static List<DemoModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => DemoModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<DemoModel> demoList) {
    return demoList.map((demo) => demo.toJson()).toList();
  }

  @override
  String toString() {
    return 'DemoModel(id: $id, title: $title, description: $description, date: $date)';
  }
}
