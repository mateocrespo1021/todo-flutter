import 'package:flutter/material.dart';
import '../models/todo_task.dart';
import '../services/todo_service.dart';



// define un TodoProvider  que actúa como un proveedor de estado para gestionar una lista de tareas
class TodoProvider with ChangeNotifier {
  List<TodoTask> _tasks = [];
  final TodoService _todoService = TodoService();

  List<TodoTask> get tasks => _tasks;

  Future<void> fetchTasks() async {
    try {
      _tasks = await _todoService.getTasks();
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addTask(TodoTask task) async {
    await _todoService.addTask(task);
    await fetchTasks();
  }

  Future<void> updateTask(TodoTask task) async {
    await _todoService.updateTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(int id) async {
    await _todoService.deleteTask(id);
    await fetchTasks();
  }
}
