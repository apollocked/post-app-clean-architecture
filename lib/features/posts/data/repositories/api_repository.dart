import 'package:dio/dio.dart';
import 'package:flutter_movies_app/features/posts/data/models/post_model.dart';

class PostRepository {
  final Dio _dio;

  PostRepository(this._dio);
  Future<PostModel> fetchPost(int id) async {
    try {
      final response = await _dio.get('/posts/$id');
      return PostModel.fromJson(response.data);
    } catch (e) {
      // FIX 4: Always print the error 'e' during development!
      print("Repository Error: $e");
      throw Exception("Could not load data");
    }
  }
}
