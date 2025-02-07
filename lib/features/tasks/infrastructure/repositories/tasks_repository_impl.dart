import 'package:todotasks/features/tasks/domain/domain.dart';

class TasksRepositoryImpl extends TasksRepository {
  final TasksDatasource datasource;

  TasksRepositoryImpl(this.datasource);

  @override
  Future<Task> createUpdateTask(Map<String, dynamic> taskLike) {
    return datasource.createUpdateTask(taskLike);
  }

  @override
  Future<Task> getTaskById(int id) {
    return datasource.getTaskById(id);
  }

  @override
  Future<List<Task>> getTasks() {
    return datasource.getTasks();
  }
}
