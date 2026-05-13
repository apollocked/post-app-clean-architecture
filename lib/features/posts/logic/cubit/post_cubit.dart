import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/features/posts/data/models/post_model.dart';
import 'package:flutter_movies_app/features/posts/data/repositories/api_repository.dart';
import 'package:flutter_movies_app/features/posts/logic/cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository repository;

  PostCubit(this.repository) : super(PostInitial()) {
    loadPost();
  }

  Future<void> loadPost() async {
    emit(PostLoading()); //

    try {
      final results = await Future.wait([
        repository.fetchPosts(), // Task 1: Get data
        Future.delayed(const Duration(milliseconds: 700)),
      ]);
      final post = results[0] as List<PostModel>;
      emit(PostSuccess(post)); //
    } catch (e) {
      emit(PostError("Connection Lost")); //
    }
  }
}
