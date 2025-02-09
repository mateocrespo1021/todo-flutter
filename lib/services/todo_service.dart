import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_task.dart';

class TodoService {
  final String baseUrl =
      "http://localhost:5156/api/TodoTask"; 

  Future<List<TodoTask>> getTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/GetTasks'));

    if (response.statusCode == 200) {
      // Decodifica la respuesta JSON
      final Map<String, dynamic> responseBody = json.decode(response.body);

      // Verifica si la respuesta tiene la propiedad 'data'
      if (responseBody.containsKey('data')) {
        List<dynamic> data = responseBody['data'];
        return data.map((task) => TodoTask.fromJson(task)).toList();
      } else {
        throw Exception('La respuesta no contiene la propiedad "data"');
      }
    } else {
      throw Exception('Failed to load tasks');
    }
  }

Future<TodoTask> addTask(TodoTask task) async {
   
    final response = await http.post(
      Uri.parse('$baseUrl/PostTask'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

   
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
     
      return TodoTask.fromJson(responseBody['data']);
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<TodoTask> updateTask(TodoTask task) async {
    final response = await http.put(
      Uri.parse('$baseUrl/PutTask'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode == 200) {
      return TodoTask.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/DeleteTask/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
