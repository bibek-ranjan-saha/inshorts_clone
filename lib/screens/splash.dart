import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prodt_test/constants/string_constants.dart';
import 'package:prodt_test/providers/prodt_provider.dart';
import 'package:prodt_test/screens/home_page.dart';
import 'package:prodt_test/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/categories.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    doWork();
    super.initState();
  }

  void doWork() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLoggedIn = sp.getBool(SPConstants.isLoggedIn) ?? false;
    if (context.mounted) {
      if (isLoggedIn) {
        Provider.of<ProDTProvider>(context, listen: false)
            .setCategory(ProDtCategories.national, context);
        context.go(HomePage.routeName);
      } else {
        context.go(LoginPage.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AImages.logo),
      ),
    );
  }
}
