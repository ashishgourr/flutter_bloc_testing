import 'task.dart';

abstract class TaskRepository {
  Future<List<Task>> fetchAllTasks();

  Future<List<Task>> fetchUrgentTasks();
}
