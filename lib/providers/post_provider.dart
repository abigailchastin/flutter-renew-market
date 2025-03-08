import 'package:flutter/material.dart';
import 'package:flutter_application/datas/mock_post.dart';
import 'package:flutter_application/models/post_model.dart';

class PostProvider with ChangeNotifier {
  final List<PostModel> _posts = mockPosts;
  List<PostModel> get posts => _posts;

  void addPost(PostModel post) {
    _posts.add(post);
    notifyListeners();
  }

  void removePost(String postId) {
    _posts.removeWhere((post) => post.postId == postId);
    notifyListeners();
  }
}