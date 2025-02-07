import 'package:todotasks/features/tasks/domain/entities/task.dart';

abstract class TasksDatasource {
  //Obtiene todas las tareas
  Future<List<Task>> getTasks();

  Future<Task> getTaskById(int id);

  Future<Task> createUpdateTask(Map<String, dynamic> taskLike);
}
