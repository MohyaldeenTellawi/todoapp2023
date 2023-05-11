
class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
 String? repeat;
 Task({
    this.id,this.title,this.note,this.isCompleted,this.date,this.startTime,
   this.endTime,this.color,this.remind,this.repeat
});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

   Task.fromJson(Map<String, dynamic> json) {
      id= json['id'] as int;
      title= json['title'] as String;
      note= json['note'] as String;
      isCompleted= json['isCompleted'] as int;
      date= json['date'] as String;
      startTime= json['startTime'] as String;
      endTime= json['endTime'] as String;
      color= json['color'] as int;
      remind= json['remind'] as int;
      repeat= json['repeat'] as String;
  }
}




