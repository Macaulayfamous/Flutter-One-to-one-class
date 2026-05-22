import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_app/controllers/order_controller.dart';
import 'package:multi_app/provider/cart_notifier.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  final OrderController _orderController = OrderController();
  @override
  Widget build(BuildContext context) {
    final cartPro = ref.read(cartProvider.notifier);
    final cartData = ref.watch(cartProvider);
    final totalAmount = cartPro.getTotal();
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
                                        cartPro.decrement(item.id);
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
                                        cartPro.increment(item.id);
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

      bottomSheet: totalAmount == 0.0
          ? Text('')
          : Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async {
                  await _orderController.placeOrder(
                    customerId: '12343',
                    vendorId: cartData.values.first.vendor,
                    productId: cartData.values.first.id,
                    productName: cartData.values.first.productName,
                    quantity: cartData.values.first.quantity,
                    price: cartData.values.first.productPrice,
                    deliveryAddress:
                        'Jovee close avenu benin city, edo state nigeria ',
                    phoneNumber: "+2348149106125",
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.blue),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CHECKOUT',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '\$$totalAmount',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
