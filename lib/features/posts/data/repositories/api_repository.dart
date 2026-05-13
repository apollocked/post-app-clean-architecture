import 'package:dio/dio.dart';
import 'package:flutter_movies_app/features/posts/data/models/post_model.dart';

class PostRepository {
  final Dio _dio;

  PostRepository(this._dio);
  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await _dio.get('/posts');

      // FIX: response.data is a List<dynamic>, not a List<PostModel>
      final List<dynamic> data = response.data;

      return data.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception("Could not load data");
    }
  }
}
