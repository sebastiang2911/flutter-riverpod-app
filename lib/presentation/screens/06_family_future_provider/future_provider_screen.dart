import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/future_providers.dart';

class FamilyFutureScreen extends ConsumerStatefulWidget {
  const FamilyFutureScreen({super.key});

  @override
  FamilyFutureScreenState createState() => FamilyFutureScreenState();
}

class FamilyFutureScreenState extends ConsumerState<FamilyFutureScreen> {
  int idPokemon = 3;

  @override
  Widget build(BuildContext contex) {
    final pokemonAsync = ref.watch(pokemonProvider(idPokemon));

    return Scaffold(
        appBar: AppBar(
          title: Text('Pokemon id $idPokemon'),
        ),
        body: Center(
          child: pokemonAsync.when(
            data: (name) => Text(name),
            error: (error, stackTrace) => Text('Error'),
            loading: () => CircularProgressIndicator(),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'previousPokemon',
              child: const Icon(Icons.exposure_minus_1),
              onPressed: () {
                setState(() {
                  if (idPokemon > 1) {
                    idPokemon--;
                  }
                });
                // ref.read(pokemonIdProvider.notifier).previosPokemon();
              },
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: 'nextPokemon',
              child: const Icon(Icons.plus_one),
              onPressed: () {
                setState(() => idPokemon++);
                // ref.read(pokemonIdProvider.notifier).getNexIdPokemon();
              },
            ),
          ],
        ));
  }
}
