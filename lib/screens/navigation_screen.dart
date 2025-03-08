import 'package:flutter/material.dart';
import 'package:flutter_application/constants/urls.dart';
import 'package:flutter_application/screens/add_screen.dart';
import 'package:flutter_application/screens/chat_list_screen.dart';
import 'package:flutter_application/screens/home_screen.dart';
import 'package:flutter_application/screens/profile_screens.dart';
import 'package:flutter_application/screens/search_screen.dart';



class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int screenIndex = 0; // Index of selected screen
  final screens = [
    HomeScreen(),
    SearchScreen(),
    AddScreen(),
    ChatListScreen(),
    ProfileScreens()
  ]; // Screen Lst

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(
          logoUrl,
          height: 40,
          ),
          centerTitle: true,
      ),
      body: SafeArea(
        child: screens.elementAt(screenIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screenIndex, // Show the correct item as selected
        onTap: (index) {
          setState(() {
            screenIndex = index; // Update screenIndex when an item is tapped
          });
        },
        selectedItemColor: Colors.green, // Color when the item is selected
        unselectedItemColor: Colors.grey, // Color when the item is unselected
        type: BottomNavigationBarType.fixed, // Keeps all items fixed (non-shifting)
        showUnselectedLabels: true, // Show labels for unselected items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), // Icon for Home
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined), // Icon for Search
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_outlined), // Icon for Add
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined), // Icon for Chat
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined), // Icon for Profile
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}