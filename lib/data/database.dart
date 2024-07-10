import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [
      ["Win the competition", false],

    ];
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}

class NotesDatabase {
  List notesList = [];

  final _myBox = Hive.box('mybox');

  void createInitialData() {
    notesList = [
      {"title": "Meeting Notes", "content": "Discuss project milestones"},

    ];
  }

  void loadData() {
    notesList = _myBox.get("NOTESLIST");
  }

  void updateDataBase() {
    _myBox.put("NOTESLIST", notesList);
  }
}



