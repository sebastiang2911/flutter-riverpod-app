import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/entities/todo.dart';
import 'package:uuid/uuid.dart';

part 'todos_provider.g.dart';

enum FilterType { all, completed, pending }

const uuid = Uuid();

@Riverpod(keepAlive: true)
class TodoCurrentFilter extends _$TodoCurrentFilter {
  @override
  FilterType build() => FilterType.all;

  void setCurrentFilter(FilterType newFilter) {
    state = newFilter;
  }
}

@Riverpod(keepAlive: true)
class Todos extends _$Todos {
  @override
  List<Todo> build() => [
        Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: DateTime.now()),
        Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: null),
        Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: DateTime.now()),
        Todo(
            id: uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: null),
      ];

  void addNewPerson() {
    state = [
      ...state,
      Todo(
          id: uuid.v4(),
          description: RandomGenerator.getRandomName(),
          completedAt: null),
    ];
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        todo = todo.copyWith(
          completedAt: todo.done ? null : DateTime.now(),
        );
      }

      return todo;
    }).toList();
  }
}

@riverpod
List<Todo> filteredTodos(Ref ref) {
  final currentFilter = ref.watch(todoCurrentFilterProvider);
  final currentTodos = ref.watch(todosProvider);
  switch (currentFilter) {
    case FilterType.all:
      return currentTodos;
    case FilterType.completed:
      return currentTodos.where((todo) => todo.done).toList();
    case FilterType.pending:
      return currentTodos.where((todo) => !todo.done).toList();
  }
}
