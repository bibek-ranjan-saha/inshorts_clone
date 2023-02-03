import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';


class InShortsDioClient {

  static InShortsDioClient? _instance;

  Dio api = Dio();

  InShortsDioClient._() {
    CacheOptions options = CacheOptions(
      // A default store is required for interceptor.
      store: MemCacheStore(),

      // All subsequent fields are optional.

      // Default.
      policy: CachePolicy.request,
      // Returns a cached response on error but for statuses 401 & 403.
      // Also allows to return a cached response on network errors (e.g. offline usage).
      // Defaults to [null].
      hitCacheOnErrorExcept: [401, 403],
      // Overrides any HTTP directive to delete entry past this duration.
      // Useful only when origin server has no cache config or custom behaviour is desired.
      // Defaults to [null].
      maxStale: const Duration(days: 7),
      // Default. Allows 3 cache sets and ease cleanup.
      priority: CachePriority.normal,
      // Default. Body and headers encryption with your own algorithm.
      cipher: null,
      // Default. Key builder to retrieve requests.
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      // Default. Allows to cache POST requests.
      // Overriding [keyBuilder] is strongly recommended when [true].
      allowPostMethod: false,
    );
    api.interceptors.add(DioCacheInterceptor(options: options));
    log("started");
  }

  static InShortsDioClient get instance {
    _instance ??= InShortsDioClient._();
    return _instance!;
  }
}