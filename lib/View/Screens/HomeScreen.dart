import 'package:flutter/material.dart';
import 'package:foodie/View/Screens/CartProfileScreen.dart';
import 'package:foodie/View/Screens/MainHomeScreen.dart' as main_home;
import 'package:foodie/View/Screens/MessageScreen.dart';
import 'package:foodie/View/Screens/ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      main_home.MainHomeContentScreen(),
      ProfileScreen(),
      CartProfileScreen(),
      ChatScreen(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: screens[_selectedIndex]),
      bottomNavigationBar: Container(
        height: 90,
        color: Color(0xFFF54748),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            final icons = [
              Icons.home,
              Icons.person,
              Icons.shopping_cart,
              Icons.chat_bubble_outline,
            ];
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: Container(
                width: 60,
                height: 56,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Color(0xFFF54748),
                  borderRadius: isSelected
                      ? BorderRadius.circular(12)
                      : BorderRadius.zero,
                ),
                child: Icon(
                  icons[index],
                  color: isSelected ? Color(0xFFF54748) : Colors.white,
                  size: 30,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
