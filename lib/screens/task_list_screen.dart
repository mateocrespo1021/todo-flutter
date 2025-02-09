import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todotasks/screens/chart_screen.dart';

import '../providers/todo_provider.dart';
import '../models/todo_task.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    // Llama a fetchTasks al iniciar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      todoProvider.fetchTasks();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 10,
        centerTitle: true,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.tasks.isEmpty) {
            return Center(
              child: Text(
                'No hay tareas disponibles',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: todoProvider.tasks.length,
            itemBuilder: (context, index) {
              TodoTask task = todoProvider.tasks[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading: Icon(
                    task.isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: task.isCompleted ? Colors.green : Colors.orange,
                    size: 30,
                  ),
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text(
                    task.isCompleted ? 'Completada' : 'Pendiente',
                    style: TextStyle(
                      fontSize: 14,
                      color: task.isCompleted ? Colors.green : Colors.orange,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          todoProvider.deleteTask(task.id!);
                        },
                      ),
                      Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          task.isCompleted = value!;
                          todoProvider.updateTask(task);
                        },
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChartScreen(),
                ),
              );
            },
            child: Icon(Icons.bar_chart, color: Colors.white),
            backgroundColor: Colors.blueAccent,
            elevation: 6,
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(),
                ),
              );
            },
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.blueAccent,
            elevation: 6,
          ),
        ],
      ),
    );
  }
}
