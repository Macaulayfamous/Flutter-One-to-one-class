import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_app/provider/cart_notifier.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.015,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFEFF0F2)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: width * 0.12,
                      height: width * 0.12,
                      decoration: BoxDecoration(color: Color(0xFFFBF7F5)),
                      child: Icon(Icons.location_on, color: Colors.redAccent),
                    ),

                    SizedBox(width: width * 0.03),

                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Shipping Address',
                            style: GoogleFonts.montserrat(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: height * 0.005),
                          Text(
                            '21 Wanmac Street',
                            style: GoogleFonts.montserrat(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            'Benin city, edo state , nigeria',
                            style: GoogleFonts.lato(
                              fontSize: width * 0.035,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: height * 0.02),
            Text(
              'Your Itmes',
              style: GoogleFonts.montserrat(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.01),
            Expanded(
              child: ListView.builder(
                itemCount: cartData.length,
                itemBuilder: (context, index) {
                  final item = cartData.values.toList()[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: height * 0.015),
                    padding: EdgeInsets.all(width * 0.03),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Color(0xFFEFF0F2)),
                    ),

                    child: Row(
                      children: [
                        Container(
                          width: width * 0.18,
                          height: width * 0.19,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            child: Image.network(
                              item.imageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        SizedBox(width: width * 0.04),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.poppins(
                                  fontSize: width * 0.04,
                                ),
                              ),
                              Text(
                                item.category,
                                style: GoogleFonts.poppins(
                                  fontSize: width * 0.035,
                                  color: Colors.grey,
                                ),
                              ),

                              Text(
                                '\$${item.productPrice.toStringAsFixed(2)}',
                                style: GoogleFonts.poppins(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.pink,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
