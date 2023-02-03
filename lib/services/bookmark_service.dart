import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
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

  void createBookMark(Datum data) async {
    var mapData = data.toJson();
    box.add(mapData);
  }

  Future<void> deleteBookMarkData(int index) async {
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
