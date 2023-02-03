import 'dart:math';

import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prodt_test/providers/prodt_provider.dart';
import 'package:prodt_test/providers/theme_provider.dart';
import 'package:prodt_test/screens/bookmarked_page.dart';
import 'package:prodt_test/screens/profile.dart';
import 'package:prodt_test/screens/web_viewer.dart';
import 'package:provider/provider.dart';

import '../models/categories.dart';
import '../models/category_data.dart';
import '../widgets/all_transformers.dart';

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
                  child: TransformerPageView(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data?.data.length ?? 0,
                      loop: false,
                      transformer:
                          Provider.of<ProDTProvider>(context, listen: true)
                                  .isDefault
                              ? DeepthPageTransformer()
                              : transformers[
                                  new Random().nextInt(transformers.length)],
                      itemBuilder: (context, index) {
                        Datum news = snapshot.data!.data[index];
                        return Card(
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              onTap: () async {
                                context.pushNamed(InShortsWebViewer.routeName,
                                    queryParams: {
                                      "url": news.readMoreUrl ?? ""
                                    });
                                // Uri uri = Uri.parse(news.readMoreUrl ?? "");
                                // if (await canLaunchUrl(uri)) {
                                //   launchUrl(uri,
                                //       mode: LaunchMode.inAppWebView,
                                //       webOnlyWindowName: news.title);
                                // }
                              },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: news.imageUrl,
                                      fit: BoxFit.cover,
                                      height: screenSize.height * 0.42,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            news.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.grey),
                                          child: Text(
                                            news.time,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Text(news.content)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "@ ${news.author}",
                                            textAlign: TextAlign.end,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {

                                          },
                                          icon: const Icon(
                                              Icons.bookmark_border),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return const Center(
                  child: Text("No data present"),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
