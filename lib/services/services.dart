import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:prodt_test/providers/prodt_provider.dart';
import 'package:provider/provider.dart';

import '../constants/base_url.dart';
import '../models/category_data.dart';
import 'dio_client.dart';

class InShortsService {
  InShortsDioClient client = InShortsDioClient.instance;

  Future<InShortsData?> getNews(BuildContext context) async {
    ProDTProvider provider = Provider.of<ProDTProvider>(context,listen: false);
    Response response = await client.api
        .get("$baseUrl/news?category=${provider.selectedCategory.name}");
    InShortsData data = InShortsData.fromJson(response.data);
    return data;
  }

}
