import 'package:flutter/material.dart';
import 'package:riverpod_app/config/config.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/presentation/providers/providers.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    final themeState = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Riverpod Providers',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme(isDarkMode: themeState).getTheme(),
    );
  }
}
