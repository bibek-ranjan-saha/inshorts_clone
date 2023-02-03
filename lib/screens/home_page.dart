import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prodt_test/constants/string_constants.dart';
import 'package:prodt_test/providers/prodt_provider.dart';
import 'package:prodt_test/providers/theme_provider.dart';
import 'package:prodt_test/screens/bookmarked_page.dart';
import 'package:prodt_test/screens/profile.dart';
import 'package:prodt_test/widgets/news_view.dart';
import 'package:provider/provider.dart';

import '../models/categories.dart';
import '../models/category_data.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Consumer<ProDTProvider>(builder: (context, provider, widget) {
          return DropdownButton(
              borderRadius: BorderRadius.circular(8),
              underline: const SizedBox(),
              icon: const SizedBox(),
              value: provider.selectedCategory,
              items: ProDtCategories.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (ProDtCategories? newData) {
                if (newData != null) {
                  provider.setCategory(newData, context);
                }
              });
        }),
        actions: [
          IconButton(
            onPressed: () => Provider.of<ThemeProvider>(context, listen: false)
                .changeTheme(),
            icon: Icon((Theme.of(context).brightness == Brightness.dark)
                ? Icons.light
                : Icons.dark_mode_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.25,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Image.asset(
                        AImages.logo,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "ProDT assignment by\nBIBEK RANJAN SAHA",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                context.pop();
                context.pushNamed(ProfilePage.routeName);
              },
              title: const Text("My profile"),
              leading: const Icon(Icons.account_box),
            ),
            ListTile(
              onTap: () {
                context.pop();
                context.pushNamed(BookMarkedNewsPage.routeName);
              },
              title: const Text("My bookmarks"),
              leading: const Icon(Icons.book),
            ),
            Consumer<ProDTProvider>(builder: (context, provider, widget) {
              return SwitchListTile(
                title: const Text("Default scrolling behaviour"),
                value: provider.isDefault,
                onChanged: (bool value) {
                  provider.setIsDefault(value);
                },
              );
            }),
            Consumer<ThemeProvider>(builder: (context, provider, widget) {
              return provider.themeMode == ThemeMode.system
                  ? const SizedBox()
                  : SwitchListTile(
                      title: const Text("is Dark Mode"),
                      value: (Theme.of(context).brightness == Brightness.dark),
                      onChanged: (bool value) {
                        provider.changeTheme();
                      },
                    );
            }),
            Consumer<ThemeProvider>(builder: (context, provider, widget) {
              return SwitchListTile(
                title: const Text("change to auto"),
                value: provider.themeMode == ThemeMode.system,
                onChanged: (bool value) {
                  if (value) {
                    provider.makeItAuto();
                  } else {
                    provider.makeItNotAuto();
                  }
                },
              );
            }),
          ],
        ),
      ),
      body: FutureBuilder<InShortsData?>(
        future: Provider.of<ProDTProvider>(context, listen: true).future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () async {
                  Provider.of<ProDTProvider>(context, listen: false)
                      .setCategory(null, context);
                },
                child: NewsView(
                  screenSize: screenSize,
                  snapshot: snapshot.data?.data ?? [],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No data present\nSorry 🥲",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<ProDTProvider>(context, listen: false)
                            .setCategory(null, context);
                      },
                      icon: const Icon(Icons.refresh_rounded),
                    )
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "loading data hang on...",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
