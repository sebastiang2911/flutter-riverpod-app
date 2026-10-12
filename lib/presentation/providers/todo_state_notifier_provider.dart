import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/domain.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

enum StateNotifierTodoFilter { all, completed, pending }

final stateNotifierTodoFilterProvider =
    StateProvider<StateNotifierTodoFilter>((ref) => StateNotifierTodoFilter.all);

final stateNotifierTodosProvider =
    StateNotifierProvider<StateNotifierTodos, List<Todo>>(
  (ref) => StateNotifierTodos(),
);

final filteredStateNotifierTodosProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(stateNotifierTodoFilterProvider);
  final todos = ref.watch(stateNotifierTodosProvider);

  return switch (filter) {
    StateNotifierTodoFilter.all => todos,
    StateNotifierTodoFilter.completed =>
      todos.where((todo) => todo.done).toList(),
    StateNotifierTodoFilter.pending =>
      todos.where((todo) => !todo.done).toList(),
  };
});

class StateNotifierTodos extends StateNotifier<List<Todo>> {
  StateNotifierTodos() : super(_initialTodos());

  void addTodo() {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
    ];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            description: todo.description,
            completedAt: todo.done ? null : DateTime.now(),
          )
        else
          todo,
    ];
  }
}

List<Todo> _initialTodos() => [
      Todo(
        id: _uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: DateTime.now(),
      ),
      Todo(
        id: _uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
    ];
