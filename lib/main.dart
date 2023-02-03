import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prodt_test/providers/providers.dart';
import 'package:prodt_test/providers/theme_provider.dart';
import 'package:prodt_test/utils/router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await Hive.initFlutter('InShortsClone');
  } else {
    await Hive.initFlutter();
  }
  await openHiveBox(
    'cache',
  );
  runApp(const MyApp());
}

Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final String dirPath = dir.path;
    File dbFile = File('$dirPath/$boxName.hive');
    File lockFile = File('$dirPath/$boxName.lock');
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      dbFile = File('$dirPath/InShortsClone/$boxName.hive');
      lockFile = File('$dirPath/InShortsClone/$boxName.lock');
    }
    await dbFile.delete();
    await lockFile.delete();
    await Hive.openBox(boxName);
    throw 'Failed to open $boxName Box\nError: $error';
  });
  // clear box if it grows large
  if (limit && box.length > 1000) {
    box.clear();
  }
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
              useMaterial3: true,
              primarySwatch: Colors.blue,
            ),
            darkTheme: ThemeData.dark(useMaterial3: true)
                .copyWith(primaryColor: Colors.blue),
            routerConfig: InShortsRouter.router,
          );
        });
      },
    );
  }
}
