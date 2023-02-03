import 'package:shared_preferences/shared_preferences.dart';

import 'dio_client.dart';

class BookMarkProvider {
  InShortsDioClient client = InShortsDioClient.instance;

  BookMarkProvider._() {
    initialize();
  }

  BookMarkProvider? _instance;

  BookMarkProvider get instance => _instance ??= BookMarkProvider._();

  late SharedPreferences preferences;

  void initialize() async {
    preferences = await SharedPreferences.getInstance();
  }

  void createBookMark()
  {

  }

}
