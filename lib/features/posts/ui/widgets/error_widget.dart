import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movies_app/features/posts/logic/cubit/post_cubit.dart';

Widget errorStateWidget(BuildContext context, String message, Color color) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.wifi_off_rounded, size: 64, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(
          message,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () => context.read<PostCubit>().loadPost(1),
          icon: const Icon(Icons.replay_rounded),
          label: const Text("Try Again"),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    ),
  );
}
