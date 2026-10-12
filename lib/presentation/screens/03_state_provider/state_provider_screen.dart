import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/config.dart';
import 'package:riverpod_app/presentation/providers/state_providers.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterProvider);
    final bool themeState = ref.watch(themeProvider);
    final String nameState = ref.watch(userNameProvider);

    final newName = RandomGenerator.getRandomName();

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Provider'),
      ),
      body: Center(
          child: Column(
        children: [
          const Spacer(flex: 1),
          IconButton(
            icon: Icon(
                themeState
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
                size: 100),
            onPressed: () {
              ref.read(themeProvider.notifier).changeTheme();
            },
          ),
          Text(nameState, style: TextStyle(fontSize: 25)),
          TextButton.icon(
            icon: const Icon(
              Icons.add,
              size: 50,
            ),
            label: Text('$counterState', style: TextStyle(fontSize: 100)),
            onPressed: () {
              ref.read(counterProvider.notifier).increaseByOne();
            },
          ),
          const Spacer(flex: 2),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nombre aleatorio'),
        icon: const Icon(Icons.refresh_rounded),
        onPressed: () =>
            ref.read(userNameProvider.notifier).changeName(newName),
      ),
    );
  }
}
