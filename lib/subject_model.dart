import 'dart:core';

class Subject extends Comparable<Subject> {
  late String subjectName, subjectImageUrl, standard;
  late int std;
  bool isSelected = false;

  Subject.fromJSON(Map data, String standard) {
    this.subjectName = data["subject_name"];
    this.subjectImageUrl = data["subject_image"];
    this.standard = standard;
    this.std = int.parse(standard.substring(0, standard.length - 2));
  }

  @override
  String toString() {
    return subjectName + " " + std.toString();
  }

  @override
  int compareTo(Subject other) {
    return other.std - this.std;
  }
}
