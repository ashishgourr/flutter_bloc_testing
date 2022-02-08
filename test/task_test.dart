import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttr_testing/mock_task_repository.dart';
import 'package:fluttr_testing/task.dart';
import 'package:fluttr_testing/task_cubit.dart';
import 'package:fluttr_testing/task_state.dart';

void main() {
  group('TaskCubit test', () {
    late TaskCubit taskCubit;
    MockTaskRepository mockTaskRepository;

    setUp(() {
      EquatableConfig.stringify = true;
      mockTaskRepository = MockTaskRepository();
      taskCubit = TaskCubit(mockTaskRepository);
    });

    //bloc test for getAllTasks

    blocTest<TaskCubit, TaskState>(
      'emits [TaskLoadInProgress, TaskLoadSuccess] states for successful loaded tasks',
      build: () => taskCubit,
      act: (cubit) => cubit.getAllTasks(),
      expect: () => [
        TaskLoadInProgress(),
        TaskLoadSuccess(mockTasks),
      ],
    );

    //bloc test for getUrgentTasks

    blocTest<TaskCubit, TaskState>(
      'emits [TaskLoadInProgress, TaskLoadSuccess] with urgent tasks',
      build: () => taskCubit,
      act: (cubit) => cubit.getUrgentTasks(),
      expect: () => [
        TaskLoadInProgress(),
        TaskLoadSuccess(const [
          Task(id: '4', title: 'Task 4', isUrgent: true),
          Task(id: '7', title: 'Task 7', isUrgent: true),
          Task(id: '9', title: 'Task 9', isUrgent: true),
          Task(id: '10', title: 'Task 10', isUrgent: true),
        ]),
      ],
    );

    tearDown(() {
      taskCubit.close();
    });
  });
}
