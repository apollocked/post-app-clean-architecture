import 'package:flutter/material.dart';

import 'package:flutter_posts_app/core/utils/colors.dart';
import 'package:flutter_posts_app/features/posts/data/models/post_model.dart';

Widget successStateWidget(
  BuildContext context,
  List<PostModel> posts,
  ScrollController scrollController,
) {
  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          controller: scrollController,
          itemCount: posts.length + 1,
          itemBuilder: (context, index) {
            if (posts.length <= index) {
              return Padding(
                padding: const EdgeInsets.all(32.0),
                child: const Center(
                  child: CircularProgressIndicator(color: tealColor),
                ),
              );
            } else {
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: goldColor, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.article_rounded, color: tealColor),
                          const SizedBox(width: 12),
                          Text(
                            "ID: ${posts[index].id}",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      Text(
                        posts[index].title.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Color(0xFF263238),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        posts[index].body,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),

      const SizedBox(height: 10),
      Text(
        "Data provided by local cache fallback",
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    ],
  );
}
