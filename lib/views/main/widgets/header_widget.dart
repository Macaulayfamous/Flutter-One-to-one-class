import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.02,
      ),

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/icons/searchBanner.jpeg'),
          fit: BoxFit.cover,
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'assets/icons/bell.png',
                  width: width * 0.08,
                  height: width * 0.08,
                ),
              ),
            ],
          ),

          SizedBox(height: height * 0.03),
          SizedBox(
            height: height * 0.06,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter product name",
                hintStyle: TextStyle(fontSize: 14, color: Color(0xFF7F7F7F)),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: height * 0.015,
                ),

                prefixIcon: Image.asset('assets/icons/searc1.png'),
                suffixIcon: Image.asset('assets/icons/cam.png'),
                fillColor: Colors.grey.shade200,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
