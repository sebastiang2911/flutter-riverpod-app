// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userInChat)
final userInChatProvider = UserInChatProvider._();

final class UserInChatProvider extends $FunctionalProvider<
        AsyncValue<List<String>>, List<String>, Stream<List<String>>>
    with $FutureModifier<List<String>>, $StreamProvider<List<String>> {
  UserInChatProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userInChatProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userInChatHash();

  @$internal
  @override
  $StreamProviderElement<List<String>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<String>> create(Ref ref) {
    return userInChat(ref);
  }
}

String _$userInChatHash() => r'1d2106d97e3b76f08410be852fd36df026933c9a';
