import 'package:flutter/material.dart';
import 'package:flutter_application/datas/mock_post.dart';
import 'package:flutter_application/widgets/post_grid_view.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final posts = mockPosts;

  @override
  Widget build(BuildContext context) {
    return PostGridView(posts: posts);
  }
}



