import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_app/provider/cart_notifier.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final _cartProvider = ref.read(cartProvider.notifier);
    final cartData = ref.watch(cartProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.18),
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/cartb.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: size.width * 0.08,
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Cart',
                  style: GoogleFonts.montserrat(
                    fontSize: size.width * 0.055,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: cartData.isEmpty
          ? Center(
              child: Text(
                'Your Shopping cart is empty',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: cartData.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = cartData.values.toList()[index];
                return Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.01,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.28,
                        height: size.height * 0.18,
                        margin: EdgeInsets.all(size.width * 0.02),
                        child: Image.network(item.imageUrl, fit: BoxFit.cover),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.015,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                maxLines: 1,
                                item.productName,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontSize: size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                item.category,
                                style: GoogleFonts.montserrat(
                                  fontSize: size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),

                              Text(
                                '\$${item.productPrice.toStringAsFixed(2)}',
                                style: GoogleFonts.montserrat(
                                  fontSize: size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink,
                                ),
                              ),

                              Container(
                                width: size.width * 0.34,
                                height: size.height * 0.055,
                                decoration: BoxDecoration(
                                  color: Color(0xFF102DE1),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _cartProvider.decrement(item.id);
                                      },
                                      icon: Icon(
                                        CupertinoIcons.minus,
                                        color: Colors.white,
                                      ),
                                    ),

                                    Text(
                                      item.quantity.toString(),
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _cartProvider.increment(item.id);
                                      },
                                      icon: Icon(
                                        CupertinoIcons.plus,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
