import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prodt_test/screens/home_page.dart';
import 'package:prodt_test/screens/profile.dart';
import 'package:prodt_test/screens/splash.dart';
import 'package:prodt_test/screens/web_viewer.dart';

import '../screens/bookmarked_page.dart';
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
      path: ProfilePage.routeName,
      name: ProfilePage.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePage();
      },
    ),
    GoRoute(
      path: BookMarkedNewsPage.routeName,
      name: BookMarkedNewsPage.routeName,
      builder: (BuildContext context, GoRouterState state) {
        return const BookMarkedNewsPage();
      },
    ),
    GoRoute(
      path: InShortsWebViewer.routeName,
      name: InShortsWebViewer.routeName,
      builder: (BuildContext context, GoRouterState state) {
        String url = state.queryParams["url"] ?? "";
        return InShortsWebViewer(
          url: url,
        );
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
