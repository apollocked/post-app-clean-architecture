import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_posts_app/features/posts/data/data_sources/cache_service.dart';

class ApiClient {
  late Dio dio;

  Future<void> setup() async {
    final options = await CacheService.getOptions();

    dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
        headers: {'User-Agent': 'Mozilla/5.0', 'Accept': 'application/json'},
      ),
    );

    dio.interceptors.add(DioCacheInterceptor(options: options));
  }
}
