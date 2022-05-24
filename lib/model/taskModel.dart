class Task {
  int? id;

  late String title;

  late String note;

  late int isCompleted;

  late String date;

  Task({
    this.id,
    required this.title,
    required this.note,
    required this.isCompleted,
    required this.date,
  });
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['isCompleted'] = isCompleted;
    data['date'] = date;
    return data;
  }
}
