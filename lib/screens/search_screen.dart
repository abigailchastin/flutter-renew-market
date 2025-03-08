import 'package:flutter/material.dart';
import 'package:flutter_application/datas/mock_post.dart';
import 'package:flutter_application/models/post_model.dart';
import 'package:flutter_application/widgets/post_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<PostModel> _searchResult = [];

  void _performSearch(String search) {
    setState(() {
      _searchResult = mockPosts
          .where((post) => post.title.toLowerCase().contains(search.toLowerCase()))
          .toList();
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Search",
                suffixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onChanged: _performSearch,
            ),
            Expanded(
              child: _searchResult.isEmpty
                  ? Center(child: Text("No result found"))
                  : PostGridView(posts: _searchResult),
            ),
          ],
        ),
      ),
    );
  }
}