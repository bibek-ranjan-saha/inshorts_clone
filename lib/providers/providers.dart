import 'package:prodt_test/models/categories.dart';
import 'package:prodt_test/providers/login_provider.dart';
import 'package:prodt_test/providers/prodt_provider.dart';
import 'package:prodt_test/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class InShortsProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (context) => ThemeProvider()..initialize(),
    ),
    ChangeNotifierProvider(
      create: (context) => LoginProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProDTProvider(),
    ),
  ];
}