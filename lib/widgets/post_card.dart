import 'package:flutter/material.dart';
import 'package:flutter_application/constants/app_theme.dart';
import 'package:flutter_application/models/post_model.dart';
import 'package:flutter_application/screens/post_detail_screen.dart';
import 'package:flutter_application/widgets/time_ago.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    String timeAgoText = timeAgo(post.createdAt);
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailScreen(post: post)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Sudut melengkung kartu
        ),
        elevation: 3, // Bayangan pada kartu
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gunakan Stack untuk overlay badge
            Stack(
              children: [
                // Gambar utama
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4), // Sudut kiri atas melengkung
                    topRight: Radius.circular(4), // Sudut kanan atas melengkung
                  ),
                  child: Image.network(
                    post.images[0], // URL gambar
                    // height: 150, // Tinggi gambar
                    // width: double.infinity, // Lebar gambar sesuai lebar kontainer
                    // fit: BoxFit.cover, // Gambar diatur proporsional
                  ),
                ),
                // Badge untuk ketersediaan
                Positioned(
                  top: 8, // Jarak dari atas
                  right: 8, // Jarak dari kiri
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10, // Padding horizontal
                      vertical: 6, // Padding vertikal
                    ),
                    decoration: BoxDecoration(
                      color: post.isAvailable ? active : inActive, // Warna badge
                      borderRadius: BorderRadius.circular(4), // Sudut melengkung badge
                    ),
                    child: Text(
                      post.isAvailable ? 'For Sale' : 'Sold Out', // Teks badge
                      style: badgetText, // Gaya teks dari app_theme
                    ),
                  ),
                ),
              ],
            ),
            // Judul
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                post.title,
                style: title2, // Gaya judul dari app_theme
              ),
            ),
            // Harga
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${post.price}', // Harga
                style: priceText2, // Gaya harga dari app_theme
              ),
            ),
               Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                timeAgoText, // Display the time ago text here
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ), // A subtle style for the timestamp
              ),
            ),
          ],
        ),
      ),
    );
  }
}
