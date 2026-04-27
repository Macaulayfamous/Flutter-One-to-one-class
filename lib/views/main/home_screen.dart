
import 'package:flutter/material.dart';
import 'package:multi_app/views/main/widgets/banner_widget.dart';
import 'package:multi_app/views/main/widgets/header_widget.dart';
import 'package:multi_app/views/main/widgets/product_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderWidget(),
          BannerWidget(),
          ProductWidget(),
        ],
      )
    );
  }
}