import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_app/features/posts/data/models/post_model.dart';
import 'package:flutter_posts_app/features/posts/data/repositories/api_repository.dart';
import 'package:flutter_posts_app/features/posts/logic/cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository repository;
  int startIndex = 0;
  int limit = 10;
  List<PostModel> currentPosts = [];
  bool isFetching = false;

  PostCubit(this.repository) : super(PostInitial()) {
    loadPost();
  }

  Future<void> loadPost() async {
    if (isFetching || currentPosts.length >= 100) {
      return; // the number of the posts is 100 in the api
    }
    if (state is PostLoading) return;
    final currenState = state;
    if (currenState is PostSuccess) {
      currentPosts = currenState.posts;
    }
    isFetching = true;
    emit(PostLoading());

    try {
      final results = await Future.wait([
        repository.fetchPosts(startIndex, limit),
        Future.delayed(const Duration(milliseconds: 700)),
      ]);
      startIndex += limit;

      currentPosts.addAll(results[0]);
      emit(PostSuccess(List.from(currentPosts)));
    } catch (e) {
      emit(PostError("Connection Lost"));
    } finally {
      isFetching = false;
    }
  }
}
