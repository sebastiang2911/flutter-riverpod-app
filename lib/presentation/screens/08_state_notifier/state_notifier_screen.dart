import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';
import 'package:riverpod_app/presentation/providers/todo_state_notifier_provider.dart';

class StateNotifierScreen extends StatelessWidget {
  const StateNotifierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Notifier Provider'),
      ),
      body: _TodosView(),
    );
  }
}

class _TodosView extends ConsumerWidget {
  const _TodosView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currenFilter = ref.watch(todoCurrentFilterProvider);
    final todos = ref.watch(filteredGuestProvider);

    return Column(
      children: [
        SegmentedButton(
          segments: const [
            ButtonSegment(value: FilterType.all, icon: Text('Todos')),
            ButtonSegment(value: FilterType.completed, icon: Text('Invitados')),
            ButtonSegment(value: FilterType.all, icon: Text('No invitados')),
          ],
          selected: <FilterType>{currenFilter},
          onSelectionChanged: (value) {
            ref.read(todoCurrentFilterProvider.notifier).state = value.first;
          },
        )
      ],
    );
  }
}
