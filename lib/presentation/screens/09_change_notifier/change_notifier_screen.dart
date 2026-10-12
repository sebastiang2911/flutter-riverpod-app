import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/todo_change_notifier_provider.dart';

class ChangeNotifierScreen extends ConsumerWidget {
  const ChangeNotifierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(changeNotifierTodosProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('ChangeNotifierProvider')),
      body: Column(
        children: [
          const ListTile(
            title: Text('Mutable state'),
            subtitle: Text('Every action must call notifyListeners().'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.todos.length,
              itemBuilder: (context, index) {
                final todo = controller.todos[index];
                return CheckboxListTile(
                  title: Text(todo.description),
                  value: todo.done,
                  onChanged: (_) => ref
                      .read(changeNotifierTodosProvider)
                      .toggleTodo(todo.id),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(changeNotifierTodosProvider).addTodo(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
