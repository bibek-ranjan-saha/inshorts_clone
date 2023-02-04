import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:prodt_test/constants/base_url.dart';

class InShortsDioClient {
  static InShortsDioClient? _instance;

  Dio api = Dio();

  InShortsDioClient._() {
    api.interceptors.add(DioCacheManager(
      CacheConfig(
        baseUrl: baseUrl,
        defaultMaxAge: const Duration(days: 7),
        defaultMaxStale: const Duration(days: 10),
      ),
    ).interceptor);
  }

  static InShortsDioClient get instance {
    _instance ??= InShortsDioClient._();
    return _instance!;
  }
}
