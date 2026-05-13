import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_app/core/utils/colors.dart';
import 'package:flutter_posts_app/features/posts/logic/cubit/post_cubit.dart';
import 'package:flutter_posts_app/features/posts/logic/cubit/post_state.dart';
import 'package:flutter_posts_app/features/posts/ui/widgets/error_widget.dart';
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
    scrollControlerListener();
  }

  void scrollControlerListener() {
    scrollController.addListener(() {
      final cubit = context.read<PostCubit>();
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      if (cubit.isFetching || cubit.state is PostError) return;
      if (maxScroll - currentScroll <= 100.0) {
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
    final posts = context.watch<PostCubit>().currentPosts;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Post Detail",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: tealColor,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(),
            SizedBox(height: 6),
            Text(
              'Enter to Search for the post',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  if (state is PostLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: tealColor),
                    );
                  }
                  if (state is PostSuccess) {
                    return successStateWidget(context, posts, scrollController);
                  } else if (state is PostError) {
                    return errorStateWidget(context, state.message, tealColor);
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
