import 'package:flutter/material.dart';
import 'package:prodt_test/models/category_data.dart';
import 'package:prodt_test/widgets/news_view.dart';

import '../services/bookmark_service.dart';

class BookMarkedNewsPage extends StatelessWidget {
  static String routeName = "/bookmarked";

  const BookMarkedNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarked news"),
      ),
      body: FutureBuilder<List<Datum>>(
        future: InShortsDBHelper.instance.getAllBookmarks(),
        builder: (context, snapshot) {
          return (snapshot.data?.isEmpty ?? true)
              ? const Center(
                  child: Text("You have not added bookmark to any news"),
                )
              : NewsView(
                  snapshot: snapshot.data ?? [],
                  screenSize: screenSize,
                  isBookMarked: true,
                );
        },
      ),
    );
  }
}
