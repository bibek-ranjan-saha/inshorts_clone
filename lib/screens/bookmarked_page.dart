import 'dart:math';

import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:flutter/material.dart';
import 'package:prodt_test/models/category_data.dart';
import 'package:prodt_test/widgets/news_view.dart';
import 'package:provider/provider.dart';

import '../providers/prodt_provider.dart';
import '../services/bookmark_service.dart';
import '../widgets/all_transformers.dart';

class BookMarkedNewsPage extends StatefulWidget {
  static String routeName = "/bookmarked";

  const BookMarkedNewsPage({Key? key}) : super(key: key);

  @override
  State<BookMarkedNewsPage> createState() => _BookMarkedNewsPageState();
}

class _BookMarkedNewsPageState extends State<BookMarkedNewsPage> {
  bool isLoading = false;
  List<Datum> data = [];

  void getData() async {
    setState(() {
      isLoading = true;
    });
    data = await InShortsDBHelper.instance.getAllBookmarks();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarked news"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : data.isEmpty
              ? const Center(
                  child: Text("You have not added bookmark to any news"),
                )
              : Consumer<ProDTProvider>(
                  builder: (context, provider, widget) {
                    return TransformerPageView(
                      scrollDirection: Axis.vertical,
                      itemCount: data.length,
                      loop: false,
                      controller: provider.bookmarkedPageController,
                      transformer: provider.isDefault
                          ? DeepthPageTransformer()
                          : transformers[Random().nextInt(transformers.length)],
                      itemBuilder: (context, index) {
                        return NewsView(
                          news: data[index],
                          screenSize: screenSize,
                          isBookMarked: true,
                          isViewingBookMarks: true,
                          onRemove: () {
                            provider.bookmarkedPageController.next();
                            setState(() {
                              data.removeAt(index);
                            });
                          },
                        );
                      },
                    );
                  },
                ),
    );
  }
}
