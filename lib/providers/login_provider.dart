import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prodt_test/screens/home_page.dart';
import 'package:prodt_test/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/string_constants.dart';

class LoginProvider extends ChangeNotifier {
  GlobalKey<FormState> loginFormKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void loginClick(BuildContext context) async {
    if ((loginFormKey.currentContext?.mounted ?? false) &&
        (loginFormKey.currentState?.validate() ?? false)) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(
          SPConstants.userEmailId, emailController.text);
      sharedPreferences.setString(
          SPConstants.userPassword, passwordController.text);
      sharedPreferences
          .setBool(SPConstants.isLoggedIn, true)
          .then((value) => context.go(HomePage.routeName));
    }
  }

  bool isObscuring = true;

  String? emailValidator(String? mail) {
    if (mail?.isEmpty ?? true) {
      return "can not be empty";
    }
    if (!(mail ?? "").isValidEmail()) {
      return "not a valid email id";
    }
    return null;
  }

  void changeObscure() {
    isObscuring = !isObscuring;
    notifyListeners();
  }

  String? passwordValidator(String? pwd) {
    if (pwd?.isEmpty ?? true) {
      return "can not be empty";
    }
    if (pwd!.length < 5) {
      return "password must be at-least 5 char longer";
    }
    if (!pwd.isValidPassword()) {
      return "password is not valid";
    }
    return null;
  }
}
