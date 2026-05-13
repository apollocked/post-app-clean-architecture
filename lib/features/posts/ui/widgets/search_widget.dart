import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_app/core/utils/colors.dart';
import 'package:flutter_posts_app/features/posts/logic/cubit/post_cubit.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          context.read<PostCubit>().searchPost(int.parse(value.trim()));
        } else {
          context.read<PostCubit>().loadPost();
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        prefixIconConstraints: BoxConstraints(maxWidth: 40),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.search, color: tealColor),
        ),
        hintText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: goldColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: tealColor, width: 1),
        ),
        filled: true,
      ),
    );
  }
}
