class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  int? color;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.color,
  });
  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    color = json['color'];
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'note': note,
        'isCompleted': isCompleted,
        'date': date,
        'color': color,
      };
}
