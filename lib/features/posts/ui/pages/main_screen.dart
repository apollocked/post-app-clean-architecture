import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_app/core/utils/colors.dart';
import 'package:flutter_posts_app/features/posts/data/models/post_model.dart';
import 'package:flutter_posts_app/features/posts/logic/cubit/post_cubit.dart';
import 'package:flutter_posts_app/features/posts/logic/cubit/post_state.dart';
import 'package:flutter_posts_app/features/posts/ui/widgets/search_widget.dart';
import 'package:flutter_posts_app/features/posts/ui/widgets/success_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final cubit = context.read<PostCubit>();
      if (cubit.isSearching) return;
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        cubit.loadPost();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<PostModel> postsToShow;
    return Scaffold(
      appBar: AppBar(title: const Text("Posts"), backgroundColor: tealColor),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            const SearchWidget(),
            const SizedBox(height: 6),
            Expanded(
              child: BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  final cubit = context.read<PostCubit>();
                  if (state is PostLoading && cubit.currentPosts.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(color: tealColor),
                    );
                  }
                  if (state is PostSuccess ||
                      (state is PostLoading && cubit.currentPosts.isNotEmpty)) {
                    postsToShow = (state is PostSuccess)
                        ? state.posts
                        : cubit.currentPosts;
                    return successStateWidget(
                      context,
                      postsToShow,
                      scrollController,
                    );
                  }
                  if (state is PostError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
