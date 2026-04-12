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

        return SizedBox(
          height: 180,
          width: double.infinity,
          child: PageView.builder(
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];

              return Container(
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: Image.network(banner.imageUrl),
              );
            },
          ),
        );
      },
    );
  }
}
