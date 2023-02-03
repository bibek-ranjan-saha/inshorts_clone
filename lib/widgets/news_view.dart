import 'dart:math';

import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prodt_test/models/category_data.dart';
import 'package:prodt_test/services/bookmark_service.dart';
import 'package:provider/provider.dart';

import '../providers/prodt_provider.dart';
import '../screens/web_viewer.dart';
import 'all_transformers.dart';

class NewsView extends StatefulWidget {
  final List<Datum> snapshot;
  final Size screenSize;
  final bool isBookMarked;

  const NewsView(
      {Key? key,
      required this.snapshot,
      required this.screenSize,
      this.isBookMarked = false})
      : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    return TransformerPageView(
        scrollDirection: Axis.vertical,
        itemCount: widget.snapshot.length ?? 0,
        loop: false,
        transformer: Provider.of<ProDTProvider>(context, listen: true).isDefault
            ? DeepthPageTransformer()
            : transformers[new Random().nextInt(transformers.length)],
        itemBuilder: (context, index) {
          Datum news = widget.snapshot[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () async {
                  context.pushNamed(InShortsWebViewer.routeName,
                      queryParams: {"url": news.readMoreUrl ?? ""});
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
                        height: widget.screenSize.height * 0.42,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              news.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey),
                            child: Text(
                              news.time,
                              style: Theme.of(context).textTheme.labelMedium,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              "@ ${news.author}",
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          if (!widget.isBookMarked)
                            IconButton(
                              onPressed: () {
                                InShortsDBHelper.instance.createBookMark(news);
                              },
                              icon: const Icon(Icons.bookmark_border),
                            ),
                          if (widget.isBookMarked)
                            IconButton(
                              onPressed: () {
                                InShortsDBHelper.instance
                                    .deleteBookMarkData(index)
                                    .whenComplete(
                                      () => setState(
                                        () {
                                          widget.snapshot.removeAt(index);
                                        },
                                      ),
                                    );
                              },
                              icon: const Icon(Icons.bookmark_remove_rounded),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
