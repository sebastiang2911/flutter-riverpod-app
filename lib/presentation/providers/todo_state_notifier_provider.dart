import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/domain.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final filteredGuestProvider = Provider<List<Todo>>((ref) {
  final selectedFilter = ref.watch(todoCurrentFilterProvider);
  final todos = ref.watch(todosStateNotifierProvider);

  switch (selectedFilter) {
    case FilterType.all:
      return todos;
    case FilterType.completed:
      return todos.where((todo) => todo.done).toList();
    case FilterType.pending:
      return todos.where((todo) => !todo.done).toList();
  }
});

final todosStateNotifierProvider =
    NotifierProvider<TodosNotifier, List<Todo>>(TodosNotifier.new);

class TodosNotifier extends Notifier<List<Todo>> {
  @override
  List<Todo> build() => [
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
        Todo(
          id: _uuid.v4(),
          description: RandomGenerator.getRandomName(),
          completedAt: null,
        ),
        Todo(
          id: _uuid.v4(),
          description: RandomGenerator.getRandomName(),
          completedAt: DateTime.now(),
        ),
      ];

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
    state = state.map((todo) {
      if (todo.id != id) return todo;
      if (todo.done) return todo.copyWith(completedAt: null);
      return todo.copyWith(completedAt: DateTime.now());
    }).toList();
  }
}
