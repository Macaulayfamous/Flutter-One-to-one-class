import 'package:flutter/material.dart';
import 'package:multi_app/views/main/account_screen.dart';
import 'package:multi_app/views/main/cart_screen.dart';
import 'package:multi_app/views/main/category_screen.dart';
import 'package:multi_app/views/main/favorite_screen.dart';
import 'package:multi_app/views/main/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List _pages = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    FavoriteScreen(),
    AccountScreen(),
  ];
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home.png', width: 30, height: 30),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/mart.png', width: 30, height: 30),
            label: 'CATEGORY',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/cart.png', width: 30, height: 30),
            label: 'CART',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/love.png', width: 30, height: 30),
            label: 'FAVORITE',
          ),

          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/user.png', width: 30, height: 30),
            label: 'ACCOUNT',
          ),
        ],
      ),

      body: _pages[_pageIndex],
    );
  }
}
