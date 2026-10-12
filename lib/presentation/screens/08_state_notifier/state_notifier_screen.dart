import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/todo_state_notifier_provider.dart';

class StateNotifierScreen extends ConsumerWidget {
  const StateNotifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(stateNotifierTodoFilterProvider);
    final todos = ref.watch(filteredStateNotifierTodosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('StateNotifierProvider')),
      body: Column(
        children: [
          const ListTile(
            title: Text('Immutable state'),
            subtitle: Text('Every action assigns a new List<Todo> to state.'),
          ),
          SegmentedButton<StateNotifierTodoFilter>(
            segments: const [
              ButtonSegment(
                value: StateNotifierTodoFilter.all,
                label: Text('All'),
              ),
              ButtonSegment(
                value: StateNotifierTodoFilter.completed,
                label: Text('Done'),
              ),
              ButtonSegment(
                value: StateNotifierTodoFilter.pending,
                label: Text('Pending'),
              ),
            ],
            selected: {filter},
            onSelectionChanged: (selection) {
              ref.read(stateNotifierTodoFilterProvider.notifier).state =
                  selection.first;
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return CheckboxListTile(
                  title: Text(todo.description),
                  value: todo.done,
                  onChanged: (_) => ref
                      .read(stateNotifierTodosProvider.notifier)
                      .toggleTodo(todo.id),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(stateNotifierTodosProvider.notifier).addTodo(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
