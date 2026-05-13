import 'package:dio/dio.dart';
import 'package:flutter_posts_app/features/posts/data/models/post_model.dart';

class PostRepository {
  final Dio _dio;

  PostRepository(this._dio);
  Future<List<PostModel>> fetchPosts(int startIndex, int limit) async {
    try {
      final response = await _dio.get(
        '/posts',
        queryParameters: {'_start': startIndex, '_limit': limit},
      );
      final List<dynamic> data = response.data;

      return data.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Could not load more data");
    }
  }
}
