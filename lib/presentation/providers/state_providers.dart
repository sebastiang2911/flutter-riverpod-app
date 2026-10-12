import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_providers.g.dart';

@Riverpod(keepAlive: true)
class Counter extends _$Counter {
  //
  @override
  int build() => 5;
  //

  void increaseByOne() {
    // state = state + 1;
    state++;
  }
}

@riverpod
class Theme extends _$Theme {
  @override
  bool build() => false;

  void changeTheme() {
    state = !state;
  }
}

@Riverpod(keepAlive: true)
class UserName extends _$UserName {
  @override
  String build() => 'Sebastian Garcia';

  void changeName(String name) {
    state = name;
  }
}
