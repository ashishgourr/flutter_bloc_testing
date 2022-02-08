import 'package:flutter_bloc/flutter_bloc.dart';

import 'task_repository.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this.taskRepository) : super(TaskLoadInitial());

  final TaskRepository taskRepository;

  void getAllTasks() async {
    try {
      emit(TaskLoadInProgress());

      final tasks = await taskRepository.fetchAllTasks();
      emit(TaskLoadSuccess(tasks));
    } catch (_) {
      emit(TaskLoadFailure());
    }
  }

  void getUrgentTasks() async {
    try {
      emit(TaskLoadInProgress());

      final urgentTasks = await taskRepository.fetchUrgentTasks();
      emit(TaskLoadSuccess(urgentTasks));
    } catch (_) {
      emit(TaskLoadFailure());
    }
  }
}
