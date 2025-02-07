import 'package:riverpod/riverpod.dart';
import 'package:todotasks/features/tasks/domain/domain.dart';
import 'package:todotasks/features/tasks/providers/tasks_repository_provider.dart';


final tasksProvider = StateNotifierProvider<TasksNotifier, TasksState>((ref) {
  final tasksRepository = ref.watch(TasksRepositoryProvider);

  return TasksNotifier(tasksRepository: tasksRepository);
});



//State Notifier Provider
//Determna cuando carga , deja de cargar
class TasksNotifier extends StateNotifier<TasksState> {
  final TasksRepository tasksRepository;

  TasksNotifier({required this.tasksRepository}) : super(TasksState()) {
    loadTasks();
  }

  Future loadTasks() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);
    //Obtemos todas las tareas
    final tasks = await tasksRepository.getTasks();
    if (tasks.isEmpty) {
      state = state.copyWith(isLoading: false);
      return;
    }
    state = state.copyWith(isLoading: false, tasks: [...state.tasks, ...tasks]);
  }
}

class TasksState {
  final List<Task> tasks;
  final bool isLoading;

  TasksState({this.tasks = const [], this.isLoading = false});

  TasksState copyWith({List<Task>? tasks, bool? isLoading}) => TasksState(
      tasks: tasks ?? this.tasks, isLoading: isLoading ?? this.isLoading);
}
