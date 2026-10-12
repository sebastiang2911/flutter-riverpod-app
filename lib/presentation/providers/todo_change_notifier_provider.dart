import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/domain/domain.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final changeNotifierTodosProvider = ChangeNotifierProvider<ChangeNotifierTodos>(
  (ref) => ChangeNotifierTodos(),
);

class ChangeNotifierTodos extends ChangeNotifier {
  final List<Todo> _todos = [
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

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  void addTodo() {
    _todos.add(
      Todo(
        id: _uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
    );
    notifyListeners();
  }

  void toggleTodo(String id) {
    final newTodos = _todos.map((todo) {
      if (todo.id == id) {
        todo = todo.copyWith(
          completedAt: todo.done ? null : DateTime.now(),
        );
      }
      return todo;
    }).toList();

    _todos
      ..clear()
      ..addAll(newTodos);

    notifyListeners();
  }
}
