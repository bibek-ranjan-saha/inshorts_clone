import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../constants/base_url.dart';
import '../models/categories.dart';
import '../models/category_data.dart';
import '../services/dio_client.dart';

class ProDTProvider extends ChangeNotifier {
  ProDtCategories _selectedCategory = ProDtCategories.national;

  void setCategory(ProDtCategories category) {
    _selectedCategory = category;
    notifyListeners();
  }

  ProDtCategories get selectedCategory => _selectedCategory;

  InShortsDioClient client = InShortsDioClient.instance;

  Future<InShortsData?> getNews() async {
    Response response = await client.api
        .get("$baseUrl/news?category=${_selectedCategory.name}");
    InShortsData data = InShortsData.fromJson(response.data);
    return data;
  }
}
