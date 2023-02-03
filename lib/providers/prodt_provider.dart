import 'package:flutter/material.dart';

import '../models/categories.dart';
import '../models/category_data.dart';
import '../services/services.dart';

class ProDTProvider extends ChangeNotifier {
  ProDtCategories _selectedCategory = ProDtCategories.national;

  InShortsService service = InShortsService();

  bool _isDefault = false;
  bool get isDefault => _isDefault;

  void setIsDefault(bool newIsDefault)
  {
    _isDefault = newIsDefault;
    notifyListeners();
  }

  void setCategory(ProDtCategories? category, BuildContext context) {
    if (category != null) {
      _selectedCategory = category;
    }
    future = service.getNews(context);
    notifyListeners();
  }

  Future<InShortsData?>? future;

  ProDtCategories get selectedCategory => _selectedCategory;
}
