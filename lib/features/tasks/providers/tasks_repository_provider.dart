import 'package:riverpod/riverpod.dart';
import 'package:todotasks/features/tasks/domain/domain.dart';
import 'package:todotasks/features/tasks/infrastructure/infrastructure.dart';

final TasksRepositoryProvider = Provider<TasksRepository>((ref) {
  final tasksRepository = TasksRepositoryImpl(TasksDatasourceImpl());
  return tasksRepository;
});
