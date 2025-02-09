import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../models/todo_task.dart';

class TaskDetailScreen extends StatelessWidget {
  final TodoTask? task;

  TaskDetailScreen({this.task});

  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Clave para el formulario

  @override
  Widget build(BuildContext context) {
    if (task != null) {
      _titleController.text = task!.title;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          task == null ? 'Agregar Tarea' : 'Editar Tarea',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 10,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Asignar la clave al formulario
          child: Column(
            children: [
              // Tarjeta para el formulario
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Tarea',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon:
                              Icon(Icons.title, color: Colors.blueAccent),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese la tarea';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final title = _titleController.text;

                            if (task == null) {
                              final newTask = TodoTask(
                                title: title,
                                isCompleted: false,
                                createdAt: DateTime.now(),
                              );
                              Provider.of<TodoProvider>(context, listen: false)
                                  .addTask(newTask);
                            } else {
                              final updatedTask = TodoTask(
                                id: task!.id,
                                title: title,
                                isCompleted: task!.isCompleted,
                                createdAt: task!.createdAt,
                                updatedAt: DateTime.now(),
                              );
                              Provider.of<TodoProvider>(context, listen: false)
                                  .updateTask(updatedTask);
                            }
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          task == null ? 'Agregar Tarea' : 'Editar Tarea',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
