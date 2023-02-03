import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prodt_test/providers/prodt_provider.dart';
import 'package:prodt_test/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
        actions: [
          IconButton(
            onPressed: () => Provider.of<ThemeProvider>(context, listen: false)
                .changeTheme(),
            icon: Icon((Theme.of(context).brightness == Brightness.dark)
                ? Icons.light
                : Icons.dark_mode_rounded),
          ),
          Consumer<ProDTProvider>(builder: (context, provider, widget) {
            return DropdownButton(
                borderRadius: BorderRadius.circular(8),
                underline: const SizedBox(),
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
                    provider.setCategory(newData);
                  }
                });
          }),
        ],
      ),
      body: FutureBuilder<InShortsData?>(
          future: Provider.of<ProDTProvider>(context, listen: false).getNews(),
          builder: (context, snapshot) {
            debugPrint(snapshot.toString());
            if (snapshot.hasData) {
              return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.data.length,
                  itemBuilder: (context, index) {
                    Datum news = snapshot.data!.data[index];
                    return GestureDetector(
                      onTap: () async {
                        Uri uri = Uri.parse(news.readMoreUrl ?? "");
                        if (await canLaunchUrl(uri)) {
                          launchUrl(uri);
                        }
                      },
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: news.imageUrl,
                            fit: BoxFit.cover,
                            height: screenSize.height * 0.3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    news.title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Theme.of(context).cardColor),
                                  child: Text(
                                    news.time,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
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
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Text(
                                    "@ ${news.author}",
                                    textAlign: TextAlign.end,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.bookmark_border),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(child: Text("no data"));
            }
          }),
    );
  }
}
