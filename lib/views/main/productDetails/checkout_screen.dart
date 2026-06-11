import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_app/controllers/order_controller.dart';
import 'package:multi_app/provider/cart_notifier.dart';
import 'package:multi_app/views/main/productDetails/paypal_webview_screen.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final OrderController _orderController = OrderController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final totalAmount = ref.read(cartProvider.notifier).getTotal();
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

            //Total + BUTTON
            Container(
              padding: EdgeInsets.all(width * 0.045),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 24,
                    offset: Offset(0, 10),
                  ),
                ],
              ),

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: GoogleFonts.montserrat(
                          fontSize: width * 0.04,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.07,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(18),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        final orderId = await _orderController.placeOrder(
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
                        if (orderId == null) {
                          setState(() {
                            _isLoading = false;
                          });

                          print('Order Failed');
                          return;
                        }
                        final paymentData = await _orderController
                            .createPayPalPayment(
                              orderId: orderId,
                              amount: totalAmount,
                            );

                        if (paymentData == null) {
                          setState(() {
                            _isLoading = false;
                          });
                          print('Paypal payment creation failed');
                          return;
                        }
                        final approverUrl =
                            paymentData['approvalUrl'] as String;

                        final paypalOrderId =
                            paymentData['paypalOrderId'] as String;
                        setState(() {
                          _isLoading = false;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PaypalWebviewScreen(
                                approvalUrl: approverUrl,
                                onPaymentApproved: () async {
                                  final paymentCaptured = await _orderController
                                      .capturePayPalPayment(
                                        orderId: orderId,
                                        paypalOrderId: paypalOrderId,
                                      );

                                  if (paymentCaptured) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Payment Successfull, order completed',
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Payment capture, failed ',
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        );
                      },
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Place Order',
                              style: GoogleFonts.montserrat(
                                fontSize: width * 0.042,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
