import 'package:dio/dio.dart';
import 'package:todotasks/features/tasks/domain/domain.dart';
import 'package:todotasks/features/tasks/infrastructure/mappers/task_mapper.dart';

class TasksDatasourceImpl extends TasksDatasource {
  late final Dio dio;

  TasksDatasourceImpl()
      : dio = Dio(BaseOptions(
          baseUrl: 'https://localhost:7086/api/TodoTask',
        ));

  @override
  Future<Task> createUpdateTask(Map<String, dynamic> taskLike) {
    // TODO: implement createUpdateTask
    throw UnimplementedError();
  }

  @override
  Future<Task> getTaskById(int id) {
    // TODO: implement getTaskById
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getTasks() async {
    final response = await dio.get<List>('/GetTasks');
    final List<Task> tasks = [];

    for (final task in response.data ?? []) {
      //Mapeo la task segun el formato del response
      tasks.add(TaskMapper.jsonToEntity(task));
    }

    return tasks;
  }
}
