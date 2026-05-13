import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/features/posts/data/repositories/api_repository.dart';
import 'package:flutter_movies_app/features/posts/logic/cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository repository;

  PostCubit(this.repository) : super(PostInitial()) {
    loadPost();
  }

  Future<void> loadPost([int id = 1]) async {
    emit(PostLoading()); //

    try {
      // Future.wait runs both tasks in parallel.
      // It will only finish when the SLOWEST one is done.
      final results = await Future.wait([
        repository.fetchPost(id), // Task 1: Get data
        Future.delayed(const Duration(milliseconds: 700)),
      ]);
      final post = results[0];
      emit(PostSuccess(post)); //
    } catch (e) {
      emit(PostError("Connection Lost")); //
    }
  }
}
