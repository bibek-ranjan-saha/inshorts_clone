import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prodt_test/screens/home_page.dart';
import 'package:prodt_test/screens/splash.dart';

import '../screens/login.dart';

class InShortsRouter {
  static GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      name: SplashScreen.routeName,
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: LoginPage.routeName,
      name: LoginPage.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: HomePage.routeName,
      name: HomePage.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
  ]);
}
