import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_homework_app/subject_model.dart';
import 'package:flutter_homework_app/utils.dart';

import 'class_model.dart';

class DataProvider extends ChangeNotifier {
  List<Class> classList = [];

  // HashMap<int, HashSet<int>> selectedSubjects = HashMap();
  HashSet<Subject> selected = HashSet();
  List<Subject> selectedSubs = [];

  DataProvider() {
    getData();
  }

  void getData() {
    Map classData = jsonDecode(data);
    for (var c in classData["classess"]) {
      classList.add(Class.fromJSON(c));
    }
    notifyListeners();
  }

  void selectSubject({required int listIndex, required int itemIndex}) {
    // if (!selectedSubjects.containsKey(listIndex))
    //   selectedSubjects[listIndex] = HashSet<int>();
    // selectedSubjects[listIndex]?.add(itemIndex);

    classList[listIndex].subjects[itemIndex].isSelected = true;
    selected.add(classList[listIndex].subjects[itemIndex]);
    print("select subject= ${classList[listIndex].subjects[itemIndex]}");
    notifyListeners();
  }

  void deselectSubject({required int listIndex, required int itemIndex}) {
    // selectedSubjects[listIndex]?.remove(itemIndex);
    // if (selectedSubjects[listIndex]?.length == 0)
    //   selectedSubjects.remove(listIndex);

    classList[listIndex].subjects[itemIndex].isSelected = false;
    selected.remove(classList[listIndex].subjects[itemIndex]);
    print("deselect subject= ${classList[listIndex].subjects[itemIndex]}");
    notifyListeners();
  }

  void deselectAll() {
    // selectedSubjects.clear();
    selected.forEach((element) {
      element.isSelected = false;
    });
    selected.clear();
    notifyListeners();
  }

  int sortSubs() {
    selectedSubs.clear();
    selected.forEach((element) {
      selectedSubs.add(element);
      print("selected subject= $element");
    });
    selectedSubs.sort();
    return selected.length;
    // int count = 0;
    // selectedSubjects.forEach((key, value) {
    //   value.forEach((element) {
    //     count += 1;
    //   });
    // });
    // return count;
  }
}
