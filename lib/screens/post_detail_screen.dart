import 'package:flutter/material.dart';
import 'package:flutter_application/constants/app_theme.dart';
import 'package:flutter_application/constants/urls.dart';
import 'package:flutter_application/models/post_model.dart';
import 'package:flutter_application/providers/post_provider.dart';
import 'package:flutter_application/providers/user_provider.dart';
import 'package:flutter_application/widgets/time_ago.dart';
import 'package:provider/provider.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;

  const PostDetailScreen({super.key, required this.post});

  void _showMoreOptions(BuildContext context, PostProvider provider, String postId) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Wrap(
        children: [
          ListTile(
            // leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              // Placeholder for future functionality
            },
          ),
          ListTile(
            // leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              Navigator.pop(context);
              provider.removePost(postId);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Your post has been deleted'))); // Connect to post deletion functionality
            },
          ),
          ListTile(
            // leading: const Icon(Icons.cancel),
            title: const Text('Cancel'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String timeAgoText = timeAgo(post.createdAt);

    return Scaffold(
      appBar: AppBar(
        title: Image.network(logoUrl, height: 40),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              post.images.isNotEmpty ? post.images[0] : defalutImg,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: post.isAvailable ? active : inActive,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                post.isAvailable ? 'For Sale' : 'Sold Out',
                style: badgetText,
              ),
            ),
            const SizedBox(height: 10),
            Text('\$${post.price}', style: priceText2),
            const SizedBox(height: 8),
            Text(timeAgoText, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const Divider(thickness: 1),
            Row(
              children: [
                const Icon(Icons.person_outline, size: 40, color: Colors.grey),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${post.sellerId}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.navigate_next),
                  onPressed: () {
                    Navigator.pushNamed(context, '/sellerProfile', arguments: post.sellerId);
                  },
                ),
              ],
            ),
            const Divider(thickness: 1),
            Text(post.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
      bottomNavigationBar: Consumer2<UserProvider, PostProvider>(
        builder: (context, userProvider, postProvider, child) {
          final currentUser = userProvider.user;
          final isSeller =  currentUser.userId == post.sellerId;
          final isFavorite = currentUser.favorites.contains(post.postId);

          void toggleFavorite(String postId) {
            if (isFavorite) {
              userProvider.removeFavorite(postId);
            } else {
              userProvider.addFavorite(postId);
            }
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(thickness: 1, color: Colors.grey),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (!isSeller) ...[
                      Container(
                        decoration: BoxDecoration(
                          color: isFavorite ? activeOpacity : background,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: isFavorite ? active : inActive,
                          ),
                          onPressed: () {
                            toggleFavorite(post.postId);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Contact Seller',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ] else ...[
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.grey),
                        onPressed: () {
                          _showMoreOptions(context, postProvider, post.postId);
                        },
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Contact Buyer',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          );
        },
     ),
);
}
}