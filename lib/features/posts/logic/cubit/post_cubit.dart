import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_app/features/posts/data/models/post_model.dart';
import 'package:flutter_posts_app/features/posts/data/repositories/api_repository.dart';
import 'package:flutter_posts_app/features/posts/logic/cubit/post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository repository;
  int startIndex = 0;
  final int limit = 10;
  List<PostModel> currentPosts = [];
  bool isFetching = false;
  bool isSearching = false;

  PostCubit(this.repository) : super(PostInitial()) {
    loadPost();
  }

  Future<void> loadPost() async {
    if (isFetching || isSearching || currentPosts.length >= 100) return;
    isFetching = true;
    if (currentPosts.isEmpty) {
      emit(PostLoading());
    }

    try {
      Future.delayed(const Duration(milliseconds: 700));
      final results = await repository.fetchPosts(startIndex, limit);

      startIndex += limit;
      currentPosts.addAll(results);
      emit(PostSuccess(List.from(currentPosts)));
    } catch (e) {
      emit(
        currentPosts.isEmpty
            ? PostError("Connection Lost")
            : PostSuccess(List.from(currentPosts)),
      );
    } finally {
      isFetching = false;
    }
  }

  void searchPost(int query) {
    isSearching = true; // LOCK PAGINATION
    final searchResult = currentPosts.where((p) => p.id == query).toList();

    if (searchResult.isNotEmpty) {
      emit(PostSuccess(searchResult));
    } else {
      emit(PostError("Post #$query not found in loaded data"));
    }
  }

  void clearSearch() {
    isSearching = false; // UNLOCK PAGINATION
    emit(PostSuccess(List.from(currentPosts)));
  }
}
