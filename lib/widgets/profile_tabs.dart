import 'package:flutter/material.dart';
import 'package:flutter_application/datas/mock_post.dart';
import 'package:flutter_application/widgets/post_grid_view.dart';


class MySalesTab extends StatelessWidget {
  
   MySalesTab({super.key});
  final filteredPosts = mockPosts.where((post) => post.sellerId == mockUser.userId).toList();

  @override
  Widget build(BuildContext context) {
    return  PostGridView(posts: filteredPosts);
  }
}

class ReviewsTab extends StatelessWidget {
  ReviewsTab({super.key});
   final filteredPosts = mockPosts.where((post) => mockUser.favorites.contains(post.postId) ).toList();

  @override
  Widget build(BuildContext context) {
    return  PostGridView(posts: filteredPosts);
  }
}

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Favorites'),
    );
  }
}