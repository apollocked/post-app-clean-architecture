import 'dart:io';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart'; // Ensure this is imported
import 'package:path_provider/path_provider.dart';

class CacheService {
  static CacheOptions? _cacheOptions;

  static Future<CacheOptions> getOptions() async {
    if (_cacheOptions != null) return _cacheOptions!;

    final Directory dir = await getApplicationDocumentsDirectory();
    final path = Directory('${dir.path}/my_app_cache');

    if (!await path.exists()) {
      await path.create(recursive: true);
    }

    final store = HiveCacheStore(path.path);

    _cacheOptions = CacheOptions(
      store: store,
      policy: CachePolicy.refreshForceCache,
      // hitCacheOnErrorExcept is removed.
      // refreshForceCache automatically tries network first,
      // then falls back to cache if the network fails.
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal, // Optional: define priority
    );

    return _cacheOptions!;
  }
}
