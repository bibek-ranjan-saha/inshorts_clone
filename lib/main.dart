import 'package:flutter/material.dart';
import 'package:prodt_test/providers/providers.dart';
import 'package:prodt_test/providers/theme_provider.dart';
import 'package:prodt_test/utils/router.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: InShortsProvider.providers,
      builder: (context, widget) {
        return Consumer<ThemeProvider>(builder: (ctx, provider, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'proDt InShorts Clone',
            themeMode: provider.themeMode,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.blue),
            routerConfig: InShortsRouter.router,
          );
        });
      },
    );
  }
}
