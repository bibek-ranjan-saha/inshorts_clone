import 'package:flutter/material.dart';
import 'package:prodt_test/providers/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static String routeName = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Card(
        margin: const EdgeInsets.all(12),
        child: Consumer<LoginProvider>(builder: (context, provider, widget) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: provider.loginFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: true,
                    autocorrect: true,
                    autofillHints: const [AutofillHints.email],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("E-mail"),
                        hintText: "example@example.com"),
                    validator: provider.emailValidator,
                    controller: provider.emailController,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    obscureText: provider.isObscuring,
                    keyboardType: TextInputType.visiblePassword,
                    autofillHints: const [AutofillHints.password],
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: provider.changeObscure,
                            icon: Icon(provider.isObscuring
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        border: const OutlineInputBorder(),
                        label: const Text("password"),
                        hintText: "#1qw@..."),
                    validator: provider.passwordValidator,
                    controller: provider.passwordController,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => provider.loginClick(context),
                    icon: const Icon(Icons.login),
                    label: const Text("Log in"),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    ));
  }
}
