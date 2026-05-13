import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_app/core/utils/colors.dart';
import 'package:flutter_posts_app/features/posts/logic/cubit/post_cubit.dart';
import 'package:flutter_posts_app/features/posts/logic/cubit/post_state.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});
  static final TextEditingController fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(12),
      child: TextField(
        controller: fieldController,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.isEmpty) {
            context.read<PostCubit>().clearSearch();
          }
        },

        decoration: InputDecoration(
          hintText: 'Search by ID...',
          prefixIcon: BlocBuilder<PostCubit, PostState>(
            builder: (context, state) {
              final isSearching = context.read<PostCubit>().isSearching;
              return isSearching
                  ? IconButton(
                      icon: const Icon(Icons.close, color: tealColor),
                      onPressed: () {
                        fieldController.clear();
                        context.read<PostCubit>().clearSearch();
                      },
                    )
                  : const Icon(Icons.search, color: tealColor);
            },
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () {
                final text = fieldController.text.trim();
                if (text.isNotEmpty) {
                  final id = int.tryParse(text);
                  if (id != null) {
                    context.read<PostCubit>().searchPost(id);
                  }
                } else {
                  context.read<PostCubit>().clearSearch();
                }
              },
              child: const Text(
                'SEARCH',
                style: TextStyle(color: tealColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: goldColor, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: tealColor, width: 2),
          ),
        ),
      ),
    );
  }
}
