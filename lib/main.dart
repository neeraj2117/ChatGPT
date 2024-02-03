import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gpt_flutter/screens/login.dart';
import 'providers/active_theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'constants/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTheme = ref.watch(activeThemeProvider);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: activeTheme == Themes.dark ? ThemeMode.dark : ThemeMode.light,
      home: const Login(),
    );
  }
}

