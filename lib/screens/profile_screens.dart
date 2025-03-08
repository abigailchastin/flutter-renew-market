import 'package:flutter/material.dart';
import 'package:flutter_application/constants/app_theme.dart';
import 'package:flutter_application/providers/user_provider.dart';
import 'package:flutter_application/widgets/profile_tabs.dart';
import 'package:provider/provider.dart';

class ProfileScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            // Profile Section (Image & Name)
            SizedBox(height: 20),
            Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD9D9D9),
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    size: 30,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                Text(userProvider.user!.name, style: title2), // Menggunakan nama dari UserProvider
              ],
            ),
            SizedBox(height: 20),
            // TabBar below profile image
            TabBar(
              indicatorColor: primary,
              labelColor: primary,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "My Sales"),
                Tab(text: "Favorites"),
                Tab(text: "Reviews"),
              ],
            ),
            // Tab Bar View
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: MySalesTab()),
                  Center(child: ReviewsTab()),
                  Center(child: FavoritesTab()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}