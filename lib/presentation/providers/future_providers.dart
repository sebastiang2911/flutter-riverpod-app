import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_app/config/helpers/pokemon_information.dart';

part 'future_providers.g.dart';

@Riverpod(keepAlive: true)
Future<String> pokemonName(Ref ref) async {
  final idPokemon = ref.watch(pokemonIdProvider);
  final namePokemon = await PokemonInformation.getPokemonName(idPokemon);
  ref.onDispose(() {
    print('estamos a punto de eliminar');
  });
  return namePokemon;
}

@Riverpod(keepAlive: true)
class PokemonId extends _$PokemonId {
  @override
  int build() => 1;

  void getNexIdPokemon() {
    state++;
  }

  void previosPokemon() {
    if (state > 1) {
      state--;
    }
  }
}

// Family providers!!!!

@Riverpod(keepAlive: true)
Future<String> pokemon(Ref ref, int pokemonId) async {
  final pokemonName = await PokemonInformation.getPokemonName(pokemonId);

  return pokemonName;
}
