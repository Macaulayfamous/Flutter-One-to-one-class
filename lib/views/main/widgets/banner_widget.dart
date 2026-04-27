import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multi_app/controllers/banner_controller.dart';
import 'package:multi_app/models/banner_model.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    super.initState();
    futureBanners = BannerController().fetchBaners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureBanners,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final banners = snapshot.data ?? [];

        if (banners.isEmpty) {
          return const Center(child: Text('No Banners found'));
        }

        return  CarouselSlider(items: banners.map((banner){
          return Padding(padding: EdgeInsets.symmetric(
            horizontal:  MediaQuery.of(context).size.width *0.025
            
          ),
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: Image.network(banner.imageUrl),
          ),
          );
        }).toList(), options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.22,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
        ));
      },
    );
  }
}
