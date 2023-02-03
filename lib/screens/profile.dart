import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prodt_test/constants/string_constants.dart';
import 'package:prodt_test/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  static String routeName = "/profile";

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My profile"),
      ),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if ((snapshot.connectionState != ConnectionState.waiting) &&
              snapshot.hasData) {
            String email =
                snapshot.data?.getString(SPConstants.userEmailId) ?? "unknown";
            String pwd =
                snapshot.data?.getString(SPConstants.userPassword) ?? "unknown";
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Email : $email",
                      style: Theme.of(context).textTheme.titleLarge),
                  Text("Email : $pwd",
                      style: Theme.of(context).textTheme.titleLarge),
                  ElevatedButton.icon(
                    onPressed: () {
                      snapshot.data?.clear();
                      context.go(LoginPage.routeName);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Log out"),
                  )
                ],
              ),
            );
          } else {
            return const Center(child: Text("something went wrong\nWeird 😥"));
          }
        },
      ),
    );
  }
}
