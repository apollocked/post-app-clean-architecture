import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_app/features/posts/data/data_sources/api_clint.dart';
import 'package:flutter_posts_app/features/posts/data/repositories/api_repository.dart';
import 'package:flutter_posts_app/features/posts/logic/cubit/post_cubit.dart';
import 'package:flutter_posts_app/features/posts/ui/pages/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiClient = ApiClient();
  await apiClient.setup();

  runApp(
    BlocProvider(
      create: (context) => PostCubit(PostRepository(apiClient.dio)),
      child: const MyCacheInterceptorApp(),
    ),
  );
}

class MyCacheInterceptorApp extends StatelessWidget {
  const MyCacheInterceptorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
