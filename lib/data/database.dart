import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Test", false],
    ];
  }

  // load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}

class EventsBase {
  List events = [];

  // reference our box
  final _eventBox = Hive.box('events');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    events = [
      ["Test", false],
    ];
  }

  // load the data from database
  void loadData() {
    events = _eventBox.get("Events");
  }

  // update the database
  void updateDataBase() {
    _eventBox.put("Events", events);
  }
}
