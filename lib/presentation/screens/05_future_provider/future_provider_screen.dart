import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/future_providers.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonName = ref.watch(pokemonNameProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Provider'),
      ),
      body: Center(
        child: pokemonName.when(
          data: (data) => Text(data.toUpperCase()),
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => const Text('Lo sentimos no existe'),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'previousPokemon',
            child: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(pokemonIdProvider.notifier).previosPokemon();
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'nextPokemon',
            child: const Icon(Icons.plus_one),
            onPressed: () {
              ref.read(pokemonIdProvider.notifier).getNexIdPokemon();
            },
          ),
        ],
      ),
    );
  }
}
