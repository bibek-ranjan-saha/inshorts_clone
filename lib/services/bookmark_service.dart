import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:prodt_test/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category_data.dart';

class InShortsDBHelper {
  late Box box;

  InShortsDBHelper._() {
    initialize();
  }

  static InShortsDBHelper? _instance;

  static InShortsDBHelper get instance => _instance ??= InShortsDBHelper._();

  late SharedPreferences preferences;

  void initialize() {
    // preferences = await SharedPreferences.getInstance();
    box = Hive.box('cache');
  }

  void createBookMark(Datum newNews, BuildContext context) async {
    bool alreadyExists = false;
    List<Datum> data = await getAllBookmarks();
    for (Datum news in data) {
      if (news.id == newNews.id) {
        alreadyExists = true;
      }
    }
    if (alreadyExists) {
      if (context.mounted) {
        showSnackBar(
            context: context,
            text:
                "News is already bookmarked view it by going to my bookmarks");
      }
    } else {
      var mapData = newNews.toJson();
      box.add(mapData);
      if (context.mounted) {
        showSnackBar(
            context: context,
            text: "${newNews.title} has been bookmarked "
                "will be available offline");
      }
    }
  }

  Future<void> deleteBookMarkData(String newsId) async {
    int index = 0;
    List<Datum> data = await getAllBookmarks();
    for (int i = 0; i < data.length; i++) {
      if (data[i].id == newsId) {
        index = i;
      }
    }
    await box.deleteAt(index);
  }

  Future<List<Datum>> getAllBookmarks() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<Datum> data = [];
      box.toMap().values.forEach((element) {
        data.add(Datum.fromJson(jsonDecode(jsonEncode(element))));
      });
      return data;
    }
  }

  Future<void> cleanData() async {
    await box.clear();
  }
}
