import 'package:flutter_homework_app/subject_model.dart';

class Class {
  late String standard;
  late List<Subject> subjects;
  Class.fromJSON(Map data) {
    this.standard = data["standard"];
    List<Subject> list = [];
    for (var s in data["subjects"]) {
      list.add(Subject.fromJSON(s, data["standard"]));
    }
    this.subjects = list;
  }
}
