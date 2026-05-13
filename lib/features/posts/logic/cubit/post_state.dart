import 'package:flutter_posts_app/features/posts/data/models/post_model.dart';

sealed class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccess extends PostState {
  final List<PostModel> posts;
  PostSuccess(this.posts);
}

class PostError extends PostState {
  final String message;
  PostError(this.message);
}
