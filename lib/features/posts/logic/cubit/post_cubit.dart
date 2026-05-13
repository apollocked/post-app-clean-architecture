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
  bool isFirstLoad = true; // Track the very first startup

  PostCubit(this.repository) : super(PostInitial()) {
    loadPost();
  }

  Future<void> loadPost() async {
    if (isFetching || currentPosts.length >= 100) return;

    isFetching = true;
    if (isFirstLoad) {
      emit(PostLoading());
    }

    try {
      final results = await Future.wait([
        repository.fetchPosts(startIndex, limit),
        Future.delayed(const Duration(milliseconds: 700)),
      ]);
      final List<PostModel> newPosts = results[0];
      startIndex += limit;
      currentPosts.addAll(newPosts);
      isFirstLoad = false;
      emit(PostSuccess(List.from(currentPosts)));
    } catch (e) {
      if (currentPosts.isEmpty) {
        emit(PostError("Connection Lost"));
      } else {
        emit(PostSuccess(List.from(currentPosts)));
      }
    } finally {
      isFetching = false;
    }
  }

  Future<void> searchPost(int query) async {
    emit(PostLoading());
    if (query > 0 && query < currentPosts.length) {
      currentPosts = currentPosts
          .where((element) => element.id == query)
          .toList();
      emit(PostSuccess(List.from(currentPosts)));
    } else {
      emit(PostError("Post not found"));
    }
  }
}
